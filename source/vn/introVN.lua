import "vn/dialogue"
import "vn/background"
import "language"

local pd <const> = playdate
local gfx <const> = pd.graphics

local dialogue
local background

function initIntroVN(level)
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/intro.json")
  background = Background("images/vn/cinematic_background")
  dialogue:open()
end

function updateIntroVN()
  dialogue:update()
  background:update()
end

function drawIntroVN()
  background:draw()
  dialogue:draw()
end