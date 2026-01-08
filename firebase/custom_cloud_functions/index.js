const { getApps, initializeApp } = require("firebase-admin/app");
if (getApps().length === 0) {
  initializeApp();
}

const createInscricao = require("./create_inscricao.js");
exports.createInscricao = createInscricao.createInscricao;

const openRouterAi = require("./openrouter_ai.js");
exports.openrouterGenerateText = openRouterAi.openrouterGenerateText;
exports.openrouterCountTokens = openRouterAi.openrouterCountTokens;
exports.openrouterTextFromImage = openRouterAi.openrouterTextFromImage;
exports.AIparaconversarcomosusers = openRouterAi.AIparaconversarcomosusers;
