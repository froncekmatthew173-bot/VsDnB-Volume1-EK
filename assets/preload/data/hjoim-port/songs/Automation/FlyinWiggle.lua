function onUpdate(elapsed)
fr = 0
fr = fr + elapsed
songPos = getSongPosition()
local currentBeat2 = (songPos/1000)*(curBpm/100)
local currentBeat = (songPos/500)*(curBpm/100)
setCharacterX('dad',getCharacterX('dad') + (math.sin(currentBeat2) * 5))
setCharacterY('dad',getCharacterY('dad') + (math.cos(currentBeat) * 5))
end