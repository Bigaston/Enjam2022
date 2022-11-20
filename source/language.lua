local lang = "fr" -- french/english
local displayLang = {
  fr = "Francais",
  en = "English"
}

local langDict = {}

Language = {}

function Language.init()
  local readData = playdate.datastore.read("lang")
  if readData ~= nil then
    lang = readData["currentLang"]
  end

  langDict.en = json.decodeFile("lang/en.json")
  langDict.fr = json.decodeFile("lang/fr.json")
end

function Language.getString(string)
  if langDict[lang][string] ~= nil then
    return langDict[lang][string]
  else
    return string
  end
end

function Language.setLang(newLang) 
  if newLang == "fr" or newLang == "en" then
    lang = newLang
    playdate.datastore.write({currentLang = newLang}, "lang")
  end
end

function Language.getLang()
  return lang
end

function Language.getDisplayLang()
  return displayLang[lang]
end