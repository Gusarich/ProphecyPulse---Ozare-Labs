import { BrowserRouter, Routes, Route } from "react-router-dom";
import Layout from "./layout/Layout";

import Home from "./Pages/Home/Home";
import Notifications from "./Pages/Notifications";
import Bets from "./Pages/Bets";
import Profile from "./Pages/Profile/Profile";
import Match from "./Pages/Match/Match";
import Edit from "./Pages/Profile/Edit";
import PlaceBet from "./ton/InputForm/PlaceBet";
import Ton from "./ton/Ton";
import Schedule from "./Pages/Match/Schedule";
import { useEffect, useState } from "react";

import Logo from "./assets/logo.png";
import Login from "./Pages/auth/Login";
import Register from "./Pages/auth/Register";
import { AuthContextProvider } from "./Pages/auth/AuthContextProvider";

function App() {
  const [isLoading, setIsLoading] = useState(true);
  useEffect(() => {
    window.addEventListener("load", () => {
      setTimeout(() => {
        setIsLoading(false);
      }, 700);
    });
  }, []);
  return (
    <BrowserRouter>
      {isLoading ? (
        <div className="h-screen w-screen bg-gradient-to-br from-sky-500 via-sky-300  to-sky-900 flex flex-col justify-center items-center">
          <img src={Logo} alt="" className="h-32 animate-pulse" />
        </div>
      ) : (
        <AuthContextProvider>
          <Layout>
            <Routes>
              <Route path="/auth/login" element={<Login />} />
              <Route path="/auth/register" element={<Register />} />

              <Route path="/" element={<Home />} />
              <Route path="/bets" element={<Bets />} />
              <Route path="/notifications" element={<Notifications />} />
              <Route path="/profile" element={<Profile />} />
              <Route path="/profile/edit" element={<Edit />} />
              <Route path="/match/*" element={<Match />} />
              <Route
                path="/schedule/:category/:team/:id"
                element={<Schedule />}
              />
              <Route path="/place_bet/:id" element={<PlaceBet />} />
              <Route path="/transaction" element={<Ton />} />
            </Routes>
          </Layout>
        </AuthContextProvider>
      )}
    </BrowserRouter>
  );
}

export default App;
