const functions = require("firebase-functions");
const cors = require("cors")({ origin: true });
const { getFirestore } = require("firebase-admin/firestore");
const { randomUUID } = require("crypto");

const OPENROUTER_API_URL =
  process.env.OPENROUTER_API_URL || "https://openrouter.ai/api/v1";
const OPENROUTER_API_KEY =
  process.env.OPENROUTER_API_KEY ||
  process.env.OPENAI_API_KEY ||
  (functions.config &&
    functions.config().openrouter &&
    functions.config().openrouter.key) ||
  (functions.config &&
    functions.config().openai &&
    (functions.config().openai.key || functions.config().openai.api_key)) ||
  "";
const OPENROUTER_MODEL =
  process.env.OPENROUTER_MODEL || "openai/gpt-4o-mini";
const OPENROUTER_HTTP_REFERER =
  process.env.OPENROUTER_HTTP_REFERER || "https://flutterflow.io";
const OPENROUTER_APP_TITLE = process.env.OPENROUTER_APP_TITLE || "MH Personal";

function mustPost(req, res) {
  if (req.method !== "POST") {
    res.status(405).json({ error: "Método não permitido. Use POST." });
    return false;
  }
  return true;
}

function readField(req, name) {
  if (req.body && typeof req.body === "object" && req.body[name] != null) {
    return req.body[name];
  }
  if (req.rawBody && Buffer.isBuffer(req.rawBody) && req.rawBody.length > 0) {
    try {
      const params = new URLSearchParams(req.rawBody.toString("utf8"));
      const val = params.get(name);
      if (val != null) {
        return val;
      }
    } catch (_) {
      // ignore
    }
  }
  if (typeof req.body === "string" && req.body.length > 0) {
    try {
      const params = new URLSearchParams(req.body);
      const val = params.get(name);
      if (val != null) {
        return val;
      }
    } catch (_) {
      // ignore
    }
  }
  if (req.query && req.query[name] != null) {
    return req.query[name];
  }
  return undefined;
}

function openRouterHeaders() {
  if (!OPENROUTER_API_KEY) {
    throw new Error(
      "OpenRouter API key not configured. Set OPENROUTER_API_KEY or functions.config().openrouter.key",
    );
  }
  return {
    "Content-Type": "application/json",
    Authorization: `Bearer ${OPENROUTER_API_KEY}`,
    "HTTP-Referer": OPENROUTER_HTTP_REFERER,
    "X-Title": OPENROUTER_APP_TITLE,
  };
}

async function openRouterChatCompletions({
  messages,
  model = OPENROUTER_MODEL,
  max_tokens,
  temperature,
  response_format,
}) {
  const resp = await fetch(`${OPENROUTER_API_URL}/chat/completions`, {
    method: "POST",
    headers: openRouterHeaders(),
    body: JSON.stringify({
      model,
      messages,
      ...(typeof max_tokens === "number" ? { max_tokens } : {}),
      ...(typeof temperature === "number" ? { temperature } : {}),
      ...(response_format ? { response_format } : {}),
    }),
  });
  const data = await resp.json().catch(() => ({}));
  if (!resp.ok) {
    const message =
      data?.error?.message ||
      data?.message ||
      `OpenRouter request failed (${resp.status})`;
    const err = new Error(message);
    err.status = resp.status;
    err.data = data;
    throw err;
  }
  return data;
}

function extractFirstJsonObject(text) {
  if (!text || typeof text !== "string") return null;
  const start = text.indexOf("{");
  const end = text.lastIndexOf("}");
  if (start < 0 || end <= start) return null;
  const maybe = text.slice(start, end + 1);
  try {
    return JSON.parse(maybe);
  } catch (_) {
    return null;
  }
}

exports.openrouterGenerateText = functions
  .region("southamerica-east1")
  .https.onRequest((req, res) => {
    cors(req, res, async () => {
      if (!mustPost(req, res)) return;
      try {
        const prompt = (readField(req, "prompt") ?? "").toString();
        if (!prompt) {
          return res.status(400).json({ error: "Parâmetro obrigatório: prompt" });
        }

        const data = await openRouterChatCompletions({
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7,
        });

        const text = data?.choices?.[0]?.message?.content ?? "";
        return res.status(200).json({
          text,
          usage: data?.usage ?? null,
        });
      } catch (err) {
        console.error("openrouterGenerateText error:", err);
        return res.status(500).json({
          error: "Falha ao gerar texto",
          details: err?.message || String(err),
        });
      }
    });
  });

