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
amountOfAliveCultists = amountOfCultists

function initializeGame(jsonObject)
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

    spawnCultists()
end

function drawGame()
    gfx.sprite.update()
end

function updateGame()
    if playerInstance.currentBloodPool == 0 and amountOfAliveCultists == 0 then
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
