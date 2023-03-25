import React from "react";

function SearchResults({ searchResults }: { searchResults: any }) {
  return (
    <div>
      <pre>{JSON.stringify(searchResults, null, 2)}</pre>
    </div>
  );
}

export default SearchResults;
