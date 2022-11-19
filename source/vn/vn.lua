import "CoreLibs/sprites"
import "vn/dialogue"

local pd <const> = playdate
local gfx <const> = pd.graphics

local backgroundImage = gfx.image.new("images/vn/cinematic_background")
local backgroundX = 0

function initVN()
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/fanta-intro.json")
  dialogue:open()
end

function updateVN()
  dialogue:update()
  backgroundX = math.sin(pd.getCurrentTimeMilliseconds()/3000) * 94 - 94
end

function drawVN()
  gfx.clear()
  backgroundImage:draw(backgroundX, 0)
  -- gfx.fillRect(10, 20, 150, 260)
  dialogue:draw()
end