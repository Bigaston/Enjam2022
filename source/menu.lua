import "CoreLibs/timer"
import "CoreLibs/ui"

import "language"

local pd <const> = playdate
local gfx <const> = pd.graphics
local ui
local uiText <const> = {"menu.level", "menu.lang"}
local langUi = 2

local selectorImg = gfx.image.new("images/menu/selector")
local leftRightImg = gfx.image.new("images/menu/leftright")

function initMenu()
  ui = pd.ui.gridview.new(350, 32)

  ui:setNumberOfRows(2)
  ui:setNumberOfColumns(1)
  ui:setCellPadding(0, 0, 0, 10)

  function ui:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
      selectorImg:draw(x, y)
    end

    gfx.drawRoundRect(x + 40, y, width-40, height, 5)

    if row ~= langUi then
      gfx.drawText(Language.getString(uiText[row]), x + 45, y + 7)
    else
      gfx.drawText(Language.getString(uiText[row]) .. " " .. Language.getDisplayLang(), x + 45, y + 7)
      leftRightImg:draw(x + width - 30, y)
    end
  end
end

function updateMenu()
  if pd.buttonJustPressed(pd.kButtonDown) then
    ui:selectNextRow(true)
  elseif pd.buttonJustPressed(pd.kButtonUp) then
    ui:selectPreviousRow(true)
  end

  if ui:getSelectedRow() == langUi then
    if pd.buttonJustPressed(pd.kButtonRight) or pd.buttonJustPressed(pd.kButtonLeft) then
      if Language.getLang() == "fr" then
        Language.setLang("en")
      else
        Language.setLang("fr")
      end
    end
  end
end

function drawMenu()
  ui:drawInRect(10, 10, 390, 190)
end