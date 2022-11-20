import "vn/dialogue"
import "vn/background"

local pd <const> = playdate
local gfx <const> = pd.graphics

local dialogue
local background

function initVN()
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/intro.json")
  background = Background("images/vn/cinematic_background")
  dialogue:open()
end

function updateVN()
  dialogue:update()
  background:update()
end

function drawVN()
  background:draw()
  dialogue:draw()
end