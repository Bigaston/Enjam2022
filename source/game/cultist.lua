import "game/game"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Cultist").extends(gfx.sprite)

function Cultist:init(x, y, image)
    Cultist.super.init(self)
    self.x = x
    self.y = y
    self:moveTo(self.x, self.y)
    self.currentImage = image
    self.currentRotation = 0
    self.rotationModifier = 5
    self:setImage(image)
    self.hasReachedLocation = true
    self.targetLocationX = 0
    self.targetLocationY = 0
    self.isScared = false
    self.distanceToBeScared = 60
    self.speed = 1
    self.maxDeltaForRandomMovements = 10
    self:setCollideRect(0, 0, self:getSize())
    self:setZIndex(1)
end

function Cultist:update()

    -- Checking if the cultist is scared
    local playerX, playerY = getPlayerPosition()
    self.isScared = (math.sqrt((playerX-self.x)^2 + (playerY-self.y)^2) <= self.distanceToBeScared)

    if self.isScared then
        -- Cultist scared, fleeing away from the player
        self:runAway(playerX, playerY)
        -- TODO
    elseif (self.hasReachedLocation and not self.isScared) then
        -- Cultist not scared, looking for a new location to roam
        self:generateRoamLocation()
    elseif (not self.isScared) then
        -- Cultist calm, roaming to target
        self:roamToTarget()
    end
end

-- Generates a random location for the cultist to roam to, by changing x OR y by a maximum value of self.maxDeltaForRandomMovements
function Cultist:generateRoamLocation()
    self.hasReachedLocation = false
    local changeXorY = math.random(2)
    if (changeXorY == 1) then
        self.targetLocationX = self.x + self:randomInBoundsDeltaX()
        self.targetLocationY = self.y
    else
        self.targetLocationX = self.x
        self.targetLocationY = self.y + self:randomInBoundsDeltaY()
    end
end

-- Run away from the player
function Cultist:runAway(playerX, playerY)
    local directionToFleeX = self.x - playerX
    local directionToFleeY = self.y - playerY

    local normalizedX = 0
    local normalizedY = 0

    -- Normalize x and y
    if (directionToFleeX ~= 0) then
        normalizedX = (directionToFleeX)/math.abs(directionToFleeX)
    end
    if (directionToFleeY ~= 0) then
        normalizedY = (directionToFleeY)/math.abs(directionToFleeY)
    end

    self:moveBy(normalizedX * self.speed, normalizedY * self.speed)
end

-- Moves to targetLocation and checks if the cultists has reached the location
function Cultist:roamToTarget()
    local normalizedX = 0
    local normalizedY = 0

    -- Normalize x and y
    if (self.targetLocationX-self.x ~= 0) then
        normalizedX = (self.targetLocationX-self.x)/math.abs(self.targetLocationX-self.x)
    elseif (self.targetLocationY-self.y ~= 0) then
        normalizedY = (self.targetLocationY-self.y)/math.abs(self.targetLocationY-self.y)
    end

    -- Apply the movespeed to the normalized vector on x or y
    self:moveBy(normalizedX * self.speed, normalizedY * self.speed)

    -- If close enough 
    if math.abs(self.targetLocationX-self.x) < self.speed and math.abs(self.targetLocationY-self.y) < self.speed then
        self.hasReachedLocation = true
    end
end

-- Careful! self.x has to already be in bound or infinite loop
function Cultist:randomInBoundsDeltaX()
    local randomizedDelta = 999
    while (self.x + randomizedDelta < minimumZoneX or self.x + randomizedDelta > maximumZoneX) do
        randomizedDelta = math.random(-1 * self.maxDeltaForRandomMovements, self.maxDeltaForRandomMovements)
    end
    return randomizedDelta
end

-- Careful! self.y has to already be in bound or infinite loop
function Cultist:randomInBoundsDeltaY()
    local randomizedDelta = 999
    while (self.y + randomizedDelta < minimumZoneY or self.y + randomizedDelta > maximumZoneY) do
        randomizedDelta = math.random(-1 * self.maxDeltaForRandomMovements, self.maxDeltaForRandomMovements)
    end
    return randomizedDelta
end