import { useEffect, useState } from "react";
import axios from "axios";
import {
  TonConnectButton,
  useTonWallet,
  useTonAddress,
  useTonConnectUI,
} from "@tonconnect/ui-react";

function Home() {
  const userFriendlyAddress = useTonAddress();
  const wallet = useTonWallet();
  const [tonConnectUI] = useTonConnectUI();
  const [transaction, setTransaction] = useState<any>(null);
  function redirect() {
    if (userFriendlyAddress?.length > 0 && wallet?.name) {
      window.parent.postMessage(
        { address: userFriendlyAddress, walletName: wallet?.name },
        "*"
      );
    }
  }

  async function handleClick() {
    const serverURL = "http://localhost:8000";
    const response = await axios.post(`${serverURL}/event`, {
      via: tonConnectUI.connector,
      address: userFriendlyAddress,
    });
    console.log(response.data);
  }

  useEffect(() => {
    // get the transaction details from the parent window
    const first: any = window.addEventListener("message", (event) => {
      if (event.data) {
        setTransaction(event.data);
      }
    });
    return () => {
      window.removeEventListener("message", first);
    };
  }, []);

  return (
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
            <button
              disabled={!(userFriendlyAddress?.length > 0)}
              onClick={handleClick}
              className="px-8 rounded-2xl py-4 bg-blue-500 text-white disabled:bg-gray-300"
            >
              Continue
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Home;
