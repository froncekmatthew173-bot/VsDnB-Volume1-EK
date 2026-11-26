function onMoveCamera(focus)
    if focus == 'gf' then
        setProperty('defaultCamZoom', 0.9)
    else
        setProperty('defaultCamZoom', 0.5)
    end
end

function onCreate()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
end

function onUpdate(elapsed)
    if mouseClicked('left') then
        local mouseX = getMouseX('camHUD')
        local mouseY = getMouseY('camHUD')
        
        local gfX = getProperty('gf.screenCenter.x')
        local gfY = getProperty('gf.screenCenter.y')
        local gfW = getProperty('gf.width')
        local gfH = getProperty('gf.height')

        if (getMouseX('camGame') >= getProperty('gf.x') and getMouseX('camGame') <= (getProperty('gf.x') + gfW)) and (getMouseY('camGame') >= getProperty('gf.y') and getMouseY('camGame') <= (getProperty('gf.y') + gfH)) then
            loadSong('theophany')
        end
    end
end

function onGameOver()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
end

function onDestroy()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
end

function onStepHit()
    if curStep == 1300 then
        doTweenX('gfMove', 'gf', 5000, 20, 'linear')
    end
end