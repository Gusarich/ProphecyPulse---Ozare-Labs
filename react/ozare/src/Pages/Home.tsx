import React, { useState } from "react";

import { BiFootball } from "react-icons/bi";
import { BiCricketBall } from "react-icons/bi";
import { BiBasketball } from "react-icons/bi";

import DropMenu from "../components/DropMenu";
import TonCoin from "../assets/images/ton-coin.svg";

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
  const [searchOption, setSearchOption] = useState(menuItems[0].title);
  const [searchQuery, setSearchQuery] = useState("");

  const menuItemClick = (item: any) => {
    setSearchOption(item.title);
  };

  return (
    <div>
      <section className="px-4 bg-gradient-to-br from-sky-400 via-sky-300 to-sky-400">
        <div className="flex py-4 flex-row items-center justify-between">
          <span className="text-white font-bold text-2xl">Ozare</span>
          <button className="bg-white px-2 items-center py-1 flex justify-start flex-row rounded-full">
            <img src={TonCoin} className="h-8 w-8 pr-2" alt="ton-coin" />
            <span className="text-sky-500 pr-2">Connect</span>
          </button>
        </div>
        <div className="py-10 px-4">
          <div className="flex flex-row   justify-start shadow-sm rounded-full ">
            <DropMenu
              menuItems={menuItems}
              onMenuItemClick={menuItemClick}
              title={searchOption}
              className="rounded-l-full bg-sky-500 hover:bg-sky-600 text-white"
            />
            <input
              type="text"
              value={searchQuery}
              className="border-0 w-full rounded-r-full pl-4 outline-none"
              placeholder={`Search ${searchOption} teams`}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>
      </section>
    </div>
  );
}

export default Home;
