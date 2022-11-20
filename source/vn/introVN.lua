import "vn/dialogue"
import "vn/background"
import "language"

local pd <const> = playdate

local dialogue
local background

-- The VN part used for the introduction of each levels.
function initIntroVN(level)
  currentLevel = level

  -- Load the levels from the disk
  dialogue = Dialogue.loadDialogueFromJSON("vn/dialogues/" .. Language.getLang() .. "/intro.json")
  background = Background("images/vn/cinematic_background")
  dialogue:open()

  -- Start the game
  function dialogue:closeCallback()
    initializeGame(level)
    screen = "game"
  end
end

function updateIntroVN()
  dialogue:update()
  background:update()
end

function drawIntroVN()
  background:draw()
  dialogue:draw()
end