import "vn/dialogue"
import "vn/background"
import "language"

local pd <const> = playdate

local dialogue
local background

function initLooseVN(level)
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/" .. level.looseDialogue)
  background = Background("images/vn/end_background")

  dialogue.skipable = false
  dialogue:open()

  function dialogue:closeCallback()
    initMenu()
    screen = "menu"
  end
end

function updateLooseVN()
  dialogue:update()
  background:update()
end

function drawLooseVN()
  background:draw()
  dialogue:draw()
end