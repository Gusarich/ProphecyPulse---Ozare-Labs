const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const path = require("path");
const { compileFunc } = require("@ton-community/func-js");
const { readFileSync } = require("fs");
const cors = require("cors");
const corsOptions = {
  origin: "*",
  credentials: true, //access-control-allow-credentials:true
  optionSuccessStatus: 200,
};
const { Event } = require("./wrappers/Event");
const { TonClient, WalletContractV3R2 } = require("ton");
const { mnemonicToWalletKey } = require("ton-crypto");
require("dotenv").config();
app.use(cors(corsOptions));
app.use(bodyParser.json());

const betCache = {};
const eventCache = {};

// Define routes for each file
app.get("/api/contract/bet", async (req, res) => {
  try {
    if (betCache.codeBoc) {
      return res.send(betCache.codeBoc);
    }

    let result = await compileFunc({
      targets: ["stdlib.fc", "opcodes.fc", "bet.fc"],
      sources: (target) =>
        readFileSync(path.join(__dirname, "func/") + target).toString(),
    });
    if (result.status === "error") {
      throw result.message;
    }
    betCache.codeBoc = result.codeBoc;
    res.send(result.codeBoc);
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

app.get("/api/contract/event", async (req, res) => {
  try {
    if (eventCache.codeBoc) {
      return res.send(eventCache.codeBoc);
    }
    let result = await compileFunc({
      targets: ["stdlib.fc", "opcodes.fc", "event.fc"],
      sources: (target) =>
        readFileSync(path.join(__dirname, "func/") + target).toString(),
    });
    if (result.status === "error") {
      throw result.message;
    }
    eventCache.codeBoc = result.codeBoc;
    res.send(result.codeBoc);
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

const getClient = async (req) => {
  const client = new TonClient({
    // endpoint: 'https://toncenter.com/api/v2/jsonRPC',
    endpoint: "https://testnet.toncenter.com/api/v2/jsonRPC",
    apiKey: "3ee6e55a86a7d611e3670f650d4194656157ecf100d5d284dcdb9d873d8fb37d",
  });
  return client;
};

const getSenderFromMnemonic = async (mnemonic, client) => {
  const keypair = await mnemonicToWalletKey(mnemonic.split(" "));
  const wallet = WalletContractV3R2.create({
    publicKey: keypair.publicKey,
    workchain: 0,
  });
  const sender = wallet.sender(
    client.provider(wallet.address, wallet.init),
    keypair.secretKey
  );
  return sender;
};

app.post("/api/contract/start", async (req, res) => {
  try {
    const client = await getClient(req);
    const eventNew = await Event.getInstance(client, req.body.address);
    const sender = await getSenderFromMnemonic(process.env.MNEMONIC1, client);
    await eventNew.startEvent(sender);
    const response = {
      status: "success",
      message: "Event started successfully",
      data: null,
    };
    res.status(200).json(response);
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

app.post("/api/contract/finish", async (req, res) => {
  try {
    const client = await getClient(req);
    const sender = await getSenderFromMnemonic(process.env.MNEMONIC1, client);
    const event = await Event.getInstance(client, req.body.address);
    const result = req.body.result;
    await event.finishEvent(sender, result);
    res.send("Event finished successfully");
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

app.get("/api/livescore/matches", async (req, res) => {
  try {
    const date = req.body.date;
    const sport = req.body.sport;
    const listByDateResponse = await axios({
      method: "GET",
      url: "https://livescore6.p.rapidapi.com/matches/v2/list-by-date",
      params: { Category: sport, Date: date, Timezone: "+0" },
      headers: {
        "X-RapidAPI-Key": process.env.RAPIDAPI_KEY,
        "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
      },
    });

    const events = listByDateResponse.data.Stages.flatMap(
      (stage) => stage.Events
    );
    
    const results = [];

    for (const event of events) {
      const eid = event.Eid;
      const t1 = event.T1[0].Nm;
      const t2 = event.T2[0].Nm;
      results.push({
        Eid: eid,
        T1: t1,
        T2: t2,
        match_time: event.Esd,
      });
    }

    res.send(results);
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal server error");
  }
});

app.get("/", (req, res) => {
  res.send("This server is an API for contracts");
});

// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

module.exports = app;
