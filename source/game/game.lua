import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "game/player"
import "game/cultist"

local gfx <const> = playdate.graphics

borderSize = 2
minimumZoneX = borderSize
maximumZoneX = 400 - borderSize
minimumZoneY = borderSize
maximumZoneY = 240 - borderSize

function initializeGame()
    -- Init player instance
    local playerImage = gfx.image.new("images/game/rightPlayerPlusGros")
    local playerInstance = Player(200, 120, playerImage)
    playerInstance:add()

    -- Init border
    local borderImage = gfx.image.new("images/game/border")
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            gfx.setClipRect(x, y, width, height)
            borderImage:draw(0, 0)
        end
    )

    spawnCultists()
end

function drawGame()
    gfx.sprite.update()
end

function updateGame()

end

function spawnCultists()
end