exports.openrouterCountTokens = functions
  .region("southamerica-east1")
  .https.onRequest((req, res) => {
    cors(req, res, async () => {
      if (!mustPost(req, res)) return;
      try {
        const prompt = (readField(req, "prompt") ?? "").toString();
        if (!prompt) {
          return res.status(400).json({ error: "Parâmetro obrigatório: prompt" });
        }

        const data = await openRouterChatCompletions({
          messages: [{ role: "user", content: prompt }],
          temperature: 0,
          max_tokens: 1,
        });

        return res.status(200).json({
          totalTokens: data?.usage?.prompt_tokens ?? null,
          usage: data?.usage ?? null,
        });
      } catch (err) {
        console.error("openrouterCountTokens error:", err);
        return res.status(500).json({
          error: "Falha ao contar tokens",
          details: err?.message || String(err),
        });
      }
    });
  });

exports.openrouterTextFromImage = functions
  .region("southamerica-east1")
  .https.onRequest((req, res) => {
    cors(req, res, async () => {
      if (!mustPost(req, res)) return;
      try {
        const prompt = (readField(req, "prompt") ?? "").toString();
        const imageUrl = (readField(req, "imageUrl") ?? "").toString();
        const imageBase64 = (readField(req, "imageBase64") ?? "").toString();

        if (!prompt) {
          return res.status(400).json({ error: "Parâmetro obrigatório: prompt" });
        }
        if (!imageUrl && !imageBase64) {
          return res
            .status(400)
            .json({ error: "Parâmetro obrigatório: imageUrl ou imageBase64" });
        }

        const imagePart = imageUrl
          ? { type: "image_url", image_url: { url: imageUrl } }
          : {
              type: "image_url",
              image_url: { url: `data:image/jpeg;base64,${imageBase64}` },
            };

        const data = await openRouterChatCompletions({
          messages: [
            {
              role: "user",
              content: [{ type: "text", text: prompt }, imagePart],
            },
          ],
          temperature: 0.2,
        });

        const text = data?.choices?.[0]?.message?.content ?? "";
        return res.status(200).json({ text, usage: data?.usage ?? null });
      } catch (err) {
        console.error("openrouterTextFromImage error:", err);
        return res.status(500).json({
          error: "Falha ao processar imagem",
          details: err?.message || String(err),
        });
      }
    });
  });

exports.AIparaconversarcomosusers = functions
  .region("southamerica-east1")
  .https.onRequest((req, res) => {
    cors(req, res, async () => {
      if (!mustPost(req, res)) return;
      try {
        const userId = (readField(req, "userId") ?? "").toString().trim();
        const mensagem = (readField(req, "mensagem") ?? "").toString().trim();
        if (!userId || !mensagem) {
          return res.status(400).json({
            error: "Parâmetros obrigatórios: userId, mensagem",
          });
        }

        const system = [
          "Você é o MH Personal Trainer (PT-BR).",
          "Responda sempre em português.",
          "Se o usuário pedir um treino/rotina/ficha (ex.: 'me monta um treino', 'rotina de musculação', 'plano de treino'), retorne um JSON com type='treino' e inclua:",
          "- nomeDaRotina (string curta)",
          "- objetivoDaRotina (string curta)",
          "- treino (lista de strings, 6 a 12 itens, formato: 'Exercício - séries x repetições - descanso')",
          "Caso contrário, retorne JSON com type='resposta' e inclua 'resposta' (string).",
          "Responda APENAS com JSON válido.",
        ].join("\n");

        const data = await openRouterChatCompletions({
          messages: [
            { role: "system", content: system },
            { role: "user", content: mensagem },
          ],
          temperature: 0.6,
          response_format: { type: "json_object" },
        });

        const raw = data?.choices?.[0]?.message?.content ?? "";
        const parsed = extractFirstJsonObject(raw);

        if (parsed && parsed.type === "treino" && parsed.treino) {
          const treinoUid = randomUUID();
          const treinoCompleto = {
            nomeDaRotina: (parsed.nomeDaRotina ?? "Treino sugerido").toString(),
            objetivoDaRotina: (parsed.objetivoDaRotina ?? "").toString(),
            treino: Array.isArray(parsed.treino)
              ? parsed.treino.map((t) => String(t))
              : [],
          };

          const db = getFirestore();
          const docRef = db.doc(`users/${userId}/createTreinos/${treinoUid}`);
          await docRef.set(
            {
              uidTreinos: treinoUid,
              nomeDoTreino: treinoCompleto.nomeDaRotina,
              obsInstrucao: treinoCompleto.objetivoDaRotina,
              treino: treinoCompleto.treino,
              daRotina: true,
              dosTreinos: false,
              created_at: new Date(),
            },
            { merge: true },
          );

          return res.status(200).json({
            response: {
              treinoUid,
              treinoCompleto,
            },
          });
        }

        const resposta =
          (parsed && parsed.type === "resposta" && parsed.resposta) ||
          (parsed && parsed.resposta) ||
          raw;

        return res.status(200).json({
          response: {
            resposta: (resposta ?? "").toString(),
          },
        });
      } catch (err) {
        console.error("AIparaconversarcomosusers error:", err);
        return res.status(500).json({
          error: "Falha ao processar conversa",
          details: err?.message || String(err),
        });
      }
    });
  });
