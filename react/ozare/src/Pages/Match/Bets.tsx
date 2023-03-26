import React, { useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";

interface BetsProps {
  match: {
    T1: string;
    T2: string;
  };
}

function Bets({ match }: BetsProps) {
  const { id } = useParams<{ id: string }>();
  const [bets] = React.useState<any[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    // get existing bets from firebase
  }, []);

  const handleClick = () => {
    const t1 = match.T1;
    const t2 = match.T2;
    navigate(`/place_bet/${id}?type=place_bet&t1=${t1}&t2=${t2}`);
  };

  return (
    <div>
      <table className="text-left w-full border-collapse">
        <thead>
          <tr>
            <th className="py-4 px-6 text-left bg-grey-lightest font-bold uppercase text-sm text-grey-dark border-b border-grey-light">
              Name
            </th>
            <th className="py-4 text-right px-6 bg-grey-lightest font-bold uppercase text-sm text-grey-dark border-b border-grey-light">
              TON
            </th>
            <th className="py-4 px-6 text-right bg-grey-lightest font-bold uppercase text-sm text-grey-dark border-b border-grey-light">
              Tokens
            </th>
          </tr>
        </thead>
        <tbody>
          {bets.map((user) => (
            <tr key={user.id}>
              <td className="py-4 px-6 border-b border-grey-light">
                {user.name}
              </td>
              <td className="py-4 px-6 border-b border-grey-light">
                {user.TON}
              </td>
              <td className="py-4 px-6 border-b border-grey-light">
                {user.tokens}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <button
        onClick={handleClick}
        className="bg-sky-500 outline-none text-white shadow-sky-100 shadow-lg flex flex-row justify-start px-4 py-2 items-center rounded-full  absolute right-0 bottom-[72px] md:bottom-0 mr-4 mb-4"
      >
        <span className="text-white-500">Place bet</span>
      </button>
    </div>
  );
}

export default Bets;
