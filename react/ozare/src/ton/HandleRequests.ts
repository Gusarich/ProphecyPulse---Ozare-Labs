import { TonConnect } from "@tonconnect/sdk";
import Swal from "sweetalert2";
import { TonClient, Address } from "ton";
import { Payload, Response } from "./IPayloadResponse";
import { Bet } from "./wrappers/Bet";
import { Event } from "./wrappers/Event";

const ORACLE = Address.parse(
  "kQAAipGfZ0cd1PXdEV4c-PesBfiBwmMCIaZklx9Y16A_76XU"
);

const getClient = async () => {
  const client = new TonClient({
    // endpoint: 'https://toncenter.com/api/v2/jsonRPC',
    endpoint: "https://testnet.toncenter.com/api/v2/jsonRPC",
    apiKey: "3ee6e55a86a7d611e3670f650d4194656157ecf100d5d284dcdb9d873d8fb37d",
  });
  return client;
};

async function checkIfUserAlreadyBet(
  client: TonClient,
  event: Event,
  sender_address: Address,
  show_alert = true
) {
  const outcome = true;
  const betAddress = await event.getBetAddress(sender_address, outcome);
  const betAddressOpposite = await event.getBetAddress(
    sender_address,
    !outcome
  );
  const betState = await client.getContractState(betAddress);
  const betStateOpposite = await client.getContractState(betAddressOpposite);
  if (betState.code !== null) {
    // bet exists, close it
    if (show_alert)
      Swal.fire({ icon: "info", text: "You have already bet on this event" });
    return betAddress;
  }
  if (betStateOpposite.code !== null) {
    // bet exists, close it
    if (show_alert)
      Swal.fire({ icon: "info", text: "You have already bet on this event" });
    return betAddressOpposite;
  }
  return false;
}



async function handleCreateEvent(
  payload: Payload,
  sender: TonConnect,
  sender_address: Address
) {
  const client = await getClient();
  if (!payload) {
    payload = {
      type: "place_bet",
      uid: Math.floor(Math.random() * 1000000),
      amount: 1,
      outcome: false,
    };
  }
  const {
    uid,
    amount,
    outcome,
  }: {
    uid?: number;
    amount?: any;
    outcome?: any;
  } = payload;
  let event_exists = true;
  try {
    const contract_address = await Event.getContractAddress(ORACLE, uid);
    await Event.getInstance(client, contract_address);
    console.log("Contract found");
  } catch (e) {
    console.log("Contract not found");
    event_exists = false;
  }

  if (!event_exists) {
    const res = await Swal.fire({
      title: `Note`,
      text: `You are the first to bet on this event. Do you want to create it? It would cost you 0.25 TON`,
      showCancelButton: true,
      confirmButtonText: `Yes`,
    });
    if (!res.isConfirmed) {
      return {
        status: "error",
        message: "Event creation cancelled",
      };
    }
    try {
      // const event = await Event.deployBet(
      //   client,
      //   sender,
      //   ORACLE,
      //   uid,
      //   outcome,
      //   BigInt((amount || 0) * 1e9)
      // );
      const event = await Event.create(client, ORACLE, uid);
      await event.deploy(sender);
      await event.bet(sender, outcome, BigInt(amount * 1e9));
      return {
        status: "success",
        message: "Event created and bet placed successfully",
        contract_address: event.address.toString(),
        uid,
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
    try {
      const contract_address = await Event.getContractAddress(ORACLE, uid);
      const event = await Event.getInstance(client, contract_address);
      // check if !outcome betAddress exists on chain
      const already_bet = await checkIfUserAlreadyBet(
        client,
        event,
        sender_address
      );
      if (already_bet) {
        Swal.fire({ icon: "info", text: "You have already bet on this event" });
        return {
          status: "error",
          message: "You have already bet on this event",
        };
      }
      await event.bet(sender, outcome, BigInt(amount * 1e9));
      return {
        status: "success",
        message: "Bet placed successfully",
        contract_address: event.address.toString(),
        uid,
      };
    } catch (e) {
      console.log(e);
      return {
        status: "error",
        message: "Error placing bet",
        data: e,
      };
    }
  }
}

async function handleClaimBet(
  payload: Payload,
  sender: TonConnect,
  sender_address: Address
) {
  console.log("Claiming bet", payload);
  try {
    const client = await getClient();
    const contract_address = await Event.getContractAddress(
      ORACLE,
      payload?.uid || Math.floor(Math.random() * 1000000)
    );
    const event = await Event.getInstance(client, contract_address);
    const bet_address = await checkIfUserAlreadyBet(
      client,
      event,
      sender_address,
      false
    );
    if (bet_address === false) {
      Swal.fire({
        text: "You have not bet on this event, so you cannot claim your bet",
        icon: "info",
      });
      return {
        status: "error",
        message: "Bet hasn't been placed",
      };
    }
    console.log(bet_address.toString(), bet_address.toRawString());
    const bet = new Bet(bet_address, client);
    await bet.close(sender);
    return {
      status: "success",
      message: "Bet claimed successfully",
    };
  } catch (e) {
    console.log(e);
    return {
      status: "error",
      message: "Error claiming bet",
      data: e,
    };
  }
}

async function handleRequest(
  payload: Payload,
  sender: TonConnect,
  sender_address: string
): Promise<Response> {
  let no_type = payload?.type === undefined;
  if (no_type || payload?.type === "place_bet") {
    return await handleCreateEvent(
      payload,
      sender,
      Address.parse(sender_address)
    );
  } else if (payload?.type === "claim_bet") {
    return await handleClaimBet(payload, sender, Address.parse(sender_address));
  } else {
    return {
      status: "error",
      message: "Invalid request type",
    };
  }
}

export default handleRequest;
