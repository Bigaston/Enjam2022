import "CoreLibs/timer"
import "CoreLibs/easing"
import "CoreLibs/graphics"

import "audio"

local pd <const> = playdate
local gfx <const> = pd.graphics

local logo
local timer
local yTitle = -132
local yBigaucho = 100
local yText = 180
local bigauchoImage
local blinkText = 20

-- Title screen of the game
function initTitle()
  logo = gfx.image.new("images/menu/logo")
  bigauchoImage = gfx.image.new("images/vn/bigaucho_detresse")
  timer = pd.timer.new(1000, -132, 5, pd.easingFunctions.outBounce)
end

function updateTitle()
  -- Animation of the logo of the game
  if timer.active then
    yTitle = timer.value
  else
    yTitle = 5 - math.sin(pd.getCurrentTimeMilliseconds()/1000) * 2
  end

  -- Update the position with sin
  yBigaucho = 100 - math.sin(pd.getCurrentTimeMilliseconds()/500) * 3
  yText = 180 - math.sin(pd.getCurrentTimeMilliseconds()/200) * 3

  blinkText -= 1

  -- made the "START THE GAME" button blink
  if blinkText == -10 then
    blinkText = 20
  end

  if pd.buttonJustPressed(pd.kButtonA) or pd.buttonJustPressed(pd.kButtonRight) then
    Audio.playUI("buttons_navigation_click")

    initMenu()
    screen = "menu"
  end
end

function drawTitle()
  logo:draw(5, yTitle)

  if blinkText >= 0 then
    gfx.drawTextAligned("PRESS Ⓐ TO PLAY", 300, yText, kTextAlignment.center)
  end

  bigauchoImage:draw(5, yBigaucho)
end