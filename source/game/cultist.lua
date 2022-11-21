import "game/game"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- A cultist, the enemy of the game
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
    self.distanceToBeCalmAfterFear = 100
    self.speed = 1
    self.speedToFlee = 1.5
    self.maxDeltaForRandomMovements = 10
    self:setCollideRect(0, 0, self:getSize())
    self:setZIndex(9)
end

-- Makes a cultist stop running away
function calmCultist(cultist)
    cultist.isScared = false
    cultist:generateRoamLocation()
end

function Cultist:update()
    -- Checking if the cultist is scared
    local playerX, playerY = getPlayerPosition()
    local playerDistanceX = playerX-self.x
    local playerDistanceY = playerY-self.y

    if math.sqrt((playerDistanceX)^2 + (playerDistanceY)^2) <= self.distanceToBeScared then
        self.isScared = true
    elseif self.isScared and math.sqrt((playerDistanceX)^2 + (playerDistanceY)^2) > self.distanceToBeCalmAfterFear then
        self.isScared = false
        self:generateRoamLocation()
    end

    if self.isScared then
        -- Cultist scared, fleeing away from the player
        self:runAway(playerX, playerY)
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
    self.targetLocationX = self.x + self:randomInBoundsDeltaX()
    self.targetLocationY = self.y + self:randomInBoundsDeltaY()
end

-- Run away from the player
function Cultist:runAway(playerX, playerY)
    local directionToFleeX = self.x - playerX
    local directionToFleeY = self.y - playerY

    -- Normalizes the movement
    local xToMove = (directionToFleeX) / math.sqrt(directionToFleeX^2 + directionToFleeY^2) 
    local yToMove = (directionToFleeY) / math.sqrt(directionToFleeX^2 + directionToFleeY^2) 

    -- Checks if the movement is in bounds
    if self.x + xToMove * self.speedToFlee > maximumZoneX or self.x + xToMove * self.speedToFlee < minimumZoneX then
        xToMove = 0
    end
    if self.y + yToMove * self.speedToFlee > maximumZoneY or self.y + yToMove * self.speedToFlee < minimumZoneY then
        yToMove = 0
    end

    -- Moves
    self:moveBy(xToMove * self.speedToFlee, yToMove * self.speedToFlee)
end

-- Moves to targetLocation and checks if the cultists has reached the location
function Cultist:roamToTarget()
    local directionX = self.targetLocationX-self.x
    local directionY = self.targetLocationY-self.y

    -- If close enough 
    if math.abs(directionX) < self.speed and math.abs(directionY) < self.speed then
        self.hasReachedLocation = true
        return
    end

    local xToMove = (directionX) / math.sqrt(directionX^2 + directionY^2) 
    local yToMove = (directionY) / math.sqrt(directionX^2 + directionY^2) 

    -- Apply the movespeed to the normalized vector on x or y
    self:moveBy(xToMove * self.speed, yToMove * self.speed)
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