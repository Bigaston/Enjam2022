local pd <const> = playdate

Save = {}

local levelWinInfo = {}

function Save.init()
  local readData = pd.datastore.read("levelWin")
  if readData == nil then
    levelWinInfo = {}
  else
    levelWinInfo = readData
  end
end

function Save.newLevelWin(levelName)
  levelWinInfo[levelName] = true
  pd.datastore.write("levelWin", levelWinInfo)
end

function Save.isLevelWin(levelName)
  if levelWinInfo[levelName] == nil then
    return false
  else
    return levelWinInfo[levelName]
  end
end