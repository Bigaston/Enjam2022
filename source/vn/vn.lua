import "CoreLibs/sprites"
import "vn/dialogue"

local pd <const> = playdate
local gfx <const> = pd.graphics

local backgroundImage = gfx.image.new("images/vn/cinematic_background")
local backgroundX = 0

function initVN()
  local fantaDialogues = {
    {text = "Salut ma couille, c'est Fanta\nJ'aime les NFT", image = "images/vn/fanta.png", speed = 1},
    {text = "Tu veux payer sur VVFrance\navec moi?", image = "images/vn/fanta.png", speed = 3}
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
  -- gfx.fillRect(10, 20, 150, 260)
  dialogue:draw()
end