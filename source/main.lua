import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "game/game"
import "vn/vn"
import "titleScreen"

local gfx <const> = playdate.graphics

screen = "title"

local function loadGame()
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	initTitle()
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
	end

	playdate.drawFPS(0,0) -- FPS widget
end