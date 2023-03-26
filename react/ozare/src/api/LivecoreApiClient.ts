const rapidApiKey = "07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2";
const apiFootballBaseUrl = "https://api-football-v1.p.rapidapi.com";
const allSportsApi2BaseUrl = "https://allsportsapi2.p.rapidapi.com";
// const liveScoreBaseurl = "https://livescore6.p.rapidapi.com";

const apiFootballBaseUrlHeaders = {
  "X-RapidAPI-Key": `${rapidApiKey}`,
  "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
};

// const liveScoreBaseUrlHeaders = {
//   "X-RapidAPI-Key": `${rapidApiKey}`,
//   "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
// };

const allSportsApi2BaseUrlHeaders = {
  "X-RapidAPI-Key": `${rapidApiKey}`,
  "X-RapidAPI-Host": "allsportsapi2.p.rapidapi.com",
};

export const searchTeam = async (query: string, category: string) => {
  const cat =
    category.toLowerCase() !== "soccer" ? `/${category.toLowerCase()}` : "";
  try {
    const resp = await (
      await fetch(`${allSportsApi2BaseUrl}/api${cat}/search/${query}`, {
        method: "GET",
        headers: allSportsApi2BaseUrlHeaders,
      })
    ).json();
    return resp.results;
  } catch (e) {
    console.error(e);
  }
};

export const getTeamLogo = async (teamID: number, category: string) => {
  const cat =
    category.toLowerCase() !== "soccer" ? `/${category.toLowerCase()}` : "";
  try {
    const response = await fetch(
      `${allSportsApi2BaseUrl}/api${cat}/team/${teamID}/image`,
      {
        method: "GET",
        headers: allSportsApi2BaseUrlHeaders,
      }
    );

    //convert response to url
    const blob = await response.blob();
    const url = URL.createObjectURL(blob);
    return url;
  } catch (e) {
    console.error(e);
  }
};

export const getLiveMatchByTeam = async (teamID: string) => {
  try {
    const response = await fetch(
      `${apiFootballBaseUrl}/v3/fixtures?season=${new Date().getFullYear()}&team=${teamID}`,
      {
        method: "GET",
        headers: apiFootballBaseUrlHeaders,
      }
    );
    return response.json();
  } catch (e) {
    console.error(e);
  }
};

export const getTeamDetails = async (teamID: string, category: string) => {
  const cat =
    category.toLowerCase() !== "soccer" ? `/${category.toLowerCase()}` : "";
  try {
    const response = await fetch(
      `${allSportsApi2BaseUrl}/api${cat}/team/${teamID}`,
      {
        method: "GET",
        headers: allSportsApi2BaseUrlHeaders,
      }
    );
    return response.json();
  } catch (e) {
    console.error(e);
  }
};

export const getScheduleMatchByCategory = async (
  teamID: string,
  category: string
) => {
  const cat =
    category.toLowerCase() !== "soccer" ? `/${category.toLowerCase()}` : "";
  try {
    const response = await fetch(
      `${allSportsApi2BaseUrl}/api${cat}/team/${teamID}/matches/next/0`,
      {
        method: "GET",
        headers: allSportsApi2BaseUrlHeaders,
      }
    );

    return response.json();
  } catch (e) {
    console.error(e);
  }
};
