import "CoreLibs/timer"
import "CoreLibs/ui"

import "language"
import "audio"

local pd <const> = playdate
local gfx <const> = pd.graphics
local menuUi
local menuUiText <const> = {"menu.level", "menu.lang"}
local langUi = 2

local levelUi
local levelUiText <const> = {"menu.level1", "menu.level2", "menu.level3", "menu.level4"}

local menuScreen = "base"
local menuChangeTimer
local menuDifferentY = 0

local selectorImg = gfx.image.new("images/menu/selector")
local leftRightImg = gfx.image.new("images/menu/leftright")

function initMenu()
  menuUi = pd.ui.gridview.new(350, 32)

  menuUi:setNumberOfRows(2)
  menuUi:setNumberOfColumns(1)
  menuUi:setCellPadding(0, 0, 0, 10)

  function menuUi:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
      selectorImg:draw(x, y)
    end

    gfx.drawRoundRect(x + 40, y, width-40, height, 5)

    if row ~= langUi then
      gfx.drawText(Language.getString(menuUiText[row]), x + 45, y + 7)
    else
      gfx.drawText(Language.getString(menuUiText[row]) .. " " .. Language.getDisplayLang(), x + 45, y + 7)
      leftRightImg:draw(x + width - 30, y)
    end
  end

  levelUi = pd.ui.gridview.new(350, 32)
  levelUi:setNumberOfRows(#levels)
  levelUi:setNumberOfColumns(1)
  levelUi:setCellPadding(0, 0, 0, 10)

  function levelUi:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
      selectorImg:draw(x, y)
    end

    gfx.drawRoundRect(x + 40, y, width-40, height, 5)

    gfx.drawText(levels[row].levelName, x + 45, y + 7)
  end
end

function updateMenu()
  if menuChangeTimer ~= nil and menuChangeTimer.active then
    menuDifferentY = menuChangeTimer.value
  end

  if menuScreen == "base" then
    if pd.buttonJustPressed(pd.kButtonDown) then
      menuUi:selectNextRow(true)
      Audio.playUI("buttons_navigation_down")
    elseif pd.buttonJustPressed(pd.kButtonUp) then
      menuUi:selectPreviousRow(true)
      Audio.playUI("buttons_navigation_up")
    end

    if menuUi:getSelectedRow() == 1 and (pd.buttonJustPressed(pd.kButtonA) or pd.buttonJustPressed(pd.kButtonRight)) then
      if menuChangeTimer == nil or not menuChangeTimer.active then
        menuChangeTimer = pd.timer.new(1000, 0, -400, pd.easingFunctions.inOutCubic)
        levelUi:setSelectedRow(1)
        Audio.playUI("buttons_navigation_click")

        function menuChangeTimer:timerEndedCallback()
          menuScreen = "level"
        end
      end
    end

    if menuUi:getSelectedRow() == langUi then
      if pd.buttonJustPressed(pd.kButtonRight) or pd.buttonJustPressed(pd.kButtonLeft) or pd.buttonJustPressed(pd.kButtonA) then
        Audio.playUI("buttons_navigation_click")
        if Language.getLang() == "fr" then
          Language.setLang("en")
        else
          Language.setLang("fr")
        end
      end
    end
  elseif menuScreen == "level" then
    if pd.buttonJustPressed(pd.kButtonDown) then
      levelUi:selectNextRow(true)
      Audio.playUI("buttons_navigation_down")
    elseif pd.buttonJustPressed(pd.kButtonUp) then
      levelUi:selectPreviousRow(true)
      Audio.playUI("buttons_navigation_up")
    end

    if pd.buttonJustPressed(pd.kButtonB) or pd.buttonJustPressed(pd.kButtonLeft) then
      if menuChangeTimer == nil or not menuChangeTimer.active then
        menuChangeTimer = pd.timer.new(1000, -400, 0, pd.easingFunctions.inOutCubic)
        menuUi:setSelectedRow(1)
        Audio.playUI("buttons_navigation_click")

        function menuChangeTimer:timerEndedCallback()
          menuScreen = "base"
        end
      end
    end

    if pd.buttonJustPressed(pd.kButtonA) then
      initIntroVN(levels[levelUi:getSelectedRow()])
      screen = "introVN"
      Audio.playUI("buttons_navigation_click")
    end
  end
end

function drawMenu()
  menuUi:drawInRect(menuDifferentY + 10, 10, 390, 190)
  levelUi:drawInRect(menuDifferentY + 410, 10, 390, 190)
end