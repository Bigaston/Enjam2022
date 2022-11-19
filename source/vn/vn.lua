import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

local backgroundImage = gfx.image.new("images/vn/cinematic_background")
local backgroundX = 0

function updateVN()
  backgroundX = math.sin(pd.getCurrentTimeMilliseconds()/3000) * 94 - 94
end

function drawVN()
  gfx.clear()
  backgroundImage:draw(backgroundX, 0)

end