import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import TonCoin from "../../assets/images/ton-coin.svg";
import { BsArrowLeftShort } from "react-icons/bs";

import { getMatchDetails } from "../../ton/wrappers/Livescore";

import SoccerBackground from "../../assets/images/soccer.jpg";
import CricketBackground from "../../assets/images/cricket.jpg";
import BasketballBackground from "../../assets/images/basketball.jpg";
import { MatchInfoResponseType } from "./types";

export default function Match() {
  let { id, category } = useParams();

  const [event, setEvent] = useState<MatchInfoResponseType>();

  const getDetails = async () => {
    if (id === undefined || category === undefined) {
      return;
    }
    const response = await getMatchDetails(id, category);
    setEvent(response);
  };

  useEffect(() => {
    getDetails();
  }, []);

  return (
    <div>
      <section className="sticky z-10 top-0 px-4 bg-gradient-to-br from-sky-400 via-sky-300 to-sky-400">
        <div className="flex pt-4 pb-32 flex-row items-center justify-between">
          <button className="text-sky-500 bg-white rounded-full bg-opacity-90 p-2 font-bold text-2xl">
            <BsArrowLeftShort className="text-2xl" />
          </button>
          <button
            onClick={() => console.log(event)}
            className="bg-white px-2 items-center py-1 flex justify-start flex-row rounded-full"
          >
            <img src={TonCoin} className="h-8 w-8 pr-2" alt="ton-coin" />
            <span className="text-sky-500 pr-2">Connect</span>
          </button>
        </div>
        {event && (
          <div className="absolute top-20 w-full left-0">
            <div className="overflow-hidden relative  bg-black min-w-[250px] mx-4 rounded-2xl shadow-sm mt-4 h-40 ">
              <div className="h-full w-full opacity-60">
                <img
                  src={
                    category === "soccer"
                      ? SoccerBackground
                      : category === "cricket"
                      ? CricketBackground
                      : BasketballBackground
                  }
                  className="object-cover bg-no-repeat h-full w-full "
                  alt=""
                />
              </div>

              <div className="absolute h-full w-full top-0 left-0">
                <div className="relative h-full w-full">
                  <div className="h-full grid grid-cols-3 px-2">
                    <div className="flex flex-col items-center text-xs text-center text-white font-bold justify-center">
                      {event.T1[0].Nm}
                    </div>
                    <div className="text-white text-2xl flex flex-col text-center justify-center items-center font-bold mx-4">
                      VS
                    </div>
                    <div className="flex flex-col justify-center text-xs text-white font-bold items-center text-center">
                      {event.T1[0].Nm}
                    </div>
                  </div>
                  <div className="absolute top-0 w-full text-center text-xs text-white">
                    <span className="bg-sky-500 px-2 py-1 rounded-b-xl">
                      {event.Eps === "NS"
                        ? "Upcoming"
                        : event.Eps === "HT"
                        ? "Playing Now"
                        : event.Eps === "FT"
                        ? "Ended"
                        : "Upcoming"}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}
      </section>
      <div className="w-full bg-red-500 mt-20 h-10 sticky top-[264px]"></div>
      Match {id}
      Category {category}
    </div>
  );
}
