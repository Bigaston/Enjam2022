local lang = "en" -- current language, fr/en
local displayLang = { -- The display name of the languages
  fr = "Francais",
  en = "English"
}

local langDict = {} -- All the strings

Language = {}

-- Function that need to be called at the beginning of the game
-- to load each strings
function Language.init()
  local readData = playdate.datastore.read("lang")
  if readData ~= nil then
    lang = readData["currentLang"]
  end

  langDict.en = json.decodeFile("lang/en.json")
  langDict.fr = json.decodeFile("lang/fr.json")
end

-- Return the string on the current language base on the name
function Language.getString(string)
  if langDict[lang][string] ~= nil then
    return langDict[lang][string]
  else
    return string
  end
end

-- Change the current language
function Language.setLang(newLang) 
  -- Check is the lang code is valide
  if newLang == "fr" or newLang == "en" then
    lang = newLang
    playdate.datastore.write({currentLang = newLang}, "lang")
  end
end

-- Get the current language
function Language.getLang()
  return lang
end

-- Get the current language display name
function Language.getDisplayLang()
  return displayLang[lang]
end