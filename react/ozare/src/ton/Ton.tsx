import { TonConnectUIProvider } from "@tonconnect/ui-react";
// import { Routes, Route } from "react-router-dom";
import WalletPage from "./WalletPage/WalletPage";

function Ton() {
  return (
    <TonConnectUIProvider manifestUrl="https://ozare-final.vercel.app/ton/tonconnect-manifest.json">
      <WalletPage />
    </TonConnectUIProvider>
  );
}

export default Ton;
