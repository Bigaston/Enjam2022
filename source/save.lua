local pd <const> = playdate

Save = {}

local levelWinInfo = {}
local config = {}
local defaultConfig <const> = {
  onehand = false,
  timer = true
}

function Save.init()
  local readData = pd.datastore.read("levelWin")
  if readData == nil then
    levelWinInfo = {}
  else
    levelWinInfo = readData
  end

  local readDataConfig = pd.datastore.read("config")
  if readDataConfig == nil then
    config = {}
  else
    config = readDataConfig
  end
end

function Save.newLevelWin(levelName)
  levelWinInfo[levelName] = true
  pd.datastore.write(levelWinInfo, "levelWin")
end

function Save.isLevelWin(levelName)
  if levelWinInfo[levelName] == nil then
    return false
  else
    return levelWinInfo[levelName]
  end
end

function Save.changeOption(option, enabled)
  config[option] = enabled
  pd.datastore.write(config, "config")
end

function Save.getOption(option)
  if config[option] == nil then
    return defaultConfig[option]
  else
    return config[option]
  end
end