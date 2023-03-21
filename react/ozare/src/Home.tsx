import { useEffect, useState } from "react";
import {
  TonConnectButton,
  useTonWallet,
  useTonAddress,
  useTonConnectUI,
} from "@tonconnect/ui-react";
import handleRequest from "./HandleRequests";
import { Payload, Response } from "./IPayloadResponse";

function Home() {
  const userFriendlyAddress = useTonAddress();
  const wallet = useTonWallet();
  const [tonConnectUI] = useTonConnectUI();
  const [payload, setPayload] = useState<Payload>();
  const [transactionComplete, setTransactionComplete] = useState(false);
  const [transactionOnGoing, setTransactionOnGoing] = useState(false);
  const [showSendTransaction, setShowSendTransaction] = useState(true);

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
      redirect(response);
    } else {
      alert("You have either cancelled the transaction or an error occured");
      console.log(response);
    }
    setTransactionOnGoing(false);
  };

  useEffect(() => {
    // get the transaction details from the parent window
    const first: any = window.addEventListener("message", (event) => {
      if (event.data && event.data.from === "ozare") {
        setPayload(event.data);
      }
    });
    const urlParams = new URLSearchParams(window.location.search);

    tonConnectUI.onStatusChange((wallet) => {
      if (urlParams.get('connect') && wallet?.connectItems?.tonProof && 'proof' in wallet?.connectItems?.tonProof) {
        window.parent.postMessage(
          {
            from: "ozare-react",
            status: "connected",
            address: userFriendlyAddress,
            walletName: wallet?.name,
          },
          "*"
        );
      }
    });

    // if there are any query params, set them as the payload
    // if the url has a connect param, hide the send transaction button
    // url sample: http://localhost:3000/?connect=true
    if (urlParams.get("connect")) {
      setShowSendTransaction(false);
    }
 
    let amount: any = urlParams.get("amount") ;
    if (amount) {
      amount = parseFloat(amount);
    }
    let outcome: any = urlParams.get("outcome");
    if (outcome) {
      outcome = outcome === '0';
    }
    let uid: any = urlParams.get("uid");
  
    if (uid) {
      uid = parseInt(uid);
    }
    const payload: Payload = {
      type: 'create_event',
      amount,
      outcome,
      uid,
    };

    if (amount && outcome && uid) {
      setPayload(payload);
    }
    // sample url: http://localhost:3000/?amount=0.1&outcome=0&uid=1
    return () => {
      window.removeEventListener("message", first);
    };
  }, [userFriendlyAddress, tonConnectUI]);

  return transactionComplete ? (
    <div className="flex bg-white justify-center items-center h-screen w-screen">
      <div className="flex flex-col">
        <span className="text-4xl text-center">Transaction complete</span>
        <span className="text-md text-center">
          Redirecting back to parent window...
        </span>
      </div>
    </div>
  ) : (
    <div className="flex bg-white justify-center items-center h-screen w-screen">
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
              disabled={!(userFriendlyAddress?.length > 0) || transactionOnGoing}
              onClick={handleClick}
              className="px-8 rounded-2xl py-4 bg-blue-500 text-white disabled:bg-gray-300"
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

export default Home;
