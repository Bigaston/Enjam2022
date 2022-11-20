local pd <const> = playdate

Save = {}

local levelWinInfo = {}

function Save.init()
  local readData = pd.datastore.read("levelWin")
  printTable(readData)
  if readData == nil then
    levelWinInfo = {}
  else
    levelWinInfo = readData
  end

  printTable(levelWinInfo)
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