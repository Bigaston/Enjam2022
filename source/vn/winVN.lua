import "vn/dialogue"
import "vn/background"
import "language"

local pd <const> = playdate

local dialogue
local background

function initWinVN(level)
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/" .. level.winDialogue)
  background = Background("images/vn/end_background")

  dialogue.skipable = false
  dialogue:open()

  function dialogue:closeCallback()
    initMenu()
    screen = "menu"
  end
end

function updateWinVN()
  dialogue:update()
  background:update()
end

function drawWinVN()
  background:draw()
  dialogue:draw()
end