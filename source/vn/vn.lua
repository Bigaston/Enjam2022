import "CoreLibs/sprites"
import "vn/dialogue"

local pd <const> = playdate
local gfx <const> = pd.graphics

local backgroundImage = gfx.image.new("images/vn/cinematic_background")
local backgroundX = 0

function initVN()
  local fantaDialogues = {
    "Salut ma couille, c'est Fanta\nJ'aime les NFT",
    "Tu veux payer sur VVFrance\navec moi?"
  }
  dialogue = Dialogue(fantaDialogues, false)
  dialogue:open()
end

function updateVN()
  dialogue:update()
  backgroundX = math.sin(pd.getCurrentTimeMilliseconds()/3000) * 94 - 94
end

function drawVN()
  gfx.clear()
  backgroundImage:draw(backgroundX, 0)
  dialogue:draw()
end