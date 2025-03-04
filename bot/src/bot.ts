import { Telegraf } from "telegraf";
import { saveDataAndReturn } from "./getDatabase";
import {
  basicWords,
  basketballTerms,
  cricketTerms,
  soccerTerms,
} from "./wordsDatabase";
require("dotenv").config();

const API_TOKEN = process.env.BOT_API_TOKEN || "";

const bot = new Telegraf(API_TOKEN);

const websiteURL = "https://ozare-e8ed6.web.app/";
const documentationURL =
  "https://ozare.gitbook.io/untitled/welcome/prophecypulse";
const twitterURL = "https://twitter.com/ozareapp";
const betURL = "https://ozare-final.vercel.app/place_bet/";

Object.defineProperty(String.prototype, "capitalize", {
  value: function () {
    return this.charAt(0).toUpperCase() + this.slice(1);
  },
  enumerable: false,
});

const languages = [
  { code: "en", name: "English" },
  { code: "hi", name: "हिंदी" },
  { code: "ru", name: "Русский" },
  { code: "ur", name: "اردو" },
  { code: "pt", name: "Português" },
];

const userLanguage = {};

const _t = (ctx: any, text: string) => {
  // @ts-ignore
  const language = userLanguage[ctx?.from?.id] || "es";
  return text;
};

bot.start((ctx) => {
  ctx.reply(
    `Welcome to *Prophecy Pulse* telegram bot. The *first* decentralized predictive markets platform on TON. The *only* decentralized market directly integrated into telegram.\nUse /help to see the available commands.`,
    { parse_mode: "Markdown" }
  );
});

bot.help((ctx) => {
  ctx.reply(
    "Welcome! Here are the available commands:\n\n/language - Set your preferred language\n/website - Visit our website\n/twitter - Follow us on Twitter\n/docs - Read our documentation",
    {
      reply_markup: {
        inline_keyboard: [
          [
            {
              text: "Website",
              url: websiteURL,
            },
            {
              text: "Twitter",
              url: twitterURL,
            },
            {
              text: "Docs",
              url: documentationURL,
            },
          ],
        ],
      },
    }
  );
});

bot.command("language", async (ctx) => {
  // Function to handle language selection
  const handleLanguageSelection = async (ctx: any, language: any) => {
    const selectedLanguage = ctx.match[0];
    // @ts-ignore Save user's language preference into the database, session or a variable
    userLanguage[ctx.from.id] = selectedLanguage;
    if (language.code === "en") {
      ctx.reply(`Your language has been set to ${language.name}.`);
    } else if (language.code === "hi") {
      ctx.reply(`आपकी भाषा ${language.name} के रूप में सेट की गई है।`);
    } else if (language.code === "ru") {
      ctx.reply(`Ваш язык установлен на ${language.name}.`);
    } else if (language.code === "ur") {
      ctx.reply(`آپ کی زبان ${language.name} کے طور پر ترتیب دی گئی ہے۔`);
    } else if (language.code === "pt") {
      ctx.reply(`Sua língua foi definida para ${language.name}.`);
    }
  };

  // Create buttons for language selection
  const languageButtons = languages.map((language) => ({
    text: language.name,
    callback_data: language.code,
  }));

  // Send a message with inline keyboard for selecting languages
  await ctx.reply(_t(ctx, "Please select your language:"), {
    reply_markup: {
      inline_keyboard: [languageButtons],
    },
  });

  // Listen for button clicks and call the handleLanguageSelection function
  languages.forEach((language) => {
    bot.action(language.code, (ctx) => handleLanguageSelection(ctx, language));
  });
});

bot.command("website", (ctx) => {
  ctx.reply(_t(ctx, `Visit our website: ${websiteURL}`));
});

bot.command("docs", (ctx) => {
  ctx.reply(_t(ctx, `Read our documentation: ${documentationURL}`));
});

bot.command("twitter", (ctx) => {
  ctx.reply(_t(ctx, `Follow us on Twitter: ${twitterURL}`));
});

