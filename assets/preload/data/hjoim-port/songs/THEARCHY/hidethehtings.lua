function onCreatePost()
    if downscroll then
        setProperty('healthBar.y', -500)
    else
        setProperty('healthBar.y', 1000)
    end
end

function onStepHit()
    local targetY = 648
    local hideY = 1000

    if downscroll then
        targetY = 72
        hideY = -200
    end

    if curStep == 50 then 
        doTweenY('healthbary', 'healthBar', targetY, 1.5, 'elasticOut')
    end
    if curStep == 674 then 
        doTweenY('healthbary', 'healthBar', hideY, 1.5, 'elasticOut')
    end
    if curStep == 798 then 
        doTweenY('healthbary', 'healthBar', targetY, 1.5, 'elasticOut')
    end
    if curStep == 2389 then 
        doTweenY('healthbary', 'healthBar', hideY, 1.5, 'elasticOut')
    end
end