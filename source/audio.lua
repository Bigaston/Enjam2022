local pd <const> = playdate

Audio = {
  game = {}
}

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
    sounds.game[gameSounds[i]] = pd.sound.sampleplayer.new("sounds/game/" .. gameSounds[i])
  end
end

function Audio.playUI(sound)
  sounds.ui[sound .. ".pda"]:play()
end

function Audio.playGameSound(sound)
  sounds.game[sound .. ".pda"]:play()
end

function Audio.playSouffrance()
  local number = math.random(1, 6)

  sounds.game["cri_souffrance_" .. number .. ".pda"]:setVolume(0.3)
  sounds.game["cri_souffrance_" .. number .. ".pda"]:play()
end
