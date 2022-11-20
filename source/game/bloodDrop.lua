local pd <const> = playdate
local gfx <const> = pd.graphics

-- A class defining the splashes of blood the player can drop using its blood pool
class("BloodDrop").extends(gfx.sprite)

function BloodDrop:init(x, y, image)
    BloodDrop.super.init(self)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self:setImage(image)
    self:setZIndex(0)
end