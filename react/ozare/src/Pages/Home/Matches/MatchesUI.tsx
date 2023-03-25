import { Tab } from "@headlessui/react";
import React from "react";
import Matches from "./Matches";

function MatchesUI({
  menuItems,
  contentCategory,
  setContentCategory,
  matches,
}: {
  menuItems: {
    title: string;
    icon: JSX.Element;
  }[];
  contentCategory: any;
  setContentCategory: React.Dispatch<React.SetStateAction<string>>;
  matches: any;
}) {
  return (
    <section>
      <Tab.Group>
        <Tab.List
          className={
            "flex sticky top-[136px]  bg-white flex-row py-4 justify-center"
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
  );
}

export default MatchesUI;
