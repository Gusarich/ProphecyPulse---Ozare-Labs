import axios from "axios";
const fs = require("fs");
type Sport = "soccer" | "basketball" | "tennis" | "cricket" | "hockey";
require("dotenv").config();
async function getCombinedData(date: string, sport: Sport) {
  // Get list-by-date data
  const listByDateResponse = await axios({
    method: "GET",
    url: "https://livescore6.p.rapidapi.com/matches/v2/list-by-date",
    params: { Category: sport, Date: date, Timezone: "+2" },
    headers: {
      "X-RapidAPI-Key": process.env.RAPID_API_KEY,
      "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
    },
  });

  const events = listByDateResponse.data.Stages.flatMap(
    (stage: any) => stage.Events
  );
  const results = [];

  // Loop through events and get lineup data
  for (const event of events) {
    const eid = event.Eid;
    const t1 = event.T1[0].Nm;
    const t2 = event.T2[0].Nm;

    // Get lineup data
    const lineupResponse = await axios({
      method: "GET",
      url: "https://livescore6.p.rapidapi.com/matches/v2/get-lineups",
      params: { Eid: eid, Category: sport },
      headers: {
        "X-RapidAPI-Key": process.env.RAPID_API_KEY,
        "X-RapidAPI-Host": "livescore6.p.rapidapi.com",
      },
    });

    const lineupData = lineupResponse.data.Lu;
    console.log(lineupData, sport);
    if (!lineupData) continue;
    const players_t1 = lineupData
      .filter((item: any) => item.Tnb === 1)
      .flatMap((item: any) =>
        item.Ps.map((player: any) => player.Fn + " " + player.Ln)
      );
    const players_t2 = lineupData
      .filter((item: any) => item.Tnb === 2)
      .flatMap((item: any) =>
        item.Ps.map((player: any) => player.Fn + " " + player.Ln)
      );

    // Add data to results
    results.push({
      Eid: eid,
      T1: t1,
      T2: t2,
      players_t1,
      players_t2,
      match_time: event.Esd,
    });
  }

  return results;
}

async function getDataBaseCombo(sport: Sport) {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    // const todayStr = today.toISOString().slice(0, 10).replace(/-/g, "");
    const tomorrowStr = tomorrow.toISOString().slice(0, 10).replace(/-/g, "");
    // const todayData = await getCombinedData(todayStr, sport);
    const tomorrowData = await getCombinedData(tomorrowStr, sport);
    // const combinedData = [...todayData, ...tomorrowData];
    return tomorrowData;
}

async function getForAllSports() {
    const sports: Sport[] = ["soccer", "basketball", "cricket"];
    // sequentially get data for each sport
    const data : {
        [key in Sport]: any[]
    } = {
        soccer: [],
        basketball: [],
        tennis: [],
        cricket: [],
        hockey: [],
    };
    for (const sport of sports) {
        data[sport] = await getDataBaseCombo(sport);
        await fs.writeFile('data.json', JSON.stringify(data), function (err: any) {
            if (err) {
                return console.log(err);
            }
            console.log("The file was saved!");
        });
    }
    return data;
}

// save it to a file
export async function saveDataAndReturn() {
    // if there's data.json, return it
    if (fs.existsSync("data.json")) {
        return JSON.parse(fs.readFileSync("data.json", "utf8"));
    }
    const data = await getForAllSports();
    fs.writeFile("data.json", JSON.stringify(data), function (err: any) {
        if (err) {
            return console.log(err);
        }
        console.log("The file was saved!");
    });
}

(async () => {
    await saveDataAndReturn();
})();
