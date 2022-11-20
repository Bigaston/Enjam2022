local pd <const> = playdate

Audio = {}

local sounds = {
  ui = {},
  game = {}
}

function Audio.init()
	local uiSounds = pd.file.listFiles("sounds/ui")
  
  for i = 1, #uiSounds, 1 do
    sounds.ui[uiSounds[i]] = pd.sound.sampleplayer.new("sounds/ui/" .. uiSounds[i])
  end

  local gameSounds = pd.file.listFiles("sounds/game")
  
  for i = 1, #gameSounds, 1 do
    sounds.ui[gameSounds[i]] = pd.sound.sampleplayer.new("sounds/game/" .. gameSounds[i])
  end
end

function Audio.playUI(sound)
  sounds.ui[sound .. ".pda"]:play()
end

function Audio.playGameSound(sound)
  sounds.ui[sound .. ".pda"]:play()
end