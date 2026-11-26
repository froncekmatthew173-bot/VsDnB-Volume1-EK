

function onStepHit()
    if curStep == 1419 then  --bit late so it shows the text but i dont things this works for the notif send

        makeLuaText('helltext', 'GHOST TAPPING DISABLED', 0, 0, 0)
        setTextSize('helltext', 80)
        setTextColor('helltext', 'FF0000')
        setObjectCamera('helltext', 'other')
        screenCenter('helltext', 'xy')
        addLuaText('helltext')
        
        -- shake it and then squash it
        runTimer('crushText', 0.5)
    end
end

function onUpdate(elapsed)
    if getProperty('helltext.alpha') > 0 then
        setProperty('helltext.x', (1280 / 2 - getProperty('helltext.width') / 2) + math.random(-10, 10))
        setProperty('helltext.y', (720 / 2 - getProperty('helltext.height') / 2) + math.random(-10, 10))
		 setProperty('helltext.angle',math.random(-10, 10))
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'crushText' then
        doTweenY('squashY', 'helltext.scale', 0, 0.2, 'expoIn')
        doTweenX('stretchX', 'helltext.scale', 3, 0.2, 'expoIn')
        doTweenAlpha('byeText', 'helltext', 0, 0.2, 'linear')
    end
end