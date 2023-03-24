const liveScoreBaseUrl = `https://livescore6.p.rapidapi.com/matches/v2`;
const rapidApiKey = "07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2";
// As long as the repo is private this (^) is alright, should be using a process.env on production for this,
// and squashing all commits before making repo public

// Response types, change below code to expand on what information we're seeking from the API
// this is a quick impl, can convert to generics

interface MatchesResponseType {
  Stages: Array<{
    Events: Array<{
      Eid: string | number;
      [key: string]: any;
    }>;
    [key: string]: any;
  }>;
}

interface MatchInfoResponseType {
  Eps: string;
  [key: string]: any;
}

export const Category = {
  soccer: "soccer",
  cricket: "cricket",
  basketball: "basketball",
  tennis: "tennis",
  hockey: "hockey",
};

export const getAllMatchesByDate = async (
  date: string,
  category: string,
  timezone: number = 0 - 7
) => {
  /// This function is used to return all matches that
  /// happen on the date var,
  /// the format of date is a "YYYYMMDD" since the api expects a string

  const options = {
    method: "GET",
    headers: {
      "X-RapidAPI-Key": `${rapidApiKey}`,
      "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
    },
  };

  try {
    const resp = await (
      await fetch(
        `${liveScoreBaseUrl}/list-by-date?Category=${category}&Date=${date}&Timezone=${timezone}`,
        options
      )
    ).json();
    return resp as MatchesResponseType;
  } catch (e) {
    console.error(e);
    return null;
  }
};

export const getMatchDetails = async (eid: string, category: string) => {
  /// Returns a specific match's details

  const options = {
    method: "GET",
    headers: {
      "X-RapidAPI-Key": `${rapidApiKey}`,
      "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
    },
  };

  try {
    const resp = await (
      await fetch(
        `${liveScoreBaseUrl}/get-scoreboard?Category=${category}&Eid=${eid}`,
        options
      )
    ).json();
    return (await resp) as MatchInfoResponseType;
  } catch (e) {
    console.error(e);
  }
};

export const getMatchStatus = async (eid: string, category: string) => {
  /// Returns:
  ///   -1 if the match hasn't happened yet
  ///    0 if the match is happening live
  ///    1 if the match has concluded

  const match = await getMatchDetails(eid, category);
  if (!match) {
    throw Error(
      "The given eid/category combination does not exist, please verify."
    );
  }

  switch (match.Eps) {
    case "NS":
      return -1;
    case "HT":
      return 0;
    case "FT":
      return 1;
    default:
      return -1;
  }
};
