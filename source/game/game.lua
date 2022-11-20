import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "game/player"
import "game/cultist"
import "game/pentacle"

local gfx <const> = playdate.graphics

borderSize = 2
minimumZoneX = borderSize
maximumZoneX = 400 - borderSize
minimumZoneY = borderSize
maximumZoneY = 240 - borderSize

amountOfCultists = 40

function initializeGame(level)
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
    initLevel(level)

    spawnCultists()
end

function drawGame()
    gfx.sprite.update()
end

function updateGame()
end

function initLevel(level)
    -- Load background pentacle
    local levelImage = gfx.image.new("images/levels/"..level)
    local pentacleSprite = Pentacle(levelImage)
    pentacleSprite:add()


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
        table.insert(cultistInstance, cultistArray)
        cultistInstance:add()
    end
end

function getPlayerPosition()
    return playerInstance:getPosition()
end
