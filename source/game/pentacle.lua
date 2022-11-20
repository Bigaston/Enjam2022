local pd <const> = playdate
local gfx <const> = pd.graphics

class("Pentacle").extends(gfx.sprite)

function Pentacle:init(image)
    Pentacle.super.init(self)
    self:moveTo(200, 120)
    self.currentImage = image
    self:setImage(image)
    self:setZIndex(1)
end