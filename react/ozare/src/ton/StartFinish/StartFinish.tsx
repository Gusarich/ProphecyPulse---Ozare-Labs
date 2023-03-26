import React, { useState } from "react";
import "../InputForm/InputForm.scss";
import axios from "axios";

const StartFinish: React.FC = () => {
  const [address, setAddress] = useState("");
  const [response, setResponse] = useState({});
  const onStartClick = async (
    e: React.MouseEvent<HTMLButtonElement, MouseEvent>
  ) => {
    e.preventDefault();
    const serverURL = process.env.NODE_ENV === 'development' ? 'http://localhost:8080' : 'http://159.223.250.48:8080/';
    try {
      const res = await axios.post(`${serverURL}/api/contract/start`, {
        address
      });
      setResponse(res.data);
    } catch (e: any) {
      setResponse(e);
    }
  };

  const onFinishClick = async (
    e: React.MouseEvent<HTMLButtonElement, MouseEvent>
  ) => {
    // redirect to /ton?uid=id&outcome=outcome&amount=amount
    e.preventDefault();
    const serverURL = process.env.NODE_ENV === 'development' ? 'http://localhost:8080' : 'http://159.223.250.48:8080/';
    try {
      const res = await axios.post(`${serverURL}/api/contract/finish`, {
        address
      });
      setResponse(res.data);
    } catch (e: any) {
      setResponse(e);
    }
  };
  return (
    <div className="place-bet-form">
      <form>
        <h2 className="sr-only">Start/Finish Event</h2>
        <div className="form-group">
          <h6> Event address: </h6>{" "}
          <input
            value={address}
            onChange={(e) => setAddress(e.target.value)}
            className="form-control"
            type="text"
            name="Amount"
          />

        </div>
        <div className="form-group">
          <button
            onClick={onStartClick}
            className="btn btn-primary btn-block"
          >
            Start event
          </button>
        </div>
        <div className="form-group">
          <button
            onClick={onFinishClick}
            className="btn btn-primary btn-block"
          >
            Finish event
          </button>
        </div>
        <pre>{response && JSON.stringify(response, null, 2)}</pre>
      </form>
    </div>
  );
};

export default StartFinish;
