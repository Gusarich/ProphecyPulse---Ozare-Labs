import { TonConnectUIProvider } from "@tonconnect/ui-react";
// import { Routes, Route } from "react-router-dom";
import Home from "./Home";

function App() {
  return (
    <TonConnectUIProvider manifestUrl="https://ozare-react.vercel.app/tonconnect-manifest.json">
      <Home />
    </TonConnectUIProvider>
  );
}

export default App;
