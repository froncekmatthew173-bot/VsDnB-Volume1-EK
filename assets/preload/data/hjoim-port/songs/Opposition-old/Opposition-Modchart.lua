local s = 1
local flip = 1
local NoteRD = 2
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
local angleforthing = true
local HudBop = false
local cangotodad = false
local screenFlip = false
local noteInvisible = false

function onCreatePost()
    makeLuaSprite('camcontrol','',0,0)
    makeLuaSprite('extravars','',0,0)
    makeLuaSprite('extravars2','',0.5,0)
    for i = 1,8 do
        makeLuaSprite('modifiers' .. i,'',0,0)
    end
    makeLuaSprite('SPEED','',0.5,1)
    strumx1 = 240
    strumx2 = 900
    strumy = 60
    mult = 1
    if downscroll then
        strumy = 550
        mult = -1
    end
    for i = 0,7 do
        makeLuaSprite('scalecontrol'..i,'',0.7,0.7)
        setProperty('scalecontrol'..i..'.alpha',0.0001)
        addLuaSprite('scalecontrol'..i,false)
        makeLuaSprite('notes'..i,'',0,0)
        setProperty('notes'..i..'.angle',1)
    end
    runTimer('frames',0.033)
end

function onCreate()
    if shadersEnabled then
        initLuaShader('bloom')
    end
end

function onSongStart()
    setProperty('dad.x',-2100)
    setProperty('dad.y',-1000)
    setProperty('camFollow.x',1400)
    setProperty('camFollow.y',100)
    setProperty('iconP2.alpha',0.0001)
    if currentStep > 128 then
        setProperty('dad.x',-635)
        setProperty('dad.y',-260)
        setProperty('camcontrol.alpha',0.35)
    end
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(curBpm/15)
    for i = 0, math.floor(currentStep-1) do
        floorStep = floorStep+1
    end
    if currentStep <= 128 then
        setProperty('extravars.x',-300)
        doTweenX('hinotes1','extravars',0,crochet*0.004,'elasticOut')
        for i = 0,3 do
            setProperty('notes'..i..'.x',330)
            setProperty('notes'..i..'.y',800)
            setPropertyFromGroup('strumLineNotes',i,'alpha',0.0001)
        end
    end
end

