import "CoreLibs/object"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Class that displays dialogue box
class('Dialogue').extends()

function Dialogue:init(text, opened) 
  Dialogue.super.init(self)
  self.text = text
  self.opened = opened
  self.openAnimation = false
end

function Dialogue:open()
  self.timerX = pd.timer.new(500, 0, 196, pd.easingFunctions.inOutSine)
  self.timerY = pd.timer.new(500, 0, 38, pd.easingFunctions.inOutSine)
  self.opened = false
  self.openAnimation = true
end

function Dialogue:update()
  if self.openAnimation then
    if not self.timerX.active then
      self.opened = true
      self.openAnimation = false
    end
  end
end

function Dialogue:draw()
  if self.openAnimation then
    gfx.drawRoundRect(200-self.timerX.value, 200 - self.timerY.value, self.timerX.value * 2, self.timerY.value * 2, 5)
  elseif self.opened then
    gfx.drawRoundRect(2, 160, 396, 78, 5)
  end
  -- gfx.drawText(self.timerX.value, 10, 10)
end