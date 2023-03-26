import { TonConnectUIProvider } from "@tonconnect/ui-react";
import { useContext } from "react";
import { Navigate } from "react-router-dom";
import { AuthContext } from "../Pages/auth/AuthContext";
// import { Routes, Route } from "react-router-dom";
import WalletPage from "./WalletPage/WalletPage";

function Ton() {
  const user = useContext(AuthContext);

  if (!user) {
    return <Navigate replace to="/auth/login" />;
  }
  return (
    <TonConnectUIProvider manifestUrl="https://ozare-final.vercel.app/ton/tonconnect-manifest.json">
      <WalletPage />
    </TonConnectUIProvider>
  );
}

export default Ton;
