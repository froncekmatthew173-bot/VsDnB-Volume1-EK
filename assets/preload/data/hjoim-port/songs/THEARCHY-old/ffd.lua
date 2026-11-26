local speed = 5
local wave = 0.5
local fps = 0.01

function onUpdate(elapsed)
    local songPos = getSongPosition() / 1000
    local timer = math.floor(songPos / fps) * fps
    
    for i = 0, 7 do
        local targetX = getPropertyFromGroup('strumLineNotes', i, 'x')
        local targetY = getPropertyFromGroup('strumLineNotes', i, 'y')
        setPropertyFromGroup('strumLineNotes', i, 'x', targetX + math.sin(timer * speed + i) * wave)
        setPropertyFromGroup('strumLineNotes', i, 'y', targetY + math.cos(timer * speed + i) * wave)
    end
end