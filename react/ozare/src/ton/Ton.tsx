import { TonConnectUIProvider } from '@tonconnect/ui-react';
// import { Routes, Route } from "react-router-dom";
// import Home from './Home';

function Ton() {
  return (
    <TonConnectUIProvider manifestUrl="https://ozare-final.vercel.app/ton/tonconnect-manifest.json">
      {/* <Home /> */}
    </TonConnectUIProvider>
  );
}

export default Ton;