interface IBet {
  EID?: string;
  sport?: string;
  t1?: string;
  t2?: string;
  match_time?: string;
}

async function checkForSportsTerms(input: string): Promise<IBet> {
  // check for sports terms in the message
  const database = await saveDataAndReturn();

  let sports = [];
  if (
    basketballTerms.some((term) =>
      input.toLocaleLowerCase().includes(term.toLocaleLowerCase())
    )
  )
    sports.push("basketball");
  if (
    cricketTerms.some((term) =>
      input.toLocaleLowerCase().includes(term.toLocaleLowerCase())
    )
  )
    sports.push("cricket");
  if (
    soccerTerms.some((term) =>
      input.toLocaleLowerCase().includes(term.toLocaleLowerCase())
    )
  )
    sports.push("soccer");

  console.log(sports);

  if (sports.length) {
    for (const sport of sports) {
      const data = database[sport];
      const words = input.split(" ");
      const dataString = JSON.stringify(data);
      const lowerCaseDataString = dataString.toLocaleLowerCase();
      for (let i = 0; i < words.length; i++) {
        if (basicWords.includes(words[i].toLocaleLowerCase())) continue;
        let word = (words[i].toLocaleLowerCase() as any).capitalize();
        const index = dataString.indexOf(word);
        if (index !== -1) {
          // check if that is an actual word i.e not a substring of another word
          // previous letter should not be a letter and next letter should not be a letter
          // or number
          if (
            (lowerCaseDataString[index - 1] >= "a" &&
              lowerCaseDataString[index - 1] <= "z") ||
            (lowerCaseDataString[index - 1] >= "0" &&
              lowerCaseDataString[index - 1] <= "9") ||
            (lowerCaseDataString[index + words[i].length] >= "a" &&
              lowerCaseDataString[index + words[i].length] <= "z") ||
            (lowerCaseDataString[index + words[i].length] >= "0" &&
              lowerCaseDataString[index + words[i].length] <= "9")
          ) {
            continue;
          }
        }
        if (index !== -1) {
          // Find the nearest EID index above the index
          let eidIndex = dataString.lastIndexOf('"Eid":', index);

          // Extract the EID
          let EID = "";
          for (let j = eidIndex + 7; j < dataString.length; j++) {
            if (dataString[j] === '"') break;
            EID += dataString[j];
          }
          // find the event index where the EID is EID
          for (let i = 0; i < data.length; i++) {
            if (data[i].Eid === EID) {
              eidIndex = i;
              break;
            }
          }
          console.log(EID);
          const t1 = data[eidIndex].T1;
          const t2 = data[eidIndex].T2;
          const match_time = data[eidIndex].match_time;
          return { EID, sport, t1, t2, match_time };
        }
      }
    }
  }
  return {};
}

function getDate(match_time: number | string): Date {
  // yyyymmddhhmmss
  match_time = match_time.toString();
  const year = match_time.slice(0, 4);
  const month = match_time.slice(4, 6);
  const day = match_time.slice(6, 8);
  const hour = match_time.slice(8, 10);
  const minute = match_time.slice(10, 12);
  const second = match_time.slice(12, 14);
  return new Date(
    parseInt(year),
    parseInt(month) - 1,
    parseInt(day),
    parseInt(hour),
    parseInt(minute),
    parseInt(second)
  );
}

bot.command("list_basketball", async (ctx) => {
  try {
    console.log("list_basketball");
    const database = await saveDataAndReturn();
    const data = database["basketball"];
    // find all basketball matches in the next x days
    const textPresent = !!ctx.message?.text;
    console.log(ctx.message?.text.split(" ")[1]);
    const days = parseInt(
      !textPresent ? "1" : ctx.message?.text.split(" ")[1] || "1"
    );
    let message = `Showing matches of cricket in the next ${days} ${
      days > 1 ? "days" : "day"
    }`;
    const today = new Date();
    const tomorrow = new Date();
    tomorrow.setDate(today.getDate() + days);
    for (const match of data) {
      const match_time = new Date(getDate(match.match_time));
      if (match_time > today && match_time < tomorrow) {
        message += `\n${match.T1} vs ${
          match.T2
        } at ${match_time.toLocaleString()}`;
      }
    }
    // console.log(message);
    if (message.length)
      ctx.reply(message, {
        parse_mode: "Markdown",
      });
  } catch (e) {
    console.log(e);
  }
  // find all basketball matches /list_basketball x
});

