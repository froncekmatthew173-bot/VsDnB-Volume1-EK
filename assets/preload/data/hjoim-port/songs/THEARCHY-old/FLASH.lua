function onStepHit()
    if curStep >= 1281 and curStep <= 1313 then
        if curStep % 2 == 0 then
            makeLuaSprite('flicker', '', 0, 0)
            makeGraphic('flicker', screenWidth, screenHeight, '000000')
            setObjectCamera('flicker', 'other')
            addLuaSprite('flicker', true)
        else
            removeLuaSprite('flicker', true)
        end
    end

    if curStep == 1314 then
        makeLuaSprite('blackout', '', 0, 0)
        makeGraphic('blackout', screenWidth, screenHeight, '000000')
        setObjectCamera('blackout', 'other')
        addLuaSprite('blackout', true)
    end

    if curStep == 1427 then
        removeLuaSprite('blackout', true)
    end
end