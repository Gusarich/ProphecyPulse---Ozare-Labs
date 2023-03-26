import React, { useContext } from "react";
import { Navigate } from "react-router-dom";
import Header from "../components/Header";
import { AuthContext } from "./auth/AuthContext";

function Bets() {
  const user = useContext(AuthContext);

  if (!user) {
    return <Navigate replace to="/auth/login" />;
  }
  return (
    <>
      <Header showBack={false} title="Bets" />
    </>
  );
}

export default Bets;
