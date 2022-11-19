import "CoreLibs/object"

local pd <const> = playdate
local gfx <const> = pd.graphics

local authorFont = gfx.font.new("fonts/Cop")

local openingTime <const> = 500
local frameBetweenText <const> = 1

-- Class that displays dialogue box
class('Dialogue').extends()

function Dialogue.loadDialogueFromJSON(path)
  local jsonFile = json.decodeFile(path)
  return Dialogue(jsonFile)
end

-- Init the dialogue class
function Dialogue:init(dialogue) 
  Dialogue.super.init(self)

  if type(dialogue) == "string" then
    self.tableDialogue = {dialogue}
    self.text = dialogue
  else
    self.tableDialogue = dialogue
    self.text = dialogue[1].text
  end

  self.currentImg = nil
  self.currentAudio = nil
  self.currentAuthor = nil
  self.currentStep = 1

  self.textAnimation = false
  self.textDisplay = false
  self.textElapsedFrame = 0
  self.textDisplayChar = 0

  self.opened = false
  self.openAnimation = false

  -- Can be surcharged to launch a function when the dialogue is finished
  self.closeCallback = nil
end

-- Ask for the game to open dialogue box and start animation
function Dialogue:open()
  self.timerX = pd.timer.new(openingTime, 0, 196, pd.easingFunctions.inOutSine)
  self.timerY = pd.timer.new(openingTime, 0, 38, pd.easingFunctions.inOutSine)
  self.opened = false
  self.openAnimation = true
end

function Dialogue:animateText()
  if self.tableDialogue[self.currentStep].speed ~= nil then
    self.textElapsedFrame = self.tableDialogue[self.currentStep].speed
  else
    self.textElapsedFrame = frameBetweenText
  end

  self.textDisplayChar = 0
  self.textDisplay = false
  self.textAnimation = true

  -- Choose the right image
  self.currentImg = nil
  if self.tableDialogue[self.currentStep].image ~= nil then
    self.currentImg = gfx.image.new(self.tableDialogue[self.currentStep].image)
  end

  -- Play sound from dialogue
  if self.currentAudio ~= nil then
    self.currentAudio:stop()
  end

  if self.tableDialogue[self.currentStep].audio ~= nil then
    self.currentAudio = pd.sound.sampleplayer.new(self.tableDialogue[self.currentStep].audio)
    self.currentAudio:play()
  else
    self.currentAudio = nil
  end

  -- Add an author
  if self.tableDialogue[self.currentStep].author ~= nil then
    self.currentAuthor = self.tableDialogue[self.currentStep].author
  else
    self.currentAuthor = nil
  end
end

function Dialogue:update()
  if self.openAnimation then
    if not self.timerX.active then
      self.opened = true     
      self.openAnimation = false

      self:animateText()
    end
  end

  if self.textAnimation then
    if self.textElapsedFrame == 0 then
      if self.tableDialogue[self.currentStep].speed ~= nil then
        self.textElapsedFrame = self.tableDialogue[self.currentStep].speed
      else
        self.textElapsedFrame = frameBetweenText
      end

      self.textDisplayChar +=1

      if self.textDisplayChar == #self.text then
        self.textAnimation = false
        self.textDisplay = true
      end

    else 
      self.textElapsedFrame-=1
    end
  end

  if pd.buttonJustPressed(pd.kButtonA) then
    if self.openAnimation then
      self.openAnimation = false
      self.opened = true

      self.textAnimation = false
      self.textDisplay = true
    elseif self.textAnimation then
      self.textAnimation = false
      self.textDisplay = true
    else
      if self.currentStep == #self.tableDialogue then
        self.opened = false
        self.textDisplay = false
        if self.closeCallback ~= nil then

          self.closeCallback()
        end
      else
        self.currentStep+=1
        self.text = self.tableDialogue[self.currentStep].text

        self:animateText()
      end
    end
  end
end

function Dialogue:draw()
  if self.openAnimation then
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(200-self.timerX.value, 200 - self.timerY.value, self.timerX.value * 2, self.timerY.value * 2, 5)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(200-self.timerX.value, 200 - self.timerY.value, self.timerX.value * 2, self.timerY.value * 2, 5)
  elseif self.opened then
    if self.currentImg ~= nil then
      self.currentImg:draw(10, 20)
    end

    if self.currentAuthor ~= nil then
      local strWidth, strHeight = pd.graphics.getTextSize(self.currentAuthor, authorFont)

      print(strWidth, strHeight)

      gfx.setColor(gfx.kColorWhite)
      gfx.fillRoundRect(2, 150, strWidth-4, strHeight + 8, 2)
      gfx.setColor(gfx.kColorBlack)
      gfx.drawRoundRect(2, 150, strWidth-4, strHeight + 8, 2)

      authorFont:drawText(self.currentAuthor, 5, 152)
    end

    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(2, 160, 396, 78, 5)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRoundRect(2, 160, 396, 78, 5)

    gfx.drawText("Ⓐ", 375, 215)
  end

  if self.textAnimation then
    gfx.drawText(string.sub(self.text, 0, self.textDisplayChar), 5, 163)
  elseif self.textDisplay then
    gfx.drawText(self.text, 5, 163)
  end
  -- gfx.drawText(self.timerX.value, 10, 10)
end