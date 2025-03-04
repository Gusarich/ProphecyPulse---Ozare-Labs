import { useEffect, useState } from "react";
import {
  TonConnectButton,
  useTonWallet,
  useTonAddress,
  useTonConnectUI,
} from "@tonconnect/ui-react";
import handleRequest from "../HandleRequests";
import { Payload, Response } from "../IPayloadResponse";
import Swal from "sweetalert2";

function WalletPage() {
  const userFriendlyAddress = useTonAddress();
  const wallet = useTonWallet();
  const [tonConnectUI] = useTonConnectUI();
  const [payload, setPayload] = useState<Payload>();
  const [transactionComplete, setTransactionComplete] = useState(false);
  const [transactionOnGoing, setTransactionOnGoing] = useState(false);
  const [showSendTransaction, setShowSendTransaction] = useState(true);
  const [response, setResponse] = useState<Response>();

  function redirect(response: Response) {
    if (userFriendlyAddress?.length > 0 && wallet?.name) {
      window.parent.postMessage(
        {
          address: userFriendlyAddress,
          walletName: wallet?.name,
          response,
        },
        "*"
      );
    }
  }

  const handleClick = async () => {
    setTransactionOnGoing(true);
    const response = await handleRequest(
      payload as any,
      (tonConnectUI as any).connector,
      userFriendlyAddress
    );
    if (response.status === "success") {
      console.log(response);
      setTransactionComplete(true);
      setResponse(response);
      redirect(response);
    } else {
      Swal.fire({
        icon: "error",
        text: "You have cancelled the transaction or an error has occured",
      });
      console.log(response);
    }
    setTransactionOnGoing(false);
  };

  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);

    // if the url has a connect param, hide the send transaction button
    // url sample: http://localhost:3000/?connect=true
    if (urlParams.get("connect")) {
      setShowSendTransaction(false);
    }

    let type = urlParams.get("type");
    if (!type) type = "place_bet";
    let amount: any = urlParams.get("amount");
    let outcome: any = urlParams.get("outcome");
    let take_input: any = urlParams.get("take_input");
    if (type === "place_bet") {
      if (amount) {
        amount = parseFloat(amount);
      } else if (take_input) {
        amount = parseFloat(prompt("Enter amount in TON") as string);
      }
      if (outcome) {
        outcome = outcome === "0";
      } else if (take_input) {
        outcome = prompt("Enter outcome") === "0";
      }
    }
    let uid: any = urlParams.get("uid");

    if (uid) {
      uid = parseInt(uid);
    }
    const payload: Payload = {
      type,
      amount,
      outcome,
      uid,
    };

    if (type === "place_bet" && amount && outcome && uid) {
      setPayload(payload);
    }
    if (type === "claim_bet" && uid) {
      setPayload(payload);
    }
    // sample url: https://ozare-final.vercel.app/ton/?type=place_bet&amount=1&outcome=0&uid=9741
    // bet_claim_url: https://ozare-final.vercel.app/ton/?type=claim_bet&uid=9741
  }, [userFriendlyAddress, tonConnectUI, wallet?.name]);

  return transactionComplete ? (
    <div className="flex bg-white justify-center items-center h-screen w-screen">
      <div className="flex flex-col">
        <span className="text-4xl text-center">Transaction complete</span>
        <span className="text-md text-center">
          Redirecting back to parent window...
        </span>
        <pre>{JSON.stringify(response, null, 2)}</pre>
      </div>
    </div>
  ) : (
    <div className="flex bg-sky-50 justify-center items-center h-screen">
      <div>
        <div className="flex my-10 justify-center w-full">
          <TonConnectButton />
        </div>
        <div className="flex flex-col">
          <span className="pt-4 text-center">
            Address:
            {userFriendlyAddress
              ? userFriendlyAddress
              : " Please Connect wallet"}
          </span>
          <span className="pb-4 text-center">
            Wallet Name:
            {wallet ? wallet?.name : " Please Connect wallet"}
          </span>
          <div className="flex justify-center">
            {showSendTransaction && (
              <button
                disabled={
                  !(userFriendlyAddress?.length > 0) || transactionOnGoing
                }
                onClick={handleClick}
                className="px-8 py-4 rounded-2xl  bg-sky-500 text-white disabled:bg-gray-300"
              >
                {transactionOnGoing ? "Processing..." : "Send transaction"}
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default WalletPage;
