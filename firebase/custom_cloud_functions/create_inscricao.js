/**
 * Cloud Function: Cria Assinatura Stripe Padrão (sem Connect)
 * ESTRUTURA BASEADA ESTATICAMENTE EM createPaymentIntent.
 */
const functions = require("firebase-functions");
const cors = require("cors")({ origin: true });
const stripeSecret =
  process.env.STRIPE_SECRET_KEY ||
  (functions.config && functions.config().stripe && functions.config().stripe.secret) ||
  "";

if (!stripeSecret) {
  console.warn(
    "Stripe secret key not found. Set STRIPE_SECRET_KEY env var or functions.config().stripe.secret"
  );
}

const stripe = require("stripe")(stripeSecret, {
  apiVersion: "2022-11-15",
});

exports.createInscricao = functions
  .region("southamerica-east1") // Mesma região
  .https.onRequest((req, res) => {
    // Usando req, res
    cors(req, res, async () => {
      // Mesma estrutura CORS

      // Mesmo check de método
      if (req.method !== "POST") {
        return res
          .status(405)
          .json({ error: "Método não permitido. Use POST." });
      }

      // Mesmo bloco try/catch
      try {
        // Extrai os parâmetros NECESSÁRIOS para ASSINATURA NORMAL
        const { email, name, priceId } = req.body;

        // Valida os parâmetros NECESSÁRIOS para ASSINATURA NORMAL
        if (!email || !priceId) {
          // Mesma estrutura de erro 400
          return res
            .status(400)
            .json({
              error:
                "Parâmetros obrigatórios ausentes. É necessário: email, priceId.",
            });
        }

        // --- INÍCIO DA LÓGICA ESPEĆIFICA DA ASSINATURA ---
        //    (Substitui a lógica do Payment Intent)

        // 1. Encontrar ou Criar Cliente Stripe
        let customer;
        const existingCustomers = await stripe.customers.list({
          email: email,
          limit: 1,
        });
        if (existingCustomers.data.length > 0) {
          customer = existingCustomers.data[0];
          if (name && customer.name !== name) {
            // Atualiza nome se necessário
            await stripe.customers.update(customer.id, { name: name });
          }
        } else {
          customer = await stripe.customers.create({
            email: email,
            name: name,
          });
        }

        // 2. Criar a Assinatura Stripe (lógica principal)
        const subscription = await stripe.subscriptions.create({
          customer: customer.id,
          items: [{ price: priceId }],
          payment_behavior: "default_incomplete",
          payment_settings: { save_default_payment_method: "on_subscription" },
          expand: ["latest_invoice.payment_intent"],
          // SEM transfer_data, SEM application_fee_amount aqui
        });

        // 3. Extrair Client Secret da primeira fatura (essencial pro frontend)
        const clientSecret =
          subscription.latest_invoice?.payment_intent?.client_secret;

        // 4. Validar se o clientSecret foi obtido
        if (!clientSecret) {
          console.error(
            `createSubscriptionNormal: Não foi possível obter client_secret para sub ${subscription.id}.`,
          );
          // Retorna erro 500 com estrutura similar
          return res.status(500).json({
            error: "Erro ao processar assinatura",
            details:
              "Não foi possível obter os detalhes de pagamento da primeira fatura.",
          });
        }

        // --- FIM DA LÓGICA ESPEĆIFICA DA ASSINATURA ---

        // Retorna sucesso com os dados da ASSINATURA
        // Mantendo a chave 'success: true' como no seu exemplo
        return res.status(200).json({
          success: true,
          subscriptionId: subscription.id, // ID da Assinatura
          clientSecret: clientSecret, // Client Secret para confirmar 1º pagamento
          customerId: customer.id, // ID do Cliente criado/encontrado
        });
      } catch (err) {
        // Usando 'err' e mesma estrutura do catch
        // Mesmo log de erro
        console.error("Erro ao criar Assinatura:", err); // Mensagem de log ajustada
        // Mesma estrutura de resposta de erro 500
        return res.status(500).json({
          error: "Erro ao criar Assinatura", // Mensagem de erro ajustada
          details: err.message,
        });
      }
    });
  });
