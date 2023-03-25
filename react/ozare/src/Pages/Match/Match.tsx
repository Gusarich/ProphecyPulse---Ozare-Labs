import { useCallback, useEffect, useState } from "react";
import { useParams } from "react-router-dom";

import { getMatchDetails } from "../../ton/wrappers/Livescore";

import SoccerBackground from "../../assets/images/soccer.jpg";
import CricketBackground from "../../assets/images/cricket.jpg";
import BasketballBackground from "../../assets/images/basketball.jpg";
import { MatchInfoResponseType } from "./types";
import { Tab } from "@headlessui/react";

import Skeleton, { SkeletonTheme } from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";

import Chat from "./Chat";
import Bets from "./Bets";
import Header from "../../components/Header";

export default function Match() {
  let { id, category } = useParams();

  const [event, setEvent] = useState<MatchInfoResponseType>();

  const getDetails = useCallback(async () => {
    if (id === undefined || category === undefined) {
      return;
    }
    const response = await getMatchDetails(id, category);
    setEvent(response);
  }, [id, category]);

  useEffect(() => {
    getDetails();
  }, [getDetails]);

  const tabs = [
    { title: "Chat", content: <Chat /> },
    // @ts-ignore
    { title: "Bets", content: <Bets match={event} /> },
  ];

  return (
    <>
      <Header paddingBottom="pb-32">
        <div>
          {(event && (
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
            </div>
          )) || (
            <div className="absolute top-20 w-full left-0">
              <div className=" relative opacity-90 min-w-[250px] mx-4  shadow-sm mt-4 h-40 ">
                <SkeletonTheme baseColor="#202020" highlightColor="#444">
                  <Skeleton height={160} style={{ borderRadius: "1rem" }} />
                </SkeletonTheme>
              </div>
            </div>
          )}
        </div>
      </Header>

      <Tab.Group defaultIndex={0}>
        <Tab.List
          className={
            "flex  flex-row py-4 px-4 justify-start w-full mt-20  sticky top-[264px]"
          }
        >
          {tabs.map((item) => (
            <Tab
              key={item.title}
              className={({ selected }) =>
                selected
                  ? "bg-sky-400 outline-none text-white shadow-sky-100 shadow-lg flex flex-row justify-start px-4 py-2 items-center rounded-full mr-2"
                  : "text-sky-400 bg-white shadow-sky-100 shadow-lg flex flex-row justify-start px-4 py-2 items-center rounded-full mr-2"
              }
            >
              <div className={"text-sm font-bold"}>{item.title}</div>
            </Tab>
          ))}
        </Tab.List>
        <Tab.Panels>
          {tabs.map((item) => {
            return (
              <Tab.Panel key={item.title}>
                <div className="px-4">{item.content}</div>
              </Tab.Panel>
            );
          })}
        </Tab.Panels>
      </Tab.Group>
    </>
  );
}
