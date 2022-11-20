local pd <const> = playdate
local gfx <const> = pd.graphics

class("BloodCheckpoint").extends(gfx.sprite)

function BloodCheckpoint:init(x, y, image)
    BloodCheckpoint.super.init(self)
    self.active = true
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self:setImage(image)
    self:setCollideRect(-5, -5, 10, 10)
    self:setZIndex(5)
end