local s = 1
local flip = 1
local NoteRD = 1.5
local floorStep = 0
local modifiers = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local timer1 = 0
local timer2 = 0
local timer3 = 0
local timer4 = 0
local manimdead = false
local oofnoteshit = false
local oofnoteshit2 = false
local oofnoteshit23 = false
local Camthing = 1
local CamThingy = 1
local angleforthing = false
local HudBop = false
local strumx1 = 240
local strumx2 = 900
local strumy = 50
local mult = 1
local camX = -500
local camY = 0
local camSpeed = 0.1

function onCreatePost()
    makeLuaSprite('camcontrol', '', 0, 0)
    makeLuaSprite('extravars', '', 0, 0)
    makeLuaSprite('extravars2', '', 0, 0)
    makeLuaSprite('camTweenValue', '', 0, 0)
    for i = 1, 8 do
        makeLuaSprite('modifiers' .. i, '', 0, 0)
    end
    makeLuaSprite('SPEED', '', 0.45, 1)
    strumx1 = 240
    strumx2 = 900
    strumy = 50
    mult = 1
    for i = 0, 7 do
        makeLuaSprite('scalecontrol' .. i, '', 0.7, 0.7)
        setProperty('scalecontrol' .. i .. '.alpha', 0.0001)
        addLuaSprite('scalecontrol' .. i, false)
        makeLuaSprite('notes' .. i, '', 0, 0)
        setProperty('notes' .. i .. '.angle', 1)
    end
    runTimer('frames', 0.033)
end

function onCreate()
    if shadersEnabled then
        initLuaShader('bloom')
    end
end

function onSongStart()
    setProperty('dad.x', -2100)
    setProperty('dad.y', -1000)
    setProperty('iconP2.alpha', 0.0001)
    local duration = (123 / (curBpm / 60))
    doTweenX('camMoveTween', 'camTweenValue', 1, duration, 'linear')
    if curStep > 128 then
        setProperty('dad.x', -635)
        setProperty('dad.y', -260)
        setProperty('camcontrol.alpha', 0.35)
    end
    if buildTarget == 'windows' then
        songPos = getSongPosition()
        currentStep = (songPos / 1000) * (curBpm / 15)
        for i = 0, math.floor(currentStep - 1) do
            floorStep = floorStep + 1
        end
        if currentStep > 128 then
            setProperty('dad.x', -565)
            setProperty('dad.y', -160)
            setProperty('camcontrol.alpha', 0.35)
        else
            setProperty('extravars.x', -300)
            doTweenX('hinotes1', 'extravars', 0, crochet * 0.004, 'elasticOut')
            for i = 0, 3 do
                setProperty('notes' .. i .. '.x', 0)
                setProperty('notes' .. i .. '.y', 800)
                setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.0001)
            end
        end
    end
end

