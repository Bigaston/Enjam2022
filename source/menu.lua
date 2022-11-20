import "CoreLibs/timer"
import "CoreLibs/ui"

import "language"
import "audio"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Main menu UI screen
local menuUi
local menuUiText <const> = {"menu.level", "menu.lang"}
local langUi = 2

-- Level select UI
local levelUi
local levelUiText <const> = {"menu.level1", "menu.level2", "menu.level3", "menu.level4"}

-- Move between the 2 screens
local menuScreen = "base"
local menuChangeTimer
local menuDifferentY = 0

-- Import the needed images
local selectorImg = gfx.image.new("images/menu/selector")
local leftRightImg = gfx.image.new("images/menu/leftright")

function initMenu()
  -- Setup the UI for the main menu using PlayDate GridVew Elements
  menuUi = pd.ui.gridview.new(350, 32)

  menuUi:setSectionHeaderHeight(30)
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

  -- Setup the title
  function menuUi:drawSectionHeader(section, x, y, width, height)
    gfx.drawText("*"..Language.getString("menu.title") .. "*", x + 40, y + 8)
  end

  -- Setup the UI for the level selection using PlayDate GridVew Elements
  levelUi = pd.ui.gridview.new(350, 32)
  levelUi:setSectionHeaderHeight(30)
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

  function levelUi:drawSectionHeader(section, x, y, width, height)
    gfx.drawText("*"..Language.getString("menu.level").."*", x + 40, y + 8)
  end
end

function updateMenu()
  if menuChangeTimer ~= nil and menuChangeTimer.active then
    menuDifferentY = menuChangeTimer.value
  end

  -- Main menu screen
  if menuScreen == "base" then
    -- Move in the menu
    if pd.buttonJustPressed(pd.kButtonDown) then
      menuUi:selectNextRow(true)
      Audio.playUI("buttons_navigation_down")
    elseif pd.buttonJustPressed(pd.kButtonUp) then
      menuUi:selectPreviousRow(true)
      Audio.playUI("buttons_navigation_up")
    end

    -- Go to the next screen
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

    -- Change the language
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
  -- Level choose
  elseif menuScreen == "level" then
    -- Move inside
    if pd.buttonJustPressed(pd.kButtonDown) then
      levelUi:selectNextRow(true)
      Audio.playUI("buttons_navigation_down")
    elseif pd.buttonJustPressed(pd.kButtonUp) then
      levelUi:selectPreviousRow(true)
      Audio.playUI("buttons_navigation_up")
    end

    -- Back to the main menu
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

    -- Start a level
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