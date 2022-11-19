import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "game/game"
import "vn/vn"

local gfx <const> = playdate.graphics

local function loadGame()
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	initVN()
end

loadGame()
initializeGame()

function playdate.update()
	playdate.timer.updateTimers()

	updateVN()
	drawVN()
	playdate.drawFPS(0,0) -- FPS widget
end