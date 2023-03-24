import React, { useState } from "react";
import "./InputForm.scss";
import Logo from "./logo.png";
import { useParams, useNavigate } from "react-router-dom";
import Swal from "sweetalert2";

const InputForm: React.FC = () => {
  // get id from /place_bet/:id
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  // get t1 and t2 from query params
  const t1 = new URLSearchParams(window.location.search).get("t1");
  const t2 = new URLSearchParams(window.location.search).get("t2");

  const [amount, setAmount] = useState("");
  const [outcome, setOutcome] = useState(0);
  const handleSubmit = (
    e: React.MouseEvent<HTMLButtonElement, MouseEvent>
  ) => {
    // redirect to /ton?uid=id&outcome=outcome&amount=amount
    e.preventDefault();
    if (outcome !== 0 && outcome !== 1) {
      Swal.fire({icon: "error", text: "Please select an outcome"});
      return;
    }
    let amountFloat: number;
    try {
        amountFloat = parseFloat(amount);
    } catch(err) {
        Swal.fire({icon: "error", text: "Please enter a valid amount in TON"});
        return;
    }
    if (amountFloat <= 0) {
        Swal.fire({icon: "error", text: "Please enter a valid amount in TON"});
        return;
    }
    navigate(`/ton?type=place_bet&uid=${id}&outcome=${outcome}&amount=${amountFloat}`);
  };
  return (
    <div className="place-bet-form">
      <form>
        <img src={Logo} alt="Ozare Logo" />
        <h2 className="sr-only">Login Form</h2>
        <div className="form-group">
          <h6> Amount (TON) </h6>{" "}
          <input
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="form-control"
            type="text"
            name="Amount"
          />
          <h6> Outcome </h6>{" "}
          <select
            value={outcome}
            onChange={(e) => setOutcome(parseInt(e.target.value))}
          >
            <option value={0}>{t1}</option>
            <option value={1}>{t2}</option>
          </select>
        </div>
        <div className="form-group">
          <button
            onClick={handleSubmit}
            className="btn btn-primary btn-block"
            type="submit"
          >
            Place Bet
          </button>
        </div>
      </form>
    </div>
  );
};

export default InputForm;
