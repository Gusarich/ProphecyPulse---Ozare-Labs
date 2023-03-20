import { TonConnect } from "@tonconnect/sdk";
import { TonClient, Address } from "ton";
import { Payload, Response } from "./IPayloadResponse";
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
  payload: Payload,
  sender: TonConnect,
  sender_address: string
): Promise<Response> {
  const client = await getClient();

  let event_exists = true;
  try {
    const contract_address = await Event.getContractAddress(
      Address.parse(sender_address),
      payload?.uid || Math.floor(Math.random() * 1000000)
    );
    await Event.getInstance(client, contract_address);
  } catch (e) {
    console.log(e);
    event_exists = false;
  }

  if (!event_exists) {
    try {
      const uid = payload?.uid || Math.floor(Math.random() * 1000000);
      const event = await Event.createDeployBet(
        client,
        sender,
        Address.parse(sender_address),
        uid,
        false,
        BigInt((payload?.amount || 0) * 1e9)
      );
      return {
        status: "success",
        message: "Event created successfully",
        data: {
          address: event.address.toString(),
          uid,
        },
      };
    } catch (e) {
      console.log(e);
      return {
        status: "error",
        message: "Error creating event",
        data: e,
      };
    }
  } else {
    // place the bet
    const contract_address = await Event.getContractAddress(
      Address.parse(sender_address),
      payload?.uid || Math.floor(Math.random() * 1000000)
    );
    const event = await Event.getInstance(client, contract_address);
    const { outcome, amount } = payload as any;
    await event.bet(sender, outcome, BigInt(amount * 1e9));
    return {
      status: "success",
      message: "Bet placed successfully",
    };
  }
  /*
  let type = "create_event";
  if (payload && payload.type) type = payload.type;
  if (type === "create_event") {
    try {
      const uid = payload?.uid || Math.floor(Math.random() * 1000000);
      const event = await Event.create(client, Address.parse(sender_address), uid);
      await event.deploy(sender);
      return {
        status: "success",
        message: "Event created successfully",
        data: {
          address: event.address.toString(),
          uid,
        },
      };
    } catch (e) {
      console.log(e);
      return {
        status: "error",
        message: "Error creating event",
        data: e,
      };
    }
  }

  const event = await Event.getInstance(
    client,
    Address.parse(payload.address || "")
  );

  let result: Response;

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
        const resultData = (payload as any).result;
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
        const { outcome, amount } = payload as any;
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
  */
}

export default handleRequest;
