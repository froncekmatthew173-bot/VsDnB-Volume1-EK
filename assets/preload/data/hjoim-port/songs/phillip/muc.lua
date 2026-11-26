function onCreatePost()
    setScrollFactor('gf', 1, 1)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('camZoomingMult', 0)
    makeLuaSprite('k', '', -500, -300)
    makeGraphic('k', 1920 + 600, 1080 + 300, '000000')
    addLuaSprite('k', false)
    setProperty('k.alpha', 0)
end

function onBeatHit()
    scaleObject('iconP1', 1, 1)
    scaleObject('iconP2', 1, 1)
end

local x = getProperty('gf.x')
local y = getProperty('gf.y')
local bludshake = 0

function onUpdate()
    if curStep > 1 and curStep < 512 then
        bludshake = curStep / 30
    elseif curStep > 641 and curStep < 1121 then
        bludshake = (curStep - 640) / 30
    else
        bludshake = 0
    end

    setProperty('gf.x', x + math.random() * bludshake * 3)
    setProperty('gf.y', y + math.random() * bludshake * 3)
end

function onStepHit()
    if curStep == 384 then
    doTweenAlpha('fadeBF', 'boyfriend', 0, 2, 'linear')
    doTweenAlpha('fadeDAD', 'dad', 0, 2, 'linear')
    end
    if curStep == 562 then
        doTweenAlpha('scary', 'k', 0.75, 6, 'linear') 
    end
    if curStep == 514 then
    setProperty('boyfriend.alpha', 1)
    setProperty('dad.alpha', 1)
    end
    if curStep == 640 then
    setProperty('k.alpha', 0)
    end
end