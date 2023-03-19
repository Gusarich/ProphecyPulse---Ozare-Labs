import { Telegraf } from "telegraf";
import axios from "axios";
require("dotenv").config();

const API_TOKEN = process.env.BOT_API_TOKEN || "";

const bot = new Telegraf(API_TOKEN);

const languages = [
  { code: "en", name: "English" },
  { code: "es", name: "Español" },
  { code: "fr", name: "Français" },
  { code: "ru", name: "Русский" },
];

const userLanguage = {};

const _t = (ctx: any, text: string) => {
  // @ts-ignore
  const language = userLanguage[ctx?.from?.id] || "es";
  return text;
};

const websiteURL = "https://ozare-e8ed6.web.app/";
const documentationURL = "https://ozare-e8ed6.web.app/";

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
              url: "https://twitter.com/ozareapp",
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
    } else if (language.code === "es") {
      ctx.reply(`Su idioma ha sido establecido en ${language.name}.`);
    } else if (language.code === "fr") {
      ctx.reply(`Votre langue a été définie sur ${language.name}.`);
    } else if (language.code === "ru") {
      ctx.reply(`Ваш язык был установлен на ${language.name}.`);
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

  return [];
}

async function checkMessageForBets(input: string): Promise<any[]> {
  // check for sports terms in the message
  const sportsTerms = await checkForSportsTerms(input);
  return [];
}

bot.hears(/.*/, async (ctx) => {
  // Process message and check for potential bets via an API
  const message = ctx.message.text;
  if ((await checkMessageForBets(message)).length) {
    ctx.reply("You have a bet!");
  }
});

bot.launch().then(() => {
  console.log("Bot started!");
});
