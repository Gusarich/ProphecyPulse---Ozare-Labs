const functions = require("firebase-functions");
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const path = require("path");
const { compileFunc } = require("@ton-community/func-js");
const { readFileSync, readdir } = require("fs");
const cors = require("cors");
const corsOptions = {
  origin: "*",
  credentials: true, //access-control-allow-credentials:true
  optionSuccessStatus: 200,
};
app.use(cors(corsOptions));
app.use(bodyParser.json());

// Define routes for each file
app.get("/api/contract/bet", async (req, res) => {
  try {
    let result = await compileFunc({
      targets: ["stdlib.fc", "opcodes.fc", "bet.fc"],
      sources: (target) =>
        readFileSync(path.join(__dirname, "src/func/") + target).toString(),
    });
    if (result.status === "error") {
      throw result.message;
    }
    res.send(result.codeBoc);
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

app.get("/api/contract/event", async (req, res) => {
  try {
    let result = await compileFunc({
      targets: ["stdlib.fc", "opcodes.fc", "event.fc"],
      sources: (target) =>
        readFileSync(path.join(__dirname, "src/func/") + target).toString(),
    });
    if (result.status === "error") {
      throw result.message;
    }
    res.send(result.codeBoc);
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

// Start the server
app.get("/", (req, res) => {
  res.send("This server is an API for contracts");
});

exports.app = functions.https.onRequest(app);
