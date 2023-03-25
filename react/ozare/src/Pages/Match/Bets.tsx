import React, { useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { MatchInfoResponseType } from "./types";

function Bets({ match }: { match: MatchInfoResponseType }) {
  const { id } = useParams<{ id: string }>();
  // const [bets, setBets] = React.useState<any[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    // get existing bets from firebase
  }, []);

  const handleClick = () => {
    const t1 = match.T1[0].Nm;
    const t2 = match.T2[0].Nm;
    navigate(`/place_bet/${id}?type=place_bet&t1=${t1}&t2=${t2}`);
  };

  return (
    <div>
      Bets
      <button
        onClick={handleClick}
        className="bg-sky-500 outline-none text-white shadow-sky-100 shadow-lg flex flex-row justify-start px-4 py-2 items-center rounded-full mr-2 absolute right-0 bottom-0 mr-4 mb-4"
      >
        <span className="text-white-500">Place bet</span>
      </button>
    </div>
  );
}

export default Bets;
