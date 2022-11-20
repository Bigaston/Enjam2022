local pd <const> = playdate
local gfx <const> = pd.graphics

class("Player").extends(gfx.sprite)

function Player:init(x, y, image)
    Player.super.init(self)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self.currentRotation = 0
    self.rotationModifier = 5
    self:setImage(image)
    self:setCollideRect(0, 0, self:getSize())
    self:setZIndex(2)
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
        local actualX, actualY, collisions, length = self:moveWithCollisions(x, y)
        self.x = actualX
        self.y = actualY

        if length>0 then 
            self:manageKills(collisions)
        end
    end
end

-- Kills the collided cultist and spawns a plash
function Player:manageKills(collisions)
    for index, collision in pairs(collisions) do
        local collidedObject = collision['other']
        if collidedObject.className == "Cultist" then
            local splashImage = gfx.image.new("images/game/splash")
            local splashSprite = gfx.sprite.new(splashImage)
            splashSprite:moveTo(collidedObject.x, collidedObject.y)
            splashSprite:add()
            collidedObject:remove()
        end
    end
end

function Player:collisionResponse()
    return "overlap"
end

function Player:getPosition()
    return self.x, self.y
end

function Player:update()
    Player.super.update(self)
    self:manageRotation()
    self:manageMovement()
end