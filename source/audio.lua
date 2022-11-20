local pd <const> = playdate

Audio = {}

local sounds = {
  ui = {}
}

function Audio.init()
	local uiSounds = pd.file.listFiles("sounds/ui")
  
  for i = 1, #uiSounds, 1 do
    sounds.ui[uiSounds[i]] = pd.sound.sampleplayer.new("sounds/ui/" .. uiSounds[i])
  end
end

function Audio.playUI(sound)
  sounds.ui[sound .. ".pda"]:play()
end