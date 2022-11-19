import "CoreLibs/object"

local pd <const> = playdate
local gfx <const> = pd.graphics

local openingTime <const> = 500
local frameBetweenText <const> = 5

-- Class that displays dialogue box
class('Dialogue').extends()

function Dialogue:init(text, opened) 
  Dialogue.super.init(self)
  self.text = text
  self.opened = opened

  self.textAnimation = false
  self.textElapsedFrame = 0
  self.textDisplayChar = 0

  self.openAnimation = false
end

function Dialogue:open()
  self.timerX = pd.timer.new(openingTime, 0, 196, pd.easingFunctions.inOutSine)
  self.timerY = pd.timer.new(openingTime, 0, 38, pd.easingFunctions.inOutSine)
  self.opened = false
  self.textAnimation = false
  self.openAnimation = true
end

function Dialogue:update()
  if self.openAnimation then
    if not self.timerX.active then
      self.opened = true
      self.textAnimation = true
      self.textElapsedFrame = frameBetweenText
      
      self.openAnimation = false
    end
  end

  if self.textAnimation then
    if self.textElapsedFrame == 0 then
      self.textElapsedFrame = frameBetweenText
      self.textDisplayChar +=1 
    else 
      self.textElapsedFrame-=1
    end
  end
end

function Dialogue:draw()
  if self.openAnimation then
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(200-self.timerX.value, 200 - self.timerY.value, self.timerX.value * 2, self.timerY.value * 2, 5)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(200-self.timerX.value, 200 - self.timerY.value, self.timerX.value * 2, self.timerY.value * 2, 5)
  elseif self.opened then
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(2, 160, 396, 78, 5)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(2, 160, 396, 78, 5)
  end

  if self.textAnimation then
    gfx.drawText(string.sub(self.text, 0, self.textDisplayChar), 5, 163)
  end
  -- gfx.drawText(self.timerX.value, 10, 10)
end