function stepHit(step)
    if oofnoteshit23 == true then
        if floorStep % 2 == 0 then
            thefunnyfunction()
        end
    end
    if floorStep == 64 then
        doTweenAlpha('cam3','camcontrol',0.35,crochet*0.012,'sineInOut')
    end
    if floorStep == 112 then
        setProperty('camFollow.x',1400)
        setProperty('camFollow.y',100)
    end
    if floorStep == 120 then
        doTweenX('bamb1','dad',100,crochet*0.0009,'sineIn')
        doTweenY('bamb2','dad',-120,crochet*0.0009,'sineIn')
        doTweenAlpha('hiopphhdso','iconP2',1, 0.5,'sineIn')
        setProperty('extravars.y',15)
        setProperty('SPEED.x',0.1)
        doTweenY('vars2','extravars',2000,crochet*0.001,'expoIn')
        doTweenAlpha('byehp','extravars2',0.001,crochet*0.001,'sineIn')
        for i = 0,3 do
            setProperty('scalecontrol'..i..'.x',5)
            setProperty('scalecontrol'..i..'.y',5)
            doTweenX('bruh1'..i,'scalecontrol'..i,0.7,crochet*0.001,'expoOut')
            doTweenY('bruh2'..i,'scalecontrol'..i,0.7,crochet*0.001,'expoOut')
            noteTweenAlpha('bruh3'..i,i,1,crochet*0.001,'linear')
            doTweenY('bruh4'..i,'notes'..i,0,crochet*0.0005,'sineOut')
        end
        doTweenX('Speed1','SPEED',0.7,crochet*0.0005,'expoIn')
    end
    if floorStep == 128 then
        setProperty('camcontrol.alpha',0.35)
        setProperty('extravars2.alpha',0.35)
        angleforthing = true
        HudBop = true
        for i = 0,7 do
            doTweenX('Hinoteslo'..i,'notes'..i,0,crochet*0.004,'expoOut')
            doTweenY('Hinoteslo2'..i,'notes'..i,0,crochet*0.004,'expoOut')
        end
        oofnoteshit = true
    end
    if floorStep == 216 or floorStep == 248 or floorStep == 316 or floorStep == 736 then
        doTweenAlpha('cCAJMIOKG:L', 'camcontrol', 0.6, 1,'expoOut')
    end
    if floorStep == 225 or floorStep == 688 then
        cancelTween('cCAJMIOKG:L')
        doTweenAlpha('cCAJMsIOKgG:Lf', 'camcontrol', 0.35, 0.5,'expoOut')
    end
    if floorStep == 256 then
        oofnoteshit = false
        angleforthing = false
        oofnoteshit2 = true
        noteInvisible = true
    end
    if floorStep == 320 then
        noteInvisible = false
        for i = 0,7 do
            noteTweenAlpha('back'..i, i, 1, 0.5, 'linear')
        end
    end
    if floorStep == 368 then
        for i = 4,7 do
            doTweenY('epicpartsoon3'..i,'notes'..i,0,crochet*0.004,'backIn')
            noteTweenAngle('epicpartsoon4'..i,i,360,crochet*0.004,'expoOut')
        end
        HudBop = false
        oofnoteshit2 = false
    end
    if floorStep == 376 then
        for i = 0,3 do 
            doTweenX('epicpartsoon1'..i,'notes'..i,247.5+55*i,crochet*0.002,'expoIn')
            noteTweenAlpha('epicpartsoon2'..i,i,0.0001,crochet*0.002,'linear')
            doTweenX('bruh4'..i,'scalecontrol'..i,0.9,crochet*0.002,'expoIn')
            doTweenY('bruh5'..i,'scalecontrol'..i,0.9,crochet*0.002,'expoIn')
        end
        for i = 4,7 do
            doTweenX('epicpartsoon1'..i,'notes'..i,-247.5+55*(i-7),crochet*0.002,'expoIn')
            doTweenX('bruh4'..i,'scalecontrol'..i,0.9,crochet*0.002,'expoIn')
            doTweenY('bruh5'..i,'scalecontrol'..i,0.9,crochet*0.002,'expoIn')
        end
    end
    if (floorStep > 383 and floorStep < 447) or (floorStep > 479 and floorStep < 544) then
        if floorStep % 8 == 0 then
            screenFlip = not screenFlip
            doTweenAngle('flipHud', 'camHUD', screenFlip and 180 or 0, 0.2, 'sineOut')
        end
        for i = 0,5 do
            if floorStep % 32 == i*2 then
                spamPart1(true)
                doTweenX('bruh999','extravars2',130*(i%2-0.5),crochet*0.0004,'sineOut')
            end
        end
    end
    if floorStep == 544 then
        screenFlip = false
        doTweenAngle('flipHud', 'camHUD', 0, 0.5, 'sineOut')
        for i = 4,7 do
            doTweenX('epicpartend1'..i,'notes'..i,-330,crochet*0.002,'expoOut')
            doTweenY('epicpartend2'..i,'notes'..i,-250,crochet*0.002,'backIn')
            doTweenX('epicpartend3'..i,'scalecontrol'..i,0.7,crochet*0.002,'expoOut')
            doTweenY('epicpartend4'..i,'scalecontrol'..i,0.7,crochet*0.002,'expoOut')
            noteTweenAngle('epicpartend5'..i,i,0,crochet*0.002,'expoOut')
        end
    end
    if floorStep == 604 then
        for i2 = 0,1 do
            for i = 0+i2*4,3+i2*4 do
                setProperty('SPEED.x',-0.3)
                setPropertyFromGroup('strumLineNotes',i,'alpha',0.0001)
                setProperty('notes'..i..'.x',-660+i2*1320)
                setProperty('notes'..i..'.y',300)
                doTweenX('notescomingback1'..i,'notes'..i,330-i2*660,crochet*0.001,'expoOut')
                doTweenY('notescomingback2'..i,'notes'..i,400+math.sin(i*0.6*math.pi)*70,crochet*0.0005,'expoOut')
                setProperty('scalecontrol'..i..'.x',1.1)
                setProperty('scalecontrol'..i..'.y',1.1)
                doTweenX('notescomingback3'..i,'scalecontrol'..i,0.7,crochet*0.001,'backInOut')
                doTweenY('notescomingback4'..i,'scalecontrol'..i,0.7,crochet*0.001,'backInOut')
                noteTweenAlpha('notescomingback5'..i,i,1,crochet*0.0005,'linear')
                noteTweenAngle('notescomingback6'..i,i,0,crochet*0.001,'sineOut')
            end
        end
    end
    if floorStep > 608 and floorStep < 800 then
        manimdead = true
        if floorStep % 4 == 0 then
            thefunnyfunction()
        end
    end
    if floorStep == 800 then
        for i = 0,7 do
            doTweenX('bruh4'..i,'notes'..i,0,crochet*0.002,'expoOut')
            doTweenY('bruh4y'..i,'notes'..i,0,crochet*0.002,'expoOut')
        end
    end
    if floorStep == 860 then
        for i = 0,7 do
            doTweenX('bruh324'..i,'scalecontrol'..i,0.7,crochet*0.002,'expoOut')
            noteTweenAngle('yuh'..i,i,360,crochet*0.004,'expoOut')
        end
    end
    if floorStep > 864 and floorStep < 928 then
        oofnoteshit23 = true
        HudBop = true
    end
    if floorStep == 927 then oofnoteshit23 = false end
    if floorStep == 956 then
        HudBop = false
        doTweenAngle('TheFunny', 'camHUD', 0, 1, 'circOut')
        for i = 0,3 do
            doTweenX('epicpartsoon1'..i,'notes'..i,247.5+55*i,crochet*0.0008,'expoIn')
            noteTweenAlpha('epicpartsoon2'..i,i,0.0001,crochet*0.0008,'linear')
        end
    end
    if floorStep == 1024 then
        for i = 4,7 do
            doTweenX('BYENOTES!1-'..i,'notes'..i,-330+1540*(i-5.5),crochet*0.004,'expoIn')
            doTweenY('BYENOTES!2-'..i,'notes'..i,-1300,crochet*0.004,'backIn')
            noteTweenAngle('BYENOTES!3-'..i,i,3600,crochet*0.004,'linear')
        end
    end
