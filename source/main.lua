import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "game/game"
import "vn/vn"
import "titleScreen"

local gfx <const> = playdate.graphics

screen = "game"

local function loadGame()
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	initTitle()
	initializeGame("nekoLevel")
end

loadGame()

function playdate.update()
	playdate.timer.updateTimers()
  	gfx.clear()

	if screen == "title" then
		updateTitle()
		drawTitle()
	elseif screen == "intro" then
		updateVN()
		drawVN()
	elseif screen == "game" then
		updateGame()
		drawGame()
	end

	playdate.drawFPS(0,0) -- FPS widget
end