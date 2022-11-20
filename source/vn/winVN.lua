import "vn/dialogue"
import "vn/background"
import "language"

local dialogue
local background

-- The VN part used when you win the game
function initWinVN()
  Save.newLevelWin(currentLevel.levelName)
  playdate.stopAccelerometer()

  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/" .. currentLevel.winDialogue)
  background = Background("images/vn/end_background")

  dialogue.skipable = false
  dialogue:open()

  -- Return to main menu
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