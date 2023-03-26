import React, { useContext } from "react";
import { Navigate } from "react-router-dom";

import Header from "../../components/Header";
import { AuthContext } from "../auth/AuthContext";

function Edit() {
  const { user } = useContext(AuthContext);

  if (!user) {
    return <Navigate replace to="/auth/login" />;
  }
  return (
    <>
      <Header showTonButton={false} title="Edit Profile" />
    </>
  );
}

export default Edit;
