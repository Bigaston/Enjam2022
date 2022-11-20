import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "game/player"
import "game/cultist"
import "game/pentacle"
import "game/bloodCheckpoint"
import "vn/looseVN"

local gfx <const> = playdate.graphics
numberOfCheckpoints = 0
checkpointsReached = 0

borderSize = 2
minimumZoneX = borderSize
maximumZoneX = 400 - borderSize
minimumZoneY = borderSize
maximumZoneY = 240 - borderSize

amountOfCultists = 40

local playTimer = nil
local timeToCompleteLevel = 120

function initializeGame(jsonObject)
    -- Removal of all sprites
    gfx.sprite.removeAll()
    amountOfAliveCultists = amountOfCultists

    -- Init player instance
    local playerImage = gfx.image.new("images/game/player")
    playerInstance = Player(200, 120, playerImage)
    playerInstance:add()

    -- Init border
    local borderImage = gfx.image.new("images/game/border")
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            gfx.setClipRect(x, y, width, height)
            borderImage:draw(0, 0)
        end
    )

    -- Init level
    initLevel(jsonObject)

    playTimer = playdate.timer.new(timeToCompleteLevel * 1000, timeToCompleteLevel, 0)

    spawnCultists()
end

function drawGame()
	gfx.sprite.update()

    drawTime()
    drawBloodJauge()
end

function updateGame()
    if playerInstance.currentBloodPool == 0 and amountOfAliveCultists == 0 then
        -- LOOSE
        initLooseVN()
        screen = "looseVN"
    end

    
	if playTimer.value == 0 then
		-- LOOSE
        initLooseVN()
        screen = "looseVN"
	end
end

function initLevel(jsonObject)
    printTable(jsonObject)
    -- Load background pentacle
    local levelImage = gfx.image.new(jsonObject.backgroundImage)
    local pentacleSprite = Pentacle(levelImage)
    pentacleSprite:add()

    -- Checkpoints management
    local checkpointImage = gfx.image.new("images/game/bloodCheckpoint")
    checkpoints = jsonObject.checkpoints
    numberOfCheckpoints = #checkpoints
    checkpointsReached = 0
    gameIsWon = false
    for i = 1, numberOfCheckpoints, 1 do
        local checkpointSprite = BloodCheckpoint(checkpoints[i][1], checkpoints[i][2], checkpointImage)
        checkpointSprite:add()
    end

end

function spawnCultists()
    local cultistImage = gfx.image.new("images/game/cultist")

    for i = 1, amountOfCultists, 1 do
        local spawnX = 200
        local spawnY = 120

        -- While the cultist spawn is too close of the steamroller spawn, generate it again
        while (math.sqrt((200-spawnX)^2 + (120-spawnY)^2) < 40) do
            spawnX = math.random(borderSize, 400 - borderSize)
            spawnY = math.random(borderSize, 240 - borderSize)
        end

        local cultistInstance = Cultist(spawnX, spawnY, cultistImage)
        cultistInstance:add()
    end
end

function getPlayerPosition()
    return playerInstance:getPosition()
end

function drawTime()
	gfx.setColor(gfx.kColorWhite)
	gfx.fillRoundRect(2, 2, 48, 19, 2)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRoundRect(2, 2, 48, 19, 2)

	local hourglassImage = gfx.image.new("images/game/hourglass")
	gfx.image.draw(hourglassImage, 4, 4)
	gfx.drawText(math.floor(playTimer.value), 24, 4)
end

function drawBloodJauge()
	gfx.setColor(gfx.kColorWhite)
	gfx.fillRoundRect(340, 2, 70, 20, 2)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRoundRect(340, 2, 70, 20, 2)

	local bloodIconImage = gfx.image.new("images/game/bloodIcon")
	gfx.image.draw(bloodIconImage, 340, 4)
	gfx.drawTextAligned(playerInstance:getBloodPool() .. " L", 360, 4)
end