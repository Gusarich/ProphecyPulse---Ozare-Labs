const functions = require("firebase-functions");
const app = require("./src/server-new");
exports.app = functions.https.onRequest(app);