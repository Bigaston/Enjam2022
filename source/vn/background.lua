import "CoreLibs/object"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Background").extends()

function Background:init(imagePath)
  Background.super.init(self)

  self.imagePath = imagePath
  self.image = gfx.image.new(imagePath)
  self.x = 0
  self.width = self.image:getSize()
end

function Background:update()
  self.x = (math.sin(pd.getCurrentTimeMilliseconds()/3000) * ((self.width - 400) / 2)) - (self.width - 400) / 2
end

function Background:draw()
  self.image:draw(self.x, 0)
end