local pd <const> = playdate
local gfx <const> = pd.graphics

-- A bloodcheckpoint class, used to define waypoints that has to be painted with blood by the player
class("BloodCheckpoint").extends(gfx.sprite)

function BloodCheckpoint:init(x, y, image)
    BloodCheckpoint.super.init(self)
    self.active = true
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self:setImage(image)
    self:setCollideRect(-2, -2, 4, 4)
    self:setZIndex(5)
end