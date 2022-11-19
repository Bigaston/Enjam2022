local pd <const> = playdate
local gfx <const> = pd.graphics

class("Player").extends(gfx.sprite)

function Player:init(x, y, image)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self.currentRotation = 0
    self.rotationModifier = 5
    self:setImage(image)
    self:setCollideRect(0, 0, self:getSize())
end

function Player:manageRotation()
    if pd.buttonIsPressed(pd.kButtonRight) then
        self.currentRotation -= self.rotationModifier
        if self.currentRotation <= 0 then
            self.currentRotation += 360
        end
        self:setImage(self.currentImage:rotatedImage(360 - self.currentRotation))
        self:setCollideRect(0, 0, self:getSize())
    end
    if pd.buttonIsPressed(pd.kButtonLeft) then
        self.currentRotation += self.rotationModifier
        if self.currentRotation >= 360 then
            self.currentRotation -= 360
        end
        self:setImage(self.currentImage:rotatedImage(360 - self.currentRotation))
        self:setCollideRect(0, 0, self:getSize())
    end
end

-- Checks the crank to move forward or backward
function Player:manageMovement()
    local change, acceleratedChange = playdate.getCrankChange()
    local x = 0
    local y = 0
    speed = change/5

    if (self.currentRotation == 90 or currentRotation == 270) then
        -- the value of cos is too low and math.floor won't work
        x = self.x
    else   
        x = self.x + speed * math.cos(self.currentRotation * math.pi / 180)
    end

    if (self.currentRotation == 0 or currentRotation == 180) then
        -- the value of sin is too low and math.floor won't work
        y = self.y
    else   
        y = self.y - speed * math.sin(self.currentRotation * math.pi / 180)
    end
    
    -- Check if the player will be out of bounds, don't move if true
    if (x - self:getSize()/2 > minimumZoneX and x + self:getSize()/2 < maximumZoneX 
        and y - self:getSize()/2 > minimumZoneY and y + self:getSize()/2 < maximumZoneY) then
        self.x = x
        self.y = y
        self:moveTo(self.x, self.y)
    end

end

function Player:update()
    Player.super.update(self)
    self:manageRotation()
    self:manageMovement()
end