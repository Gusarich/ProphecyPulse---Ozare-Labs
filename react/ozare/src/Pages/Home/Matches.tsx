import React from "react";
import { BiBasketball, BiCricketBall, BiFootball } from "react-icons/bi";
import { MatchesProps } from "./types";

import SoccerBackground from "../../assets/images/soccer.jpg";
import CricketBackground from "../../assets/images/cricket.jpg";
import BasketballBackground from "../../assets/images/basketball.jpg";

import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";

import { Link } from "react-router-dom";

function Matches({ data, category }: MatchesProps) {
  return (
    <div className="flex flex-col">
      {data?.Stages.map((stage) => (
        <div key={stage.Sid} className=" py-4 my-2 ">
          {stage.Events.filter((event) => event.Eps !== "FT").length > 0 && (
            <div className="flex px-4 font-bold flex-row items-center justify-start">
              <div className="pr-4 text-2xl">
                {category === "soccer" && <BiFootball />}
                {category === "cricket" && <BiCricketBall />}
                {category === "basketball" && <BiBasketball />}
              </div>
              <div className="w-full  flex items-center flex-row justify-between">
                <span>{stage.Snm}</span>
                <span>
                  ({stage.Events.filter((event) => event.Eps !== "FT").length})
                </span>
              </div>
            </div>
          )}

          <div className="flex w-full flex-row justify-start overflow-x-auto scrollbar-hide">
            {stage.Events.filter((event) => event.Eps !== "FT").map((event) => (
              <Link to={`/match/${category}/${event.Eid}`} key={event.Eid}>
                <div className="overflow-hidden relative -z-10 bg-black min-w-[250px] mx-4 rounded-2xl shadow-sm mt-4 h-40 ">
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
                          {event.T1[0].Img && (
                            <img
                              src={`https://lsm-static-prod.livescore.com/medium/${event.T1[0].Img}`}
                              alt=""
                              className="h-10 w-auto object-cover"
                            />
                          )}

                          {event.T1[0].Nm}
                        </div>
                        <div className="text-white text-2xl flex flex-col text-center justify-center items-center font-bold mx-4">
                          VS
                        </div>
                        <div className="flex flex-col justify-center text-xs text-white font-bold items-center text-center">
                          {event.T2[0].Img && (
                            <img
                              src={`https://lsm-static-prod.livescore.com/medium/${event.T2[0].Img}`}
                              alt=""
                              className="h-10 w-auto object-cover"
                            />
                          )}
                          {event.T2[0].Nm}
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
              </Link>
            ))}
          </div>
        </div>
      )) ||
        [1, 2, 3].map((item) => (
          <div key={item} className="px-4 mb-8 -z-10">
            <Skeleton height={32} className="mt-3 mb-1 " />
            <div className="flex w-full space-x-8 flex-row justify-start overflow-hidden">
              {[1, 2, 3].map((item) => (
                <Skeleton
                  key={item}
                  height={160}
                  width={250}
                  style={{ borderRadius: "1rem" }}
                  className="mt-3 mb-1 "
                />
              ))}
            </div>
          </div>
        ))}
    </div>
  );
}

export default Matches;
