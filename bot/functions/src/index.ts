import * as functions from 'firebase-functions';
import { bot } from './bot';

exports.bot = functions.https.onRequest(async (request, response) => {
  bot.handleUpdate(request.body, response).then(() => {
    response.status(200).send();  // Now it will run on firebase functions
  }).catch((err) => {
    console.error(err);
    response.status(500).send();
  });
});