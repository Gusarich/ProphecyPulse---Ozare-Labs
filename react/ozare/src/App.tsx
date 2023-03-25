import { BrowserRouter, Routes, Route } from "react-router-dom";
import Layout from "./layout/Layout";

import Home from "./Pages/Home/Home";
import Notifications from "./Pages/Notifications";
import Bets from "./Pages/Bets";
import Profile from "./Pages/Profile/Profile";
import Match from "./Pages/Match/Match";
import Edit from "./Pages/Profile/Edit";

function App() {
  return (
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/bets" element={<Bets />} />
          <Route path="/notifications" element={<Notifications />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/profile/edit" element={<Edit />} />
          <Route path="/match/:category/:id" element={<Match />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  );
}

export default App;
