local pd <const> = playdate
local gfx <const> = pd.graphics

class("Cultist").extends(gfx.sprite)

function Cultist:init(x, y, image)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self.currentRotation = 0
    self.rotationModifier = 5
    self:setImage(image)
end