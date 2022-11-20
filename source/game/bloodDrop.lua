local pd <const> = playdate
local gfx <const> = pd.graphics

class("BloodDrop").extends(gfx.sprite)

function BloodDrop:init(x, y, image)
    BloodDrop.super.init(self)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self:setImage(image)
    self:setCollideRect(0, 0, self:getSize())
    self:setZIndex(5)
end