import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "language"
import "game/game"
import "vn/introVN"
import "titleScreen"
import "menu"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- title menu intro game
screen = "game" --"title" -- TODO: Remettre sur title

levels = nil
levelFiles = nil

local function loadGame()
	Language.init()
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random

	levelFiles = pd.file.listFiles("levels")
	levels = {}

	for i = 1, #levelFiles, 1 do
		levels[i] = json.decodeFile("levels/" .. levelFiles[i])
	end

	--initTitle()
	initializeGame(levels[1])
end

loadGame()

function playdate.update()
	gfx.clear()

	playdate.timer.updateTimers()
	gfx.sprite.update()

	if screen == "menu" then		
		updateMenu()
		drawMenu()
	elseif screen == "title" then
		updateTitle()
		drawTitle()
	elseif screen == "introVN" then
		updateIntroVN()
		drawIntroVN()
	elseif screen == "game" then
		updateGame()
		drawGame()
	end

end

