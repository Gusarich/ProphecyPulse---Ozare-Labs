"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getMatchStatus = exports.getMatchDetails = exports.getAllMatchesByDate = exports.Category = void 0;
const liveScoreBaseUrl = `https://livescore6.p.rapidapi.com/matches/v2`;
const rapidApiKey = "07585b4120mshbc941a57c6ebd11p11de9bjsn089233df6ab2";
exports.Category = {
    soccer: "soccer",
    cricket: "cricket",
    basketball: "basketball",
    tennis: "tennis",
    hockey: "hockey"
};
const getAllMatchesByDate = async (date, category, timezone = 0 - 7) => {
    /// This function is used to return all matches that 
    /// happen on the date var,
    /// the format of date is a "YYYYMMDD" since the api expects a string
    const options = {
        method: 'GET',
        headers: {
            'X-RapidAPI-Key': `${rapidApiKey}`,
            'X-RapidAPI-Host': 'livescore6.p.rapidapi.com'
        }
    };
    try {
        const resp = await (await fetch(`${liveScoreBaseUrl}/list-by-date?Category=${category}&Date=${date}&Timezone=${timezone}`, options)).json();
        return resp;
    }
    catch (e) {
        console.error(e);
        return null;
    }
};
exports.getAllMatchesByDate = getAllMatchesByDate;
const getMatchDetails = async (eid, category) => {
    /// Returns a specific match's details
    const options = {
        method: 'GET',
        headers: {
            'X-RapidAPI-Key': `${rapidApiKey}`,
            'X-RapidAPI-Host': 'livescore6.p.rapidapi.com'
        }
    };
    try {
        const resp = await (await fetch(`${liveScoreBaseUrl}/get-scoreboard?Category=${category}&Eid=${eid}`, options)).json();
        return await resp;
    }
    catch (e) {
        console.error(e);
    }
};
exports.getMatchDetails = getMatchDetails;
const getMatchStatus = async (eid, category) => {
    /// Returns:
    ///   -1 if the match hasn't happened yet
    ///    0 if the match is happening live
    ///    1 if the match has concluded
    const match = await (0, exports.getMatchDetails)(eid, category);
    if (!match) {
        throw Error("The given eid/category combination does not exist, please verify.");
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
exports.getMatchStatus = getMatchStatus;
