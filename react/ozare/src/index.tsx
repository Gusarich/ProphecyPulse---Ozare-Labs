import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";
// import InputForm from "./ton/InputForm/InputForm";
// import StartFinish from "./ton/StartFinish/StartFinish";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
