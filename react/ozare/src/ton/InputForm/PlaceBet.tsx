import React, { useState } from "react";
// import "./PlaceBet.scss";
import Logo from "./logo.png";
import { useParams, useNavigate } from "react-router-dom";
import Swal from "sweetalert2";
import Header from "../../components/Header";

const PlaceBet: React.FC = () => {
  // get id from /place_bet/:id
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  // get t1 and t2 from query params
  const t1 = new URLSearchParams(window.location.search).get("t1");
  const t2 = new URLSearchParams(window.location.search).get("t2");

  const [amount, setAmount] = useState("");
  const [outcome, setOutcome] = useState(0);
  const handleSubmit = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    // redirect to /ton?uid=id&outcome=outcome&amount=amount
    e.preventDefault();
    let amountFloat: number;
    try {
      amountFloat = parseFloat(amount);
    } catch (err) {
      Swal.fire({ icon: "error", text: "Please enter a valid amount in TON" });
      return;
    }
    if (!amountFloat || amountFloat <= 0) {
      Swal.fire({ icon: "error", text: "Please enter a valid amount in TON" });
      return;
    }
    if (outcome !== 0 && outcome !== 1) {
      Swal.fire({ icon: "error", text: "Please select an outcome" });
      return;
    }

    navigate(
      `/transaction?type=place_bet&uid=${id}&outcome=${outcome}&amount=${amountFloat}`
    );
  };
  return (
    <>
      <Header showTonButton={false} />
      <div className="w-full h-[calc(100vh-144px)]  flex justify-center items-center">
        <form className="px-6 py-8  shadow-lg flex flex-col gap-y-4 justify-center w-2/3 rounded-2xl">
          <div className="flex flex-row justify-center">
            <div className="h-28 w-28 bg-gray-100 rounded-full p-4">
              <img src={Logo} alt="Ozare Logo" className="h-full w-full" />
            </div>
          </div>
          <div className="flex flex-col gap-2 justify-center items-start">
            <h6 className="font-bold"> Amount (TON) </h6>
            <input
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              className="w-full font-bold appearance-none outline-none text-sky-500 bg-sky-100 rounded-full px-4 py-2"
              type="number"
              name="Amount"
            />
            <h6 className="font-bold"> Outcome </h6>
            <select
              value={outcome}
              className="w-full font-bold appearance-none outline-none text-sky-500 bg-sky-100 rounded-full px-4 py-2 leading-tight"
              onChange={(e) => setOutcome(parseInt(e.target.value))}
            >
              <option value={0}>{t1}</option>
              <option value={1}>{t2}</option>
            </select>
          </div>
          <div className="w-full flex flex-row justify-center">
            <button
              onClick={handleSubmit}
              className="bg-sky-500  my-4 outline-none text-white shadow-sky-100 shadow-lg flex flex-row justify-start px-4 py-2 items-center rounded-full"
              type="submit"
            >
              Place Bet
            </button>
          </div>
        </form>
      </div>
    </>
  );
};

export default PlaceBet;
