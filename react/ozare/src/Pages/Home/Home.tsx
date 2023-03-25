import React, { useState, useEffect, useCallback } from "react";

import { BiFootball } from "react-icons/bi";
import { BiCricketBall } from "react-icons/bi";
import { BiBasketball } from "react-icons/bi";

import { getAllMatchesByDate } from "../../ton/wrappers/Livescore";
import { getCurrentDate } from "../../utils/getCurrentDate";
import { getCurrentTimezone } from "../../utils/getCurrentTimeZone";

import { MatchesResponseType } from "./types";

import DropMenu from "../../components/DropMenu";
import { DebounceInput } from "react-debounce-input";
import Header from "../../components/Header";
import MatchesUI from "./Matches/MatchesUI";
import SearchResults from "./SearchResults";
import { searchTeam } from "../../api/LivecoreApiClient";

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
  const [searchResults, setSearchResults] = useState();

  const getMatches = async (category: string) => {
    const response = await getAllMatchesByDate(
      getCurrentDate(),
      category,
      getCurrentTimezone()
    );
    setMatches(() => (response ? response : undefined));
  };

  const search = useCallback(async (query: string, category: string) => {
    const response = await searchTeam(query, category.toLowerCase());
    setSearchResults(response ? response : []);
  }, []);

  useEffect(() => {
    if (searchQuery.length > 0) {
      search(searchQuery, searchCategory);
    }
  }, [searchQuery, searchCategory, search]);

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

      {!(searchQuery.length > 0) && (
        <MatchesUI
          contentCategory={contentCategory}
          matches={matches}
          menuItems={menuItems}
          setContentCategory={setContentCategory}
        />
      )}

      {searchQuery.length > 0 && (
        <SearchResults searchResults={searchResults} />
      )}
    </>
  );
}

export default Home;
