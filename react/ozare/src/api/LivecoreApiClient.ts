const rapidApiKey = "07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2";
const apiFootballBaseUrl = "https://api-football-v1.p.rapidapi.com";
const allSportsApi2BaseUrl = "https://allsportsapi2.p.rapidapi.com";
const liveScoreBaseurl = "https://livescore6.p.rapidapi.com";

// const apiFootballBaseUrlHeaders = {
//   "X-RapidAPI-Key": `${rapidApiKey}`,
//   "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
// };

// const liveScoreBaseUrlHeaders = {
//   "X-RapidAPI-Key": `${rapidApiKey}`,
//   "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
// };

const allSportsApi2BaseUrlHeaders = {
  "X-RapidAPI-Key": `${rapidApiKey}`,
  "X-RapidAPI-Host": "allsportsapi2.p.rapidapi.com",
};

export const searchTeam = async (query: string, category: string) => {
  try {
    const resp = await (
      await fetch(`${allSportsApi2BaseUrl}/api/${category}/search/${query}`, {
        method: "GET",
        headers: allSportsApi2BaseUrlHeaders,
      })
    ).json();
    return resp.response;
  } catch (e) {
    console.error(e);
  }
};
