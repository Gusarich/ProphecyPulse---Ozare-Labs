
const bodyParser = require('body-parser');

const express = require('express');
const index_1 = require("ton-crypto");
const index_2 = require("ton");
const index_3 = require("ton-core")
const Event_1 = require("./wrappers/Event");
const Bet = require('./wrappers/Bet');
const Livescore_1 = require("./wrappers/Livescore");
require('dotenv').config()

// start the server
const port = 3000;
const app = express();
app.use(bodyParser.json());

app.listen(port, () => {
    console.log(`Server running on port ${port}.`);
});

let eventNew, senderNew;

const getClient = async (req) => {
    const client = new index_2.TonClient({
        // endpoint: 'https://toncenter.com/api/v2/jsonRPC',
        endpoint: 'https://testnet.toncenter.com/api/v2/jsonRPC',
        apiKey: req.body.tonApiKey,
    });
    return client;
}

const getSenderFromMnemonic = async (mnemonic, client) => {
    const keypair = await index_1.mnemonicToWalletKey(mnemonic.split(" "));
    const wallet = index_2.WalletContractV3R2.create({ publicKey: keypair.publicKey, workchain: 0 });
    const sender = wallet.sender(client.provider(wallet.address, wallet.init), keypair.secretKey);
    return sender;
}

// API endpoint to create a new event
app.post('/event', async (req, res) => {
    try {
        // Configure the Ton client
        const client = await getClient(req);
        const mnemonic = process.env.MNEMONIC1;

        const keypair = await index_1.mnemonicToWalletKey(mnemonic.split(" "));
        console.log(keypair.publicKey);
        const wallet = index_2.WalletContractV3R2.create({ publicKey: keypair.publicKey, workchain: 0 });

        console.log(`Wallet address ${wallet.address}`);

        const sender = wallet.sender(client.provider(wallet.address, wallet.init), keypair.secretKey);
        senderNew = sender;
        const event = await Event_1.Event.create(client, wallet.address, req.body.type);
        await event.deploy(sender);

        // Get the Event address
        const addr = event.address;
        console.log(`event address: ${addr}`);

        const response = {
            status: 'success',
            message: 'New event created successfully',
            data: {
                address: `${addr}`,
            },
        };
        eventNew = event;
        res.status(200).json(response);
    } catch (error) {
        console.log(error);
        const response = {
            status: 'error',
            message: error.message,
            data: null,
        };
        res.status(400).json(response);
    }
});

// API endpoint to place bet on an event.
app.post('/event/:address/bet', async (req, res) => {
    const { via, outcome, amount } = req.body;
    const client = await getClient(req);
    const eventNew = await Event_1.Event.getInstance(client, req.params.address);
    const sender = await getSenderFromMnemonic(via, client);
    try {
        await eventNew.bet(sender, outcome, amount);
        res.status(200).send('Bet placed successfully.');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error placing bet.');
    }
});

// API endpoint to start an event
app.post('/event/:address/start', async (req, res) => {
    try {
        const client = await getClient(req);
        const eventNew = await Event_1.Event.getInstance(client, req.params.address);
        const sender = await getSenderFromMnemonic(process.env.MNEMONIC1, client);
        await eventNew.startEvent(sender);
        const response = {
            status: 'success',
            message: 'Event started successfully',
            data: null,
        };
        res.status(200).json(response);
    } catch (error) {
        console.log(error);
        const response = {
            status: 'error',
            message: error.message,
            data: null,
        };
        res.status(400).json(response);
    }
});

// API endpoint to finish an event
app.post('/event/:address/finish', async (req, res) => {
    try {
        const client = await getClient(req);
        const senderNew = await getSenderFromMnemonic(process.env.MNEMONIC1, client);
        const eventNew = await Event_1.Event.getInstance(client, req.params.address);
        const result = req.body.result;
        await eventNew.finishEvent(senderNew, result);
        const response = {
            status: 'success',
            message: 'Event finished successfully',
            data: null,
        };
        res.status(200).json(response);
    } catch (error) {
        console.log(error);
        const response = {
            status: 'error',
            message: error.message,
            data: null,
        };
        res.status(400).json(response);
    }
});

// API endpoint to get total bets
app.get('/event/total_bets', async (req, res) => {
    try {
        const totalBets = await eventNew.getTotalBets();
        res.status(200).send(`BIGINT::${totalBets}`);
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal server error');
    }
});

// API endpoint to check start/finish event.
app.get('/event/:address/started_finished', async (req, res) => {
    try {
        const client = await getClient(req);
        const eventNew = await Event_1.Event.getInstance(client, req.params.address);
        const startedFinished = await eventNew.getStartedFinished();
        res.status(200).json({ startedFinished });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal server error');
    }
});

// API endpoint to get winner
app.get('/event/:address/winner', async (req, res) => {
    try {
        const client = await getClient(req);
        const eventNew = await Event_1.Event.getInstance(client, req.params.address);
        const winner = await eventNew.getWinner();
        res.status(200).json({ winner });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal server error');
    }
});

// API endpoint to get all matches by date
app.get('/matches/:date', async (req, res) => {
    try {
        const { date } = req.params;
        const { category } = req.query;
        const allMatches = await Livescore_1.getAllMatchesByDate(date, category);
        res.status(200).json(allMatches);
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal server error');
    }
});

// API endpoint to get match details
app.get('/matches/:eid/details', async (req, res) => {
    try {
        const { eid } = req.params;
        const { category } = req.query;
        const details = await Livescore_1.getMatchDetails(eid, category);
        res.status(200).json({ details });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal server error');

    }
});
// API endpoint to get match status
app.get('/matches/:eid/status', async (req, res) => {
    try {
        const { eid } = req.params;
        const { category } = req.query;
        const status = await Livescore_1.getMatchStatus(eid, category);
        res.status(200).json({ status });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal server error');

    }
});
