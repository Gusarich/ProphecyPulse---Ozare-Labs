import { Telegraf } from "telegraf";
import axios from "axios";
import { saveDataAndReturn } from "./getDatabase";
require("dotenv").config();

const API_TOKEN = process.env.BOT_API_TOKEN || "";

const bot = new Telegraf(API_TOKEN);

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

const websiteURL = "https://ozare-e8ed6.web.app/";
const documentationURL =
  "https://ozare.gitbook.io/untitled/welcome/prophecypulse";
const twitterURL = "https://twitter.com/ozareapp";

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

async function checkForSportsTerms(input: string): Promise<string[]> {
  // check for sports terms in the message
  const database = await saveDataAndReturn();
  const cricketTerms = [
    "cricket",
    "century",
    "wicket",
    "six",
    "four",
    "ball",
    "over",
    "run",
    "bat",
    "bowl",
    "stump",
    "umpire",
    "fielder",
    "win",
    "lose",
    "draw",
    "keeper",
    "out",
    "catch",
    "batsman",
  ];
  const soccerTerms = [
    "scores",
    "soccer",
    "goal",
    "penalty",
    "red card",
    "yellow card",
    "offside",
    "corner",
    "free kick",
    "throw in",
    "foul",
    "keeper",
    "defender",
    "striker",
    "midfielder",
    "winger",
    "fullback",
    "goalkeeper",
    "forward",
    "attack",
    "defend",
    "win",
    "lose",
    "draw",
  ];
  const basketballTerms = [
    "win",
    "basketball",
    "lose",
    "draw",
    "Airball",
    "Alley-oop",
    "Assist",
    "Backboard",
    "Backcourt",
    "Backdoor",
    "Ball handler",
    "Bank shot",
    "Baseline",
    "Block",
    "Board",
    "Bounce pass",
    "Box out",
    "Brick",
    "Buzzer beater",
    "Charge",
    "Dribble",
    "Dunk",
    "Fastbreak",
    "Field goal",
    "Foul",
    "Free throw",
    "Guard",
    "Half-court",
    "High post",
    "Hook shot",
    "Inbounds",
    "Jump ball",
    "Jump shot",
    "Layup",
    "Low post",
    "Man-to-man defense",
    "Offense",
    "Outlet pass",
    "Overtime",
    "Pass",
    "Perimeter",
    "Pick",
    "Pick and roll",
    "Post-up",
    "Rebound",
    "Screen",
    "Shot clock",
    "Slam dunk",
    "Steal",
    "Three-point line",
    "Traveling",
    "Turnover",
    "Zone defense",
  ];
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
        const index = lowerCaseDataString.indexOf(words[i].toLocaleLowerCase());
        console.log(words[i], index);
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
          return [EID, sport, t1, t2, match_time];
        }
      }
    }
  }
  return [];
}

Object.defineProperty(String.prototype, "capitalize", {
  value: function () {
    return this.charAt(0).toUpperCase() + this.slice(1);
  },
  enumerable: false,
});

async function checkMessageForBets(input: string): Promise<any[]> {
  // check for sports terms in the message
  const sportsTerms = await checkForSportsTerms(input);
  return sportsTerms;
}

bot.hears(/.*/, async (ctx) => {
  // Process message and check for potential bets via an API
  const bets = await checkMessageForBets(ctx.message?.text || "");
  if (bets.length > 0) {
    console.log("Bets found: ", bets);
    // reply with would you like to bet on `sport` match between `t1` and `t2` at `time`
    // along with a button to url ozare-e8ed6.web.app
    // time format: yyyymmddhhmmss
    bets[4] = bets[4].toString();
    const readableTime =
      bets[4].slice(0, 4) +
      "-" +
      bets[4].slice(4, 6) +
      "-" +
      bets[4].slice(6, 8) +
      " " +
      bets[4].slice(8, 10) +
      ":" +
      bets[4].slice(10, 12) +
      ":" +
      bets[4].slice(12, 14);
    ctx.reply(
      `Would you like to bet on the game with following details?\nSport: *${bets[1].capitalize()}*
Event: *${bets[2]}* vs *${bets[3]}*\nTime: *${readableTime}*`,
      {
        reply_markup: {
          inline_keyboard: [
            [
              {
                text: "Website",
                url: websiteURL,
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
