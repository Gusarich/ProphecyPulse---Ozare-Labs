import React from "react";
import { Team } from "./types";

import { GiEmptyHourglass } from "react-icons/gi";
import { Link } from "react-router-dom";

function SearchResults({
  searchResults,
  searchCategory,
  searchQuery,
}: {
  searchResults?: Team[];
  searchCategory: string;
  searchQuery: string;
}) {
  if (
    searchResults?.filter((item: Team) => item.type === "team").length === 0
  ) {
    return (
      <div className="pt-20 flex text-gray-500 flex-col gap-20 justify-center items-center">
        <GiEmptyHourglass className="text-5xl" />
        <p className="text-center">No results found for "{searchQuery}"</p>
      </div>
    );
  }

  return (
    <div className="px-4 flex pt-4 flex-col justify-start gap-4">
      <p className="text-xs text-gray-500">Results for: {searchQuery}</p>
      {searchResults
        ?.filter((item: Team) => item.type === "team")
        .map((item: Team) => (
          <Link
            to={`/schedule/${searchCategory.toLowerCase()}/${item.entity.name.toLowerCase()}/${
              item.entity.id
            }`}
            key={item.entity.id}
            className="bg-gray-100 py-2 px-4 rounded-2xl"
          >
            {/* <img src={imageUrlMap[item.entity.id]} alt={item.entity.name} /> */}
            <p className="font-bold">{item.entity.name}</p>
            <p className="text-gray-500">{item.entity.country.name}</p>
          </Link>
        ))}
    </div>
  );
}

export default SearchResults;
