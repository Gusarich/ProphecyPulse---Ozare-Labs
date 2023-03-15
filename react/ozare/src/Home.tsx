import { TonConnectButton, useTonAddress } from "@tonconnect/ui-react";

function Home() {
  const userFriendlyAddress = useTonAddress();

  function redirect() {
    if (userFriendlyAddress?.length > 0) {
      window.parent.postMessage({ address: userFriendlyAddress }, "*");
    }
  }

  return (
    <div className="flex bg-white justify-center items-center h-screen w-screen">
      <div>
        <div className="flex my-10 justify-center w-full">
          <TonConnectButton />
        </div>

        <div className="flex flex-col">
          <span className="py-4 text-center">
            Address:
            {userFriendlyAddress
              ? userFriendlyAddress
              : " Please Connect wallet"}
          </span>
          <div className="flex justify-center">
            <button
              disabled={!(userFriendlyAddress?.length > 0)}
              onClick={() => redirect()}
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
