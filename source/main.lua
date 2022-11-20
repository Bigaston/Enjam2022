import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "language"
import "game/game"
import "vn/introVN"
import "vn/looseVN"
import "vn/winVN"
import "titleScreen"
import "menu"
import "audio"
import "save"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- title menu intro game
screen = "title" --"title" -- TODO: Remettre sur title

-- All the levels informations
levels = nil
-- All the levels json files names
levelFiles = nil
-- the data of the current level
currentLevel = nil

local function loadGame()
	-- Initiate the libs
	Language.init()
	Audio.init()
	Save.init()

	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random

	-- Gather all the informations about the levels
	levelFiles = pd.file.listFiles("levels")
	levels = {}

	for i = 1, #levelFiles, 1 do
		levels[i] = json.decodeFile("levels/" .. levelFiles[i])
	end

	-- Init the title screen
	initTitle()

	--initGame()
end

loadGame()

function playdate.update()
	gfx.clear()

	-- Update the current music
	Audio.playMusic()
	
	playdate.timer.updateTimers()

	-- Draw/update the good screen
	if screen == "menu" then		
		updateMenu()
		drawMenu()
	elseif screen == "title" then
		updateTitle()
		drawTitle()
	elseif screen == "introVN" then
		updateIntroVN()
		drawIntroVN()
	elseif screen == "winVN" then
		updateWinVN()
		drawWinVN()
	elseif screen == "looseVN" then
		updateLooseVN()
		drawLooseVN()
	elseif screen == "game" then
		updateGame()
		drawGame()
	end
end