bot.command("list_cricket", async (ctx) => {
  // find all cricket matches /list_cricket x
  try {
    const database = await saveDataAndReturn();
    const data = database["cricket"];
    const empty = !!ctx.message?.text;
    const days = parseInt(empty ? "1" : ctx.message?.text.split(" ")[0] || "1");
    let message = `Showing matches of cricket in the next ${days} days`;
    const today = new Date();
    const tomorrow = new Date();
    tomorrow.setDate(today.getDate() + days);
    for (const match of data) {
      const match_time = new Date(getDate(match.match_time));
      if (match_time > today && match_time < tomorrow) {
        message += `${match.T1} vs ${match.T2} at ${match_time.toLocaleString()}
  `;
      }
    }
    if (message.length) ctx.reply(message);
  } catch (e) {
    console.log(e);
  }
});

bot.command("list_soccer", async (ctx) => {
  // find all soccer matches /list_soccer x
  const database = await saveDataAndReturn();
  const data = database["soccer"];
  let message = "";
  // find all soccer matches in the next x days
  const days = parseInt(ctx.message?.text.split(" ")[1] || "0");
  const today = new Date();
  const tomorrow = new Date();
  tomorrow.setDate(today.getDate() + days);
  for (const match of data) {
    const match_time = new Date(getDate(match.match_time));
    if (match_time > today && match_time < tomorrow) {
      message += `${match.T1} vs ${match.T2} at ${match_time.toLocaleString()}
`;
    }
  }
  ctx.reply(message);
});

async function checkMessageForBets(input: string): Promise<IBet> {
  // check for sports terms in the message
  try {
    const sportsTerms = await checkForSportsTerms(input);
    return sportsTerms;
  } catch (err) {
    return {};
  }
}

bot.hears(/.*/, async (ctx) => {
  // Process message and check for potential bets via an API
  const bets = await checkMessageForBets(ctx.message?.text || "");
  if (bets.EID && bets.match_time && bets.sport && bets.t1 && bets.t2) {
    console.log("Bets found: ", bets);
    // reply with would you like to bet on `sport` match between `t1` and `t2` at `time`
    // along with a button to url ozare-e8ed6.web.app
    // time format: yyyymmddhhmmss
    bets.match_time = bets.match_time?.toString();
    const readableTime =
      bets.match_time.slice(0, 4) +
      "-" +
      bets.match_time.slice(4, 6) +
      "-" +
      bets.match_time.slice(6, 8) +
      " " +
      bets.match_time.slice(8, 10) +
      ":" +
      bets.match_time.slice(10, 12) +
      ":" +
      bets.match_time.slice(12, 14);
    ctx.reply(
      `Would you like to bet on the game with following details?\nSport: *${(
        bets.sport as any
      ).capitalize()}*
Event: *${bets.t1}* vs *${bets.t2}*\nTime: *${readableTime}*`,
      {
        reply_markup: {
          inline_keyboard: [
            [
              {
                text: "Website",
                url: websiteURL,
              },
              {
                text: "Place Bet",
                // http://localhost:3000/place_bet/212?t1=hi&t2=bye
                url: `${betURL}${bets.EID}?t1=${bets.t1}&t2=${bets.t2}`,
              },
            ],
          ],
        },
        parse_mode: "Markdown",
        reply_to_message_id: ctx.message?.message_id,
      }
    );
  }
  console.log("Message received: ", ctx.message?.text);
});

bot.launch();