function stepHit(step)
    if oofnoteshit23 then
        if floorStep % 2 == 0 then
            thefunnyfunction()
        end
    end
    if floorStep == 64 then
        doTweenAlpha('camAlphaStart', 'camcontrol', 0.35, crochet * 0.012, 'sineInOut')
    end
    if floorStep == 120 then
        doTweenX('dadXPos', 'dad', 100, crochet * 0.0009, 'sineIn')
        doTweenY('dadYPos', 'dad', -120, crochet * 0.0009, 'sineIn')
        doTweenAlpha('iconP2Show', 'iconP2', 1, 0.5, 'sineIn')
    end
    if floorStep == 124 then
        setProperty('camcontrol.alpha', 0.6)
        doTweenAlpha('camAlphaBoost', 'camcontrol', 0.8, crochet * 0.0009, 'sineOut')
    end
    if floorStep == 128 then
        setProperty('camcontrol.alpha', 0.35)
        setProperty('extravars2.alpha', 0.35)
    end
    if floorStep == 216 or floorStep == 248 or floorStep == 316 or floorStep == 736 then
        doTweenAlpha('camAlphaHigh', 'camcontrol', 0.6, 1, 'expoOut')
    end
    if floorStep == 225 or floorStep == 688 then
        cancelTween('camAlphaHigh')
        doTweenAlpha('camAlphaLowReset', 'camcontrol', 0.35, 0.5, 'expoOut')
    end
    if floorStep == 256 or floorStep == 768 then
        cancelTween('camAlphaHigh')
        doTweenAlpha('camAlphaMidReset', 'camcontrol', 0.45, 0.5, 'expoOut')
    end
    if floorStep == 320 or floorStep == 720 then
        cancelTween('camAlphaHigh')
        doTweenAlpha('camAlphaAltReset', 'camcontrol', 0.45, 1, 'expoOut')
    end
    if floorStep == 607 or floorStep == 784 then
        doTweenAlpha('camAlphaLongFade', 'camcontrol', 0.4, 3, 'expoOut')
    end
    if floorStep == 672 or floorStep == 676 or floorStep == 700 or floorStep == 702 or floorStep == 796 then
        cancelTween('camAlphaLongFade')
        doTweenAlpha('camAlphaBumpInc' .. floorStep, 'camcontrol', getProperty('camcontrol.alpha') + 0.05, 0.5, 'expoOut')
    end
    if floorStep == 680 or floorStep == 684 or floorStep == 704 then
        cancelTween('camAlphaLongFade')
        doTweenAlpha('camAlphaBumpDec' .. floorStep, 'camcontrol', getProperty('camcontrol.alpha') - 0.07, 0.5, 'expoOut')
    end
    if floorStep == 796 then
        cancelTween('camAlphaLongFade')
        doTweenAlpha('camAlphaFinalReset', 'camcontrol', 0.35, 3, 'sineInOut')
    end
    if floorStep == 120 then
        setProperty('extravars.y', 15)
        setProperty('SPEED.x', 0.05)
        NoteRD = 2.0
        doTweenY('varsYFall', 'extravars', 2000, crochet * 0.001, 'expoIn')
        doTweenAlpha('vars2AlphaBye', 'extravars2', 0.001, crochet * 0.001, 'sineIn')
        for i = 0, 3 do
            setProperty('scalecontrol' .. i .. '.x', 5)
            setProperty('scalecontrol' .. i .. '.y', 5)
            doTweenX('noteScaleXOut' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'expoOut')
            doTweenY('noteScaleYOut' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'expoOut')
            noteTweenAlpha('noteAlphaIn' .. i, i, 1, crochet * 0.001, 'linear')
            doTweenY('noteYJump' .. i, 'notes' .. i, 0, crochet * 0.0005, 'sineOut')
        end
        doTweenX('gameSpeedInc', 'SPEED', 0.45, crochet * 0.0005, 'expoIn')
        doTweenAngle('varsAngleShake', 'extravars', 0.1, crochet * 0.001, 'sineIn')
    end
    if floorStep == 122 then
        for i = 0, 3 do
            doTweenY('noteYFall' .. i, 'notes' .. i, 500, crochet * 0.0005, 'sineIn')
        end
        doTweenX('gameSpeedDec', 'SPEED', -0.6, crochet * 0.0005, 'sineIn')
    end
    if floorStep == 128 then
        angleforthing = true
        HudBop = true
        NoteRD = 1.5
        for i = 0, 7 do
            doTweenX('notesXReset' .. i, 'notes' .. i, 0, crochet * 0.004, 'expoOut')
            doTweenY('notesYReset' .. i, 'notes' .. i, 0, crochet * 0.004, 'expoOut')
        end
        oofnoteshit = true
    end
    if floorStep == 256 then
        oofnoteshit = false
        angleforthing = false
        oofnoteshit2 = true
        NoteRD = 1.8
    end
    if floorStep == 368 then
        for i = 4, 7 do
            doTweenY('noteYEpicIn' .. i, 'notes' .. i, 0, crochet * 0.004, 'backIn')
            noteTweenAngle('noteAngleEpicIn' .. i, i, 360, crochet * 0.004, 'expoOut')
        end
        HudBop = false
        oofnoteshit2 = false
        NoteRD = 1.5
    end
    if floorStep == 376 then
        for i = 0, 7 do
            doTweenX('noteXEpicMove' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoIn')
            doTweenY('noteYEpicMove' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoIn')
            if i < 4 then noteTweenAlpha('noteAlphaEpicBye' .. i, i, 0.0001, crochet * 0.002, 'linear') end
            doTweenX('noteScaleXEpic' .. i, 'scalecontrol' .. i, 0.9, crochet * 0.002, 'expoIn')
            doTweenY('noteScaleYEpic' .. i, 'scalecontrol' .. i, 0.9, crochet * 0.002, 'expoIn')
        end
    end
    if (floorStep > 383 and floorStep < 447) or (floorStep > 479 and floorStep < 544) then
        strumx1 = 640
        strumx2 = 640
        doTweenAngle('hudAngleEpic', 'camHUD', 0, 1, 'circOut')
        doTweenAngle('strumAngleEpic', 'camStrums', 0, 1, 'circOut')
        if floorStep % 32 == 0 then
            setProperty('extravars2.x', 0)
        end
        for i = 0, 5 do
            if floorStep % 32 == i * 2 then
                spamPart1(true)
                doTweenX('vars2XMove' .. floorStep, 'extravars2', 130 * (i % 2 - 0.5), crochet * 0.0004, 'sineOut')
            end
        end
        for i = 0, 3 do
            if floorStep % 32 == 12 + i then
                spamPart1(false)
                setProperty('extravars2.x', 130 * (i % 2 - 0.5))
            end
        end
        for i = 0, 3 do
            if floorStep % 32 == 16 + i * 2 then
                spamPart1(true)
                doTweenX('vars2XMoveAlt' .. floorStep, 'extravars2', 130 * (i % 2 - 0.5), crochet * 0.0004, 'sineOut')
            end
        end
        for i = 0, 1 do
            if floorStep % 32 == 24 + i or floorStep % 32 == 28 + i then
                spamPart1(false)
                setProperty('extravars2.x', 130 * (i % 2 - 0.5))
            end
        end
        if floorStep % 32 == 26 then
            spamPart1(true)
            doTweenX('vars2XMoveSnap', 'extravars2', -65, crochet * 0.0002, 'sineOut')
        end
        if floorStep % 32 == 30 then
            doTweenX('vars2XMoveExit', 'extravars2', -1280, crochet * 0.0005, 'sineIn')
        end
    else
        if floorStep >= 544 and floorStep < 960 then
            strumx1 = 240
            strumx2 = 900
        end
    end
    if floorStep == 450 or floorStep == 454 or floorStep == 456 or floorStep == 458 or floorStep == 464 or floorStep == 466 or floorStep == 468 or floorStep == 478 then
        spamPart1(true)
    end
    for i = 0, 3 do
        if floorStep == 460 + i then
            spamPart1(false)
        end
    end
    for i = 0, 5 do
        if floorStep == 472 + i then
            spamPart1(false)
        end
    end
    if floorStep == 544 then
        NoteRD = 1.3
        for i = 4, 7 do
            doTweenX('noteXEpicEnd' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoOut')
            doTweenY('noteYEpicEnd' .. i, 'notes' .. i, 0, crochet * 0.002, 'backIn')
            doTweenX('noteScaleXEpicEnd' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.002, 'expoOut')
            doTweenY('noteScaleYEpicEnd' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.002, 'expoOut')
            noteTweenAngle('noteAngleEpicEnd' .. i, i, 0, crochet * 0.002, 'expoOut')
            doTweenX('vars2XEpicEnd', 'extravars2', 0, crochet * 0.002, 'expoOut')
        end
    end
    if floorStep == 604 then
        for i2 = 0, 1 do
            for i = 0 + i2 * 4, 3 + i2 * 4 do
                setProperty('SPEED.x', -0.2)
                setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.0001)
                setProperty('notes' .. i .. '.x', -660 + i2 * 1320)
                setProperty('notes' .. i .. '.y', 300)
                doTweenX('noteXReturn' .. i, 'notes' .. i, 0, crochet * 0.001, 'expoOut')
                doTweenY('noteYReturn' .. i, 'notes' .. i, 0, crochet * 0.0005, 'expoOut')
                setProperty('scalecontrol' .. i .. '.x', 1.1)
                setProperty('scalecontrol' .. i .. '.y', 1.1)
                doTweenX('noteScaleXReturn' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'backInOut')
                doTweenY('noteScaleYReturn' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'backInOut')
                setPropertyFromGroup('strumLineNotes', i, 'angle', -45 + i2 * 90)
                noteTweenAlpha('noteAlphaReturn' .. i, i, 1, crochet * 0.0005, 'linear')
                noteTweenAngle('noteAngleReturn' .. i, i, 0, crochet * 0.001, 'sineOut')
            end
        end
    end
    if floorStep == 606 then
        for i = 0, 7 do
            doTweenY('noteYWaveReturn' .. i, 'notes' .. i, 0, crochet * 0.0005, 'backInOut')
        end
        for i = 0, 3 do
            noteTweenAlpha('noteAlphaDimReturn' .. i, i, 0.2, crochet * 0.0005, 'sineOut')
        end
        doTweenX('speedResetReturn', 'SPEED', 0.45, crochet * 0.0005, 'sineInOut')
    end
    if floorStep > 608 and floorStep < 800 then
        manimdead = true
        NoteRD = 1.6
        if floorStep % 16 == 0 or floorStep % 16 == 10 then
            setProperty('extravars.y', 15)
            doTweenY('varsYWaveUp' .. floorStep, 'extravars', 0, crochet * 0.001, 'sineIn')
        end
        if floorStep % 16 == 6 or floorStep % 16 == 14 then
            setProperty('extravars.y', -20)
            doTweenY('varsYWaveDown' .. floorStep, 'extravars', 0, crochet * 0.001, 'sineOut')
        end
        if floorStep % 16 == 4 then
            setProperty('extravars.x', 20)
            doTweenX('varsXWaveR' .. floorStep, 'extravars', 0, crochet * 0.0005, 'backIn')
        end
        if floorStep % 16 == 12 then
            setProperty('extravars.x', -25)
            doTweenX('varsXWaveL' .. floorStep, 'extravars', 0, crochet * 0.0005, 'backIn')
        end
    end
    if floorStep == 800 then
        NoteRD = 1.5
        for i = 0, 7 do
            doTweenX('notesXResetLate' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoOut')
            doTweenY('notesYResetLate' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoOut')
        end
    end
    if floorStep == 860 then
        NoteRD = 2.2
        for i = 0, 7 do
            doTweenY('noteScaleYReset' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.002, 'expoOut')
            doTweenX('noteScaleXReset' .. i, 'scalecontrol' .. i, 0.7, crochet * 0.002, 'expoOut')
            noteTweenAngle('noteAngleReset' .. i, i, 360, crochet * 0.004, 'expoOut')
            doTweenX('notesXResetFinal' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoOut')
            doTweenY('notesYResetFinal' .. i, 'notes' .. i, 0, crochet * 0.002, 'expoOut')
        end
    end
    if floorStep > 864 and floorStep < 928 then
        for i = 0, 7 do cancelTween('noteAngleReset' .. i) end
        oofnoteshit23 = true
        HudBop = true
    end
    if floorStep == 927 then
        oofnoteshit23 = false
    end
    if floorStep == 928 or floorStep == 931 or floorStep == 933 or floorStep == 934 or floorStep == 935 or floorStep == 936 or floorStep == 939 or floorStep == 942 or floorStep == 944 or floorStep == 947 or floorStep == 949 then
        thefunnyfunction()
    end
    if floorStep == 956 then
        HudBop = false
        NoteRD = 1.5
        doTweenAngle('hudAngleFinal', 'camHUD', 0, 1, 'circOut')
        doTweenAngle('strumAngleFinal', 'camStrums', 0, 1, 'circOut')
        for i = 0, 7 do
            doTweenX('noteXFinalMove' .. i, 'notes' .. i, 0, crochet * 0.0008, 'expoIn')
            doTweenY('noteYFinalMove' .. i, 'notes' .. i, 0, crochet * 0.0008, 'expoIn')
            if i < 4 then noteTweenAlpha('noteAlphaFinalBye' .. i, i, 0.0001, crochet * 0.0008, 'linear') end
            doTweenX('noteScaleXFinal' .. i, 'scalecontrol' .. i, 0.9, crochet * 0.0008, 'expoIn')
            doTweenY('noteScaleYFinal' .. i, 'scalecontrol' .. i, 0.9, crochet * 0.0008, 'expoIn')
        end
        makeLuaSprite('noteBG', '', 310, -300)
        makeGraphic('noteBG', 620, 3000, '000000')
        setObjectCamera('noteBG', 'HUD')
        addLuaSprite('noteBG', false)
        setProperty('noteBG.alpha', 0.0001)
        doTweenAlpha('noteBGShow', 'noteBG', 0.8, crochet * 0.001, 'linear')
    end
    if floorStep >= 960 and floorStep < 1020 then
        strumx1 = 640
        strumx2 = 640
        NoteRD = 2.5
        if floorStep % 2 == 0 then
            setProperty('extravars.alpha', 0.8)
            flip = -flip
            setProperty('extravars.x', 100 * flip)
            setProperty('extravars.y', (getProperty('extravars.y') + 2))
            setProperty('extravars.angle', 40 * flip)
            setProperty('extravars2.x', 40 * flip)
            setProperty('extravars2.y', 150 * flip)
            doTweenX('finalXMove' .. floorStep, 'extravars', 0, crochet * 0.0005, 'expoOut')
            doTweenX('finalVars2XMove' .. floorStep, 'extravars2', 0, crochet * 0.0005, 'sineOut')
            doTweenY('finalVars2YMove' .. floorStep, 'extravars2', 0, crochet * 0.0005, 'linear')
            for i = 4, 7 do
                setProperty('scalecontrol' .. i .. '.x', 1 + flip * 0.4)
                setProperty('scalecontrol' .. i .. '.y', 1 + flip * -0.4)
                doTweenX('finalNoteScaleX' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0005, 'linear')
                doTweenY('finalNoteScaleY' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0005, 'linear')
            end
            setProperty('camcontrol.alpha', 0.45)
            doTweenAlpha('finalCamBump' .. floorStep, 'camcontrol', 0.35, crochet * 0.0005, 'sineOut')
        end
    end
    if floorStep == 1020 or floorStep == 1022 then
        flip = -flip
        setProperty('extravars.x', 50 * flip)
        setProperty('extravars2.y', 300 * flip)
        doTweenX('finalEndNoteX' .. floorStep, 'extravars', 0, crochet * 0.0005, 'sineOut')
        doTweenAngle('finalEndNoteAngle' .. floorStep, 'extravars', 130 * flip, crochet * 0.0005, 'sineOut')
        doTweenX('finalEndVars2X' .. floorStep, 'extravars2', 40 * flip, crochet * 0.0005, 'expoOut')
        for i = 4, 7 do
            setProperty('scalecontrol' .. i .. '.x', 1 + flip * 0.2)
            setProperty('scalecontrol' .. i .. '.y', 1 + flip * -0.2)
            doTweenX('finalEndScaleX' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0005, 'sineOut')
            doTweenY('finalEndScaleY' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0005, 'sineOut')
        end
        setProperty('camcontrol.alpha', 0.45)
        doTweenAlpha('finalEndCamAlpha' .. floorStep, 'camcontrol', 0.35, crochet * 0.0005, 'sineOut')
    end
    if floorStep == 1024 then
        strumx1 = 240
        strumx2 = 900
        NoteRD = 1.5
        setProperty('noteBG.alpha', 0.0001)
        doTweenAlpha('scoreShowFinal', 'scoreTxt', 1, crochet * 0.001, 'linear')
        for i = 4, 7 do
            setProperty('notes' .. i .. '.x', 0)
            setProperty('notes' .. i .. '.y', 0)
            setProperty('scalecontrol' .. i .. '.x', 0.7)
            setProperty('scalecontrol' .. i .. '.y', 0.7)
            doTweenX('BYENOTES_X_' .. i, 'notes' .. i, 1540 * (i - 5.5), crochet * 0.004, 'expoIn')
            doTweenY('BYENOTES_Y_' .. i, 'notes' .. i, -1300, crochet * 0.004, 'backIn')
            noteTweenAngle('BYENOTES_ANGLE_' .. i, i, 3600, crochet * 0.004, 'linear')
            doTweenX('BYENOTES_SCX_' .. i, 'scalecontrol' .. i, 7, crochet * 0.004, 'expoIn')
            doTweenY('BYENOTES_SCY_' .. i, 'scalecontrol' .. i, 7, crochet * 0.004, 'expoIn')
        end
    end
    if floorStep == 1056 then
        doTweenAlpha('scoreHideFinal', 'scoreTxt', 0.0001, crochet * 0.001, 'linear')
    end
end

function onUpdatePost(elapsed)
    s = -s
    health = getProperty('extravars2.alpha')
    setProperty('health', health * 2)
    songPos = getSongPosition()
    currentStep = (songPos / 1000) * (curBpm / 15)
    if currentStep > floorStep + 1 then
        floorStep = floorStep + 1
        stepHit(floorStep)
    end
    runHaxeCode([[
        var cam = game.camGame;
        var step = game.curStep;
        var spr = game.modchartSprites.get('camTweenValue');
        var tweenVal = (spr != null) ? spr.x : 0;
        if (step < 123) {
            var startX = game.boyfriend.getMidpoint().x - (cam.width / 2);
            var startY = game.boyfriend.getMidpoint().y - (cam.height / 2);
            cam.scroll.x = FlxMath.lerp(startX, -2500, tweenVal);
            cam.scroll.y = FlxMath.lerp(startY, -500, tweenVal);
        } else if (step >= 123 && step < 135) {
            var targetX = ]]..camX..[[;
            var targetY = ]]..camY..[[;
            var lerpVal = ]]..camSpeed..[[ * FlxG.elapsed * 60;
            cam.scroll.x += (targetX - cam.scroll.x) * lerpVal;
            cam.scroll.y += (targetY - cam.scroll.y) * lerpVal;
        }
    ]])
    setProperty('camGame.zoom', getProperty('camcontrol.alpha'))
    setProperty('camHUD.zoom', 0.9)
    setProperty('camStrums.zoom', 0.9)
    var1 = getProperty('extravars.x')
    var2 = getProperty('extravars.y')
    var3 = getProperty('extravars.angle')
    var4 = getProperty('extravars2.x')
    for i = 1, 8 do
        modifiers[1 + (i - 1) * 3] = getProperty('modifiers' .. i .. '.x')
        modifiers[2 + (i - 1) * 3] = getProperty('modifiers' .. i .. '.y')
        modifiers[3 + (i - 1) * 3] = getProperty('modifiers' .. i .. '.angle')
    end
    timer1 = timer1 + elapsed * modifiers[5] * (curBpm / 15)
    timer2 = timer2 + elapsed * modifiers[6] * (curBpm / 15)
    timer3 = timer3 + elapsed * modifiers[17] * (curBpm / 15)
    timer4 = timer4 + elapsed * modifiers[18] * (curBpm / 15)
    speed = getProperty('SPEED.x') * NoteRD
    local curStrumY = 50
    setPropertyFromGroup('strumLineNotes', 0, 'x', (strumx1 + (0 - 1.5) * 110 + getProperty('notes0.x') + math.cos(0 * 4 + timer2 / 4) * 110 * modifiers[4] + modifiers[11] * 110 + modifiers[7] * 220 + modifiers[9] * 330 - (screenWidth / 2 + 55)) * (1 / getProperty('notes0.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 1, 'x', (strumx1 + (1 - 1.5) * 110 + getProperty('notes1.x') + math.cos(1 * 4 + timer2 / 4) * 110 * modifiers[4] + modifiers[11] * -110 + modifiers[10] * 110 + modifiers[8] * 220 - (screenWidth / 2 + 55)) * (1 / getProperty('notes1.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 2, 'x', (strumx1 + (2 - 1.5) * 110 + getProperty('notes2.x') + math.cos(2 * 4 + timer2 / 4) * 110 * modifiers[4] + modifiers[7] * -220 + modifiers[10] * -110 + modifiers[12] * 110 - (screenWidth / 2 + 55)) * (1 / getProperty('notes2.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 3, 'x', (strumx1 + (3 - 1.5) * 110 + getProperty('notes3.x') + math.cos(3 * 4 + timer2 / 4) * 110 * modifiers[4] + modifiers[9] * -330 + modifiers[8] * -220 + modifiers[12] * -110 - (screenWidth / 2 + 55)) * (1 / getProperty('notes3.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 4, 'x', (strumx2 + (0 - 1.5) * 110 + getProperty('notes4.x') + math.cos(0 * 4 + timer4 / 4) * 110 * modifiers[16] + modifiers[23] * 110 + modifiers[19] * 220 + modifiers[21] * 330 - (screenWidth / 2 + 55)) * (1 / getProperty('notes4.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 5, 'x', (strumx2 + (1 - 1.5) * 110 + getProperty('notes5.x') + math.cos(1 * 4 + timer4 / 4) * 110 * modifiers[16] + modifiers[23] * -110 + modifiers[22] * 110 + modifiers[20] * 220 - (screenWidth / 2 + 55)) * (1 / getProperty('notes5.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 6, 'x', (strumx2 + (2 - 1.5) * 110 + getProperty('notes6.x') + math.cos(2 * 4 + timer4 / 4) * 110 * modifiers[16] + modifiers[19] * -220 + modifiers[22] * -110 + modifiers[24] * 110 - (screenWidth / 2 + 55)) * (1 / getProperty('notes6.angle')) + (screenWidth / 2 + 55))
    setPropertyFromGroup('strumLineNotes', 7, 'x', (strumx2 + (3 - 1.5) * 110 + getProperty('notes7.x') + math.cos(3 * 4 + timer4 / 4) * 110 * modifiers[16] + modifiers[21] * -330 + modifiers[20] * -220 + modifiers[24] * -110 - (screenWidth / 2 + 55)) * (1 / getProperty('notes7.angle')) + (screenWidth / 2 + 55))
    for i = 0, 7 do
        local grp = (i < 4) and timer1 or timer3
        local modOffset = (i < 4) and 0 or 12
        setPropertyFromGroup('strumLineNotes', i, 'y', (curStrumY + getProperty('notes' .. i .. '.y') + math.sin(i * 4 + grp / 4) * 110 * modifiers[3 + modOffset] + ((i + 1) % 2) * modifiers[1 + modOffset] * 490 + (i % 2) * modifiers[2 + modOffset] * 490 - (screenHeight / 2 + 55)) * (1 / getProperty('notes' .. i .. '.angle')) + (screenHeight / 2 + 55))
        setPropertyFromGroup('strumLineNotes', i, 'scale.x', getProperty('scalecontrol' .. i .. '.x') * (1 / getProperty('notes' .. i .. '.angle')))
        setPropertyFromGroup('strumLineNotes', i, 'scale.y', getProperty('scalecontrol' .. i .. '.y') * (1 / getProperty('notes' .. i .. '.angle')))
    end
    if currentStep > 808 and currentStep < 860 then
        for i = 0, 7 do
            local div = (i < 4) and 16 or 64
            setProperty('scalecontrol' .. i .. '.x', 0.05 * math.sin((i * currentStep) * math.pi / div) + 0.7 + var2 * s)
            setProperty('scalecontrol' .. i .. '.y', 0.05 * math.sin((i * currentStep) * math.pi / div) + 0.7 + var2 * s)
            setProperty('notes' .. i .. '.x', math.sin((i * currentStep - 0.5) * math.pi / div) * 30 + var2 * s)
            setProperty('notes' .. i .. '.y', (var1 + math.sin(i + currentStep * math.pi / 32) * 70 + math.sin(currentStep * math.pi / 8) * 10))
            setPropertyFromGroup('strumLineNotes', i, 'angle', math.cos((currentStep - 0.5) * math.pi / 16) * 15)
        end
    end
    if currentStep > 0 and currentStep < 128 then
        for i = 4, 7 do
            setProperty('notes' .. i .. '.x', math.sin((currentStep - 0.5) * math.pi / 16) * 30 + var2 * s)
            setProperty('notes' .. i .. '.y', (var1 + math.sin(i * 2 + currentStep * math.pi / 32) * 50 + math.sin(currentStep * math.pi / 8) * 10))
            setPropertyFromGroup('strumLineNotes', i, 'angle', math.cos((currentStep - 0.5) * math.pi / 16) * 15)
        end
    end
    if currentStep > 128 and currentStep < 368 and angleforthing then
        for i = 0, 7 do
            setProperty('notes' .. i .. '.x', var1 * 330 + (i - 5.5) * var1 * 11)
            setProperty('notes' .. i .. '.y', math.sin(i / 2 + currentStep * math.pi / 4) * 10)
            setPropertyFromGroup('strumLineNotes', i, 'angle', math.cos((currentStep - 0.5) * math.pi / 16) * 15)
        end
    end
    if currentStep > 384 and currentStep < 544 then
        for i = 0, 7 do
            setProperty('notes' .. i .. '.x', math.sin((i * 0.5 + var1) * math.pi) * var3 + ((var4 + 640) % 1280) - 640)
            setProperty('notes' .. i .. '.y', math.sin((i * 0.5 + var2) * math.pi) * var3)
        end
    end
if currentStep > 608 and currentStep < 800 and manimdead then
        for i = 0, 7 do
            local xOff = (i < 4) and 0 or -220
            setProperty('notes' .. i .. '.x', xOff + math.floor(i / 4) % 2 * -110 + math.sin(currentStep * math.pi / 8) * 20 + math.cos((i * 4 + currentStep) * math.pi / 16) * var2)
            setProperty('notes' .. i .. '.y', ((math.floor(i / 2) % 2 - 0.5) * var1 * 2 + math.cos(currentStep * math.pi / 8) * 10 * (i % 4 - 1.5) + math.sin((i * 4 + currentStep) * math.pi / 16) * var2) + 720)
        end
    end
    if currentStep > 960 and currentStep < 1024 then
        for i = 0, 3 do setProperty('notes' .. i .. '.x', -2000) end
        for i = 4, 7 do
            setProperty('notes' .. i .. '.x', 22 * (i - 5.5) + math.cos((var2 + currentStep) * math.pi / 16) * s * var1 + var3)
            setProperty('notes' .. i .. '.y', (math.sin((var2 + currentStep) * math.pi / 16) * s * var1 + (i % 2 - 0.5) * var4 * 2) + 720)
            setPropertyFromGroup('strumLineNotes', i, 'angle', var3 / 2)
        end
    end
    for i = 0, getProperty('notes.length') - 1 do
        local dist = getPropertyFromGroup('notes', i, 'distance')
        local strumIdx = getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteData') + 4 or getPropertyFromGroup('notes', i, 'noteData')
        setPropertyFromGroup('notes', i, 'x', getPropertyFromGroup('strumLineNotes', strumIdx, 'x'))
        setPropertyFromGroup('notes', i, 'y', getPropertyFromGroup('strumLineNotes', strumIdx, 'y') - (dist * speed))
        setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', strumIdx, 'scale.x'))
        setPropertyFromGroup('notes', i, 'scale.y', getProperty('scalecontrol' .. strumIdx .. '.y'))
    end
end

function onTimerCompleted(tag)
    if tag == 'frames' then
        s = -s
        local isDisco = (currentStep > 384 and currentStep < 448) or (currentStep > 480 and currentStep < 544) or (currentStep > 960 and currentStep < 1024)
        for i = 0, 7 do
            if isDisco then
                local colors = {'FF7F7F', '7FFF7F', '7F7FFF'}
                setPropertyFromGroup('strumLineNotes', i, 'color', getColorFromHex(colors[math.random(1, 3)]))
            else
                setPropertyFromGroup('strumLineNotes', i, 'color', getColorFromHex('FFFFFF'))
            end
        end
        runTimer('frames', 0.016)
    end
end

function spamPart1(tweens)
    flip = -flip
    setProperty('extravars.x', math.random(1, 200) / 100)
    setProperty('extravars.y', math.random(1, 200) / 100)
    setProperty('extravars.angle', 70)
    setProperty('camcontrol.alpha', 0.45)
    for i = 4, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'angle', 20 * flip)
        setProperty('scalecontrol' .. i .. '.x', 0.65 + math.random(0, 3) * 0.2)
        setProperty('scalecontrol' .. i .. '.y', 0.65 + math.random(0, 3) * 0.2)
        if tweens then
            doTweenX('noteSpamScaleX' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0004, 'sineOut')
            doTweenY('noteSpamScaleY' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0004, 'sineOut')
            noteTweenAngle('noteSpamAngle' .. i .. '_' .. floorStep, i, 0, crochet * 0.0004, 'sineOut')
        end
    end
    if tweens then
        doTweenAngle('varsAngleSpam', 'extravars', 0, crochet * 0.0004, 'sineOut')
        doTweenX('varsXSpam', 'extravars', getProperty('extravars.x') + 1, crochet * 0.0004, 'linear')
    end
    doTweenAlpha('camAlphaSpam' .. floorStep, 'camcontrol', 0.35, crochet * 0.0005, 'sineOut')
end

function onBeatHit()
    if oofnoteshit then
        for i = 0, 7 do
            setProperty('scalecontrol' .. i .. '.' .. ((i % 2 == 0) and 'x' or 'y'), (curBeat % 4 == 0) and 2 or 1)
            doTweenX('noteScaleXBop' .. i .. '_' .. curBeat, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'expoOut')
            doTweenY('noteScaleYBop' .. i .. '_' .. curBeat, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'expoOut')
        end
    end
    if oofnoteshit2 and curBeat % 3 == 0 then
        for i = 0, 7 do
            doTweenX('noteScaleXAltBop' .. i .. '_' .. curBeat, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'expoOut')
            doTweenY('noteScaleYAltBop' .. i .. '_' .. curBeat, 'scalecontrol' .. i, 0.7, crochet * 0.001, 'expoOut')
            doTweenX('noteXResetBop' .. i .. '_' .. curBeat, 'notes' .. i, 0, crochet * 0.001, 'expoOut')
        end
    end
    Camthing = (curBeat % 2 == 0) and -CamThingy or CamThingy
    if HudBop then
        for _, c in pairs({'camHUD', 'camStrums'}) do
            setProperty(c .. '.angle', Camthing)
            doTweenAngle(c .. 'AngleBop' .. curBeat, c, Camthing * 4, stepCrochet * 0.005, 'quadOut')
            setProperty(c .. '.zoom', 1.06)
            doTweenZoom(c .. 'ZoomBop' .. curBeat, c, 0.9, 1, 'cubeOut')
        end
        setProperty('camGame.zoom', 1.03)
        doTweenZoom('gameZoomBop' .. curBeat, 'camGame', 0.9, 1, 'cubeOut')
    end
end

function noteMiss() setProperty('extravars2.alpha', health - 0.02) end
function noteMissPress() setProperty('extravars2.alpha', health - 0.04) end
function goodNoteHit(_, _, _, isSustainNote) setProperty('extravars2.alpha', health + (isSustainNote and 0.005 or 0.01)) end

function thefunnyfunction()
    flip = -flip
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'angle', 20 * flip)
        setProperty('scalecontrol' .. i .. '.x', 0.65 + math.random(0, 3) * 0.2)
        setProperty('scalecontrol' .. i .. '.y', 0.65 + math.random(0, 3) * 0.2)
        setProperty('notes' .. i .. '.x', math.sin((i * 0.5 + math.random(1, 200) / 100) * math.pi) * 70)
        setProperty('notes' .. i .. '.y', math.sin((i * 0.5 + math.random(1, 200) / 100) * math.pi) * 70)
        noteTweenAngle('noteAngleFunny' .. i .. '_' .. floorStep, i, 0, crochet * 0.003, 'expoOut')
        doTweenY('noteScaleYFunny' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0009, 'expoOut')
        doTweenX('noteScaleXFunny' .. i .. '_' .. floorStep, 'scalecontrol' .. i, 0.7, crochet * 0.0009, 'expoOut')
        doTweenY('noteYFunny' .. i .. '_' .. floorStep, 'notes' .. i, 0, crochet * 0.003, 'expoOut')
        doTweenX('noteXFunny' .. i .. '_' .. floorStep, 'notes' .. i, 0, crochet * 0.003, 'expoOut')
    end
end