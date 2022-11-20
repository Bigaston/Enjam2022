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
screen = "title" --"title" -- TODO: Remettre sur title

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

	initTitle()
	-- initMenu() -- TODO: Degager ça
end

loadGame()

function playdate.update()
	playdate.timer.updateTimers()
  	gfx.clear()

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

	playdate.drawFPS(0,0) -- FPS widget
end