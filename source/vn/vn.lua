import "vn/dialogue"
import "vn/background"
import "language"

local pd <const> = playdate
local gfx <const> = pd.graphics

local dialogue
local background

function initVN(level)
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/intro.json")
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