/* eslint-disable react-hooks/rules-of-hooks */
import React, { useCallback, useContext, useEffect, useState } from "react";
import { Link, Navigate, useParams } from "react-router-dom";

import { getScheduleMatchByCategory } from "../../api/LivecoreApiClient";
import Header from "../../components/Header";
import { ScheduleType } from "./types";

import SoccerBackground from "../../assets/images/soccer.jpg";
import CricketBackground from "../../assets/images/cricket.jpg";
import BasketballBackground from "../../assets/images/basketball.jpg";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
import { AuthContext } from "../auth/AuthContext";

function Schedule() {
  const user = useContext(AuthContext);

  if (!user) {
    return <Navigate replace to="/auth/login" />;
  }
  let { id, category, team } = useParams();
  const [schedule, setSchedule] = useState<ScheduleType[]>();
  const [isLoading, setIsLoading] = useState(true);

  const getDetails = useCallback(async () => {
    if (id === undefined || category === undefined) {
      return;
    }
    getScheduleMatchByCategory(id, category).then((res) => {
      setIsLoading(false);
      console.log(res.events);
      setSchedule(res.events);
    });
  }, [id, category]);

  useEffect(() => {
    getDetails();
  }, [getDetails]);

  const getTime = (timestamp: number) => {
    const date = new Date(timestamp * 1000);
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const hours = date.getHours();
    const minutes = date.getMinutes();

    const formattedTime = `${hours.toString().padStart(2, "0")}:${minutes
      .toString()
      .padStart(2, "0")}`;

    return {
      time: formattedTime,
      date: `${day}-${month}-${year}`,
      isBefore: date < new Date(),
    };
  };

  return (
    <div>
      <Header showTonButton={false} title={`${team}'s schedule`} />
      {isLoading && (
        <div className="flex flex-col px-4 pt-4">
          <div>
            <Skeleton
              height={128}
              className="mb-6"
              count={4}
              style={{ borderRadius: "1rem" }}
            />
          </div>
        </div>
      )}
      {schedule ? (
        <div className="flex flex-col gap-3 px-4 pt-4">
          {schedule
            .filter((item) => !getTime(item.startTimestamp).isBefore)
            .sort((a, b) => a.startTimestamp - b.startTimestamp)
            .map((item) => (
              <Link
                to={`/match/?t1=${item.awayTeam.id}&t2=${item.homeTeam.id}&category=${category}&id=`}
                key={item.id}
                className="overflow-hidden relative rounded-2xl shadow-sm"
              >
                <div className=" bg-black w-full h-32 top-0 left-0">
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
                </div>
                <div className="absolute px-4 w-full h-full items-center text-white top-0 left-0 grid grid-cols-3 text-center">
                  <div className="font-bold">{item.homeTeam.name}</div>
                  <div className="flex flex-col justify-between">
                    <span className="text-xs">
                      {getTime(item.startTimestamp).time}
                    </span>

                    <span className="font-bold py-2">VS</span>

                    <span className="text-xs">
                      {getTime(item.startTimestamp).date}
                    </span>
                  </div>
                  <div className="font-bold">{item.awayTeam.name}</div>
                </div>
              </Link>
            ))}
        </div>
      ) : (
        <div className="w-full h-[calc(100vh-144px)]  flex justify-center items-center">
          <span>No schedule found</span>
        </div>
      )}
    </div>
  );
}

export default Schedule;