end

function onUpdatePost(elapsed)
    s = -s
    health = getProperty('extravars2.alpha')
    setProperty('health',health*2)
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(curBpm/15)
    if currentStep > floorStep+1 then
        floorStep = floorStep+1
        stepHit(floorStep)
    end
    setProperty('camGame.zoom',getProperty('camcontrol.alpha') * 0.8)
    if noteInvisible then
        for i = 4,7 do
            local distance = math.abs(getPropertyFromGroup('strumLineNotes', i, 'y') - strumy)
            if distance < 200 then
                setPropertyFromGroup('strumLineNotes', i, 'alpha', distance/200)
            end
        end
    end
    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes',i,'scale.x',getProperty('scalecontrol'..i..'.x'))
        setPropertyFromGroup('strumLineNotes',i,'scale.y',getProperty('scalecontrol'..i..'.y'))
        setPropertyFromGroup('strumLineNotes',i,'x', (i < 4 and strumx1 or strumx2) + (i % 4) * 112 + getProperty('notes'..i..'.x'))
        setPropertyFromGroup('strumLineNotes',i,'y', strumy + getProperty('notes'..i..'.y'))
    end
    if currentStep > 808 and currentStep < 860 then
        for i = 0,3 do
            setProperty('notes'..i..'.x',math.sin((i*currentStep-0.5)*math.pi/16)*30)
            setProperty('notes'..i..'.y',math.sin(i+currentStep*math.pi/32)*70)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'frames' then
        runTimer('frames',0.016)
    end
end

function spamPart1(tweens)
    flip = -flip
    setProperty('camcontrol.alpha',0.45)
    for i = 4,7 do
        setPropertyFromGroup('strumLineNotes',i,'angle',20*flip)
        if tweens then
            noteTweenAngle('bruh6'..i,i,0,crochet*0.0004,'sineOut')
        end
    end
    doTweenAlpha('cam3','camcontrol',0.35,crochet*0.0005,'sineOut')
end

function onBeatHit()
    if oofnoteshit == true then
        if curBeat % 4 == 0 then
            for i = 0,7 do
                setProperty('scalecontrol'..i..'.x',1.5)
                doTweenX('bruh1'..i,'scalecontrol'..i,0.7,crochet*0.001,'expoOut')
            end
        end
    end
    if HudBop == true then
        setProperty('camHUD.zoom', 1.06)
        doTweenZoom('Bop', 'camHUD', 1, 0.2, 'cubeOut')
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    setProperty('extravars2.alpha',health-0.03)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    local gain = isSustainNote and 0.004 or 0.01
    setProperty('extravars2.alpha',health+gain)
end

function thefunnyfunction()
    flip = -flip
    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes',i,'angle',25*flip)
        setProperty('notes'..i..'.x',math.sin(i + floorStep)*50)
        noteTweenAngle('bruh6'..i,i,0,crochet*0.003,'expoOut')
    end
end