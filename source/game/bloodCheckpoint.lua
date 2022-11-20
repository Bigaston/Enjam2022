local pd <const> = playdate
local gfx <const> = pd.graphics

class("BloodCheckpoint").extends(gfx.sprite)

function BloodCheckpoint:init(x, y, image)
    BloodCheckpoint.super.init(self)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self:setImage(image)
    self:setCollideRect(0, 0, self:getSize())
    self:setZIndex(5)
end