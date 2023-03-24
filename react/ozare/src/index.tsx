import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import Ton from "./ton/Ton";
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import App from "./App";
import InputForm from "./ton/InputForm/InputForm";
import StartFinish from "./ton/StartFinish/StartFinish";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

const router = createBrowserRouter([
  {
    path: "/",
    element: <App />,
  },
  {
    path: "/ton",
    element: <Ton />,
  },
  {
    path: "/place_bet/:id",
    element: <InputForm />,
  },
  {
    path: "/start_finish",
    element: <StartFinish />,
  }
]);

root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
