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
        readFileSync(
          path.join(__dirname, "func/") + target
        ).toString(),
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
        readFileSync(
          path.join(__dirname, "func/") + target
        ).toString(),
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

// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
