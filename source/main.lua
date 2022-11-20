import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "language"
import "game/game"
import "vn/vn"
import "titleScreen"
import "menu"

local gfx <const> = playdate.graphics

-- title menu intro game
screen = "title" --"title" -- TODO: Remettre sur title

local function loadGame()
	Language.init()
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
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
	elseif screen == "intro" then
		updateVN()
		drawVN()
	end

	playdate.drawFPS(0,0) -- FPS widget
end