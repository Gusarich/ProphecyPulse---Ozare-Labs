import React, { useState, useEffect } from "react";

import { BiFootball } from "react-icons/bi";
import { BiCricketBall } from "react-icons/bi";
import { BiBasketball } from "react-icons/bi";

import { getAllMatchesByDate } from "../../ton/wrappers/Livescore";
import { getCurrentDate } from "../../utils/getCurrentDate";
import { getCurrentTimezone } from "../../utils/getCurrentTimeZone";

import { MatchesResponseType } from "./types";

import DropMenu from "../../components/DropMenu";
import Matches from "./Matches";
import { Tab } from "@headlessui/react";
import { DebounceInput } from "react-debounce-input";
import Header from "../../components/Header";

function Home() {
  const menuItems = [
    {
      title: "Soccer",
      icon: <BiFootball />,
    },
    {
      title: "Cricket",
      icon: <BiCricketBall />,
    },
    {
      title: "Basketball",
      icon: <BiBasketball />,
    },
  ];
  const [searchCategory, setSearchCategory] = useState(menuItems[0].title);
  const [contentCategory, setContentCategory] = useState(menuItems[0].title);
  const [searchQuery, setSearchQuery] = useState("");
  const [matches, setMatches] = useState<MatchesResponseType>();

  const getMatches = async (category: string) => {
    const response = await getAllMatchesByDate(
      getCurrentDate(),
      category,
      getCurrentTimezone()
    );
    setMatches(() => (response ? response : undefined));
  };

  // useEffect(() => {
  //   if (searchQuery.length > 0 && matches) {
  //     //search Matches
  //   }
  // }, [searchQuery]);

  useEffect(() => {
    setMatches(undefined);
    getMatches(contentCategory.toLowerCase());
  }, [contentCategory]);

  return (
    <>
      <Header title="Ozare" showBack={false}>
        <div className="pt-6 px-4 pb-4">
          <div className="flex flex-row   justify-start shadow-sm rounded-full ">
            <DropMenu
              menuItems={menuItems}
              onMenuItemClick={(item) => {
                setSearchCategory(item.title);
              }}
              title={searchCategory}
              className="rounded-l-full bg-sky-500 hover:bg-sky-600 text-white"
            />
            <DebounceInput
              type="text"
              value={searchQuery}
              minLength={3}
              debounceTimeout={1500}
              className="border-0 w-full rounded-r-full px-4 outline-none"
              placeholder={`Search ${searchCategory.toLowerCase()} teams`}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>
      </Header>

      <section>
        <Tab.Group>
          <Tab.List
            className={
              "flex sticky top-[148px]  bg-white flex-row py-4 justify-center"
            }
          >
            {menuItems.map((item) => (
              <Tab
                key={item.title}
                onClick={() => setContentCategory(item.title)}
                className={({ selected }) =>
                  selected
                    ? "bg-sky-400 outline-none text-white shadow-sky-100 shadow-lg flex flex-row justify-start px-2 py-1 items-center rounded-full mx-2"
                    : "text-sky-400 bg-white shadow-sky-100 shadow-lg flex flex-row justify-start px-2 py-1 items-center rounded-full mx-2"
                }
              >
                <div className={"pr-2"}>{item.icon}</div>
                <div className={"text-sm font-bold pr-2"}>{item.title}</div>
              </Tab>
            ))}
          </Tab.List>
          <Tab.Panels>
            {menuItems.map((item) => {
              return (
                <Tab.Panel key={item.title}>
                  {contentCategory === item.title && (
                    <Matches
                      data={matches}
                      category={contentCategory.toLowerCase()}
                    />
                  )}
                </Tab.Panel>
              );
            })}
          </Tab.Panels>
        </Tab.Group>
      </section>
    </>
  );
}

export default Home;
