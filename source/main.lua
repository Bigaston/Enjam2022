import "CoreLibs/timer"
import "CoreLibs/math"
import "CoreLibs/sprites"
import "vn/vn"

local gfx <const> = playdate.graphics

local function loadGame()
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
end

local function updateGame()

end

local function drawGame()

end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0) -- FPS widget
end