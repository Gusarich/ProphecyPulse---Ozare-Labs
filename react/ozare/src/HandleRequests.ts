import { TonConnect } from "@tonconnect/sdk";
import { TonClient, Address } from "ton";
import { Event } from "./wrappers/Event";

const getClient = async () => {
  const client = new TonClient({
    // endpoint: 'https://toncenter.com/api/v2/jsonRPC',
    endpoint: "https://testnet.toncenter.com/api/v2/jsonRPC",
    apiKey: "3ee6e55a86a7d611e3670f650d4194656157ecf100d5d284dcdb9d873d8fb37d",
  });
  return client;
};

async function handleRequest(
  payload: any,
  sender: TonConnect,
  address: string,
) {
  const client = await getClient();
  let type = "create_event";
  if (payload && payload.type) type = payload.type;
  if (type === "create_event") {
    try {
      const uid = payload?.uid || Math.floor(Math.random() * 1000000);
      const event = await Event.create(client, Address.parse(address), uid);
      await event.deploy(sender);
      return event.address.toRawString();
    } catch (e) {
      console.log(e);
      return null;
    }
  }

  const event = await Event.getInstance(client, payload.event_address);

  let result: any;

  switch (type) {
    case "start_event": {
      try {
        await event.startEvent(sender);
        result = {
          status: "success",
          message: "Event started successfully",
          data: null,
        };
      } catch (error) {
        console.error(error);
        throw new Error("Error starting event");
      }
      break;
    }
    case "finish_event": {
      try {
        const resultData = payload?.result;
        await event.finishEvent(sender, resultData);
        result = {
          status: "success",
          message: "Event finished successfully",
          data: null,
        };
      } catch (error) {
        console.error(error);
        result = {
          status: "error",
          message: "Error finishing event",
          data: error,
        };
      }
      break;
    }
    case "place_bet": {
      try {
        const { outcome, amount } = payload;
        await event.bet(sender, outcome, amount);
        result = {
          status: "success",
          message: "Bet placed successfully",
        };
      } catch (error) {
        console.error(error);
        result = {
          status: "error",
          message: "Error placing bet",
          data: error,
        };
      }
      break;
    }
    case "total_bets": {
      try {
        const totalBets = await event.getTotalBets();
        result = {
          status: "success",
          message: "Total bets retrieved successfully",
          data: totalBets,
        };
      } catch (error) {
        console.error(error);
        result = {
          status: "error",
          message: "Error retrieving total bets",
          data: error,
        };
      }
      break;
    }
    case "started_finished": {
      try {
        const startedFinished = await event.getStartedFinished();
        result = {
          status: "success",
          message: "Started/Finished status retrieved successfully",
          data: startedFinished,
        };
      } catch (error) {
        console.error(error);
        result = {
          status: "error",
          message: "Error retrieving started/finished status",
          data: error,
        };
      }
      break;
    }
    case "winner": {
      try {
        const winner = await event.getWinner();
        result = {
          status: "success",
          message: "Winner retrieved successfully",
          data: winner,
        };
      } catch (error) {
        console.error(error);
        result = {
          status: "error",
          message: "Error retrieving winner",
          data: error,
        };
      }
      break;
    }
    default: {
      throw new Error("Invalid transaction action");
    }
  }

  return result;
}

export default handleRequest;
