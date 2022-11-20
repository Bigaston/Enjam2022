import "vn/dialogue"
import "vn/background"
import "language"

local pd <const> = playdate

local dialogue
local background

-- The VN part used when you loose the game
function initLooseVN()
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/" .. currentLevel.looseDialogue)
  background = Background("images/vn/end_background")

  dialogue.skipable = false
  dialogue:open()

  -- Return to main menu
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