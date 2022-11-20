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

local currentPlayedMusic = pd.sound.fileplayer.new()
local currentPlayedMusicFile = ""
local soundFile <const> = {
    title = "sounds/music/musique_intro",
    menu = "sounds/music/musique_intro",
    introVN = "sounds/music/musique_intro",
    winVN = "sounds/music/musique_fin_victoire",
    looseVN = "sounds/music/musique_fin_defaite",
    game = "sounds/music/musique_gameplay"
}
-- local soundVolume <const> = {
--   title = 1,
--   menu = 1,
--   introVN = 1,
--   winVN = 1,
--   looseVN = 1,
--   game = 1
-- }

function Audio.playMusic()
  if currentPlayedMusicFile ~= soundFile[screen] then
    currentPlayedMusic:stop()
    currentPlayedMusicFile = soundFile[screen]
    currentPlayedMusic:load(soundFile[screen])
    currentPlayedMusic:play()
    currentPlayedMusic:setVolume(1)--soundVolume[screen])
  end
end