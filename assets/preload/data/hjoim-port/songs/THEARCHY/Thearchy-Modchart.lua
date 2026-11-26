local s = 1 -- alternates every frame
local flip = 1 -- for alternating effects (multiply this by -1)
local NoteRD = 0.25 --change the render distance of the notes. default is 1
local floorStep = 0
local modifiers = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} --modifier guide at bottom
local timer1 = 0
local timer2 = 0
local timer3 = 0
local timer4 = 0
local scrSpeedMod = 1
local spinnyfuckies = true
local spinnyfuckiesbutonlyforbf = false
local spinnyfuckiesbutonlyforoppo = false
local white = 65793
local checkthedisk = false
local guh = false
local enablethehudthirdbeat = false
local lol = false
local laescolours = true
local speedmult = 1
function onCreatePost() --set up modchart tools
  makeLuaSprite('camcontrol','',0,0)
  makeLuaSprite('extravars','',0,0)
  makeLuaSprite('extravars2','',0,0)
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
      --addLuaSprite('scalecontrol'..i,false)
      makeLuaSprite('notes'..i,'',0,0) --angle = z axis (distance from camera), 0 to +inf
      setProperty('notes'..i..'.angle',1)
  end
  --makeLuaText('dbug', "curStep: 0", 800, 535, 20)
  --setTextSize('dbug', 40)
  --setTextColor('dbug', 'FFFFFF')
  --setObjectCamera('dbug','other')
  --addLuaText('dbug',true)

    runTimer('frames',0.03)

    setProperty('extravars.x',0.2)

end
function onSongStart() --set custom step count and run debug scripts
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(curBpm/15)
    for i = 0, math.floor(currentStep-1) do
        floorStep = floorStep+1
    end
end
function stepHit(step) --run set modchart scripts

        if floorStep == 126 then
            doTweenX('eags','extravars',1.05,crochet*0.025,'quadInOut')
        end
        if floorStep == 128 then
            spinnyfuckies = false
            setTheNotesNormal()
            for i = 0,7 do
                setPropertyFromGroup('strumLineNotes',i,'color',white*255)
            end
        end
        if floorStep == 284 then
            sillyTween(1)
            setTheNotesNormal()
        end
        if floorStep == 286 or floorStep == 671 then
            sillyTween(-1)
            setTheNotesNormal()
        end --close enough welcome back yandere dev!
        if floorStep == 288 or floorStep ==  320 or floorStep == 328 or floorStep == 344 or floorStep == 384 or floorStep == 392 or floorStep == 1824 or floorStep == 1888 or floorStep == 1952 then
            checkthedisk = true
        end
        if floorStep == 316 or floorStep == 380 or floorStep == 396 or floorStep == 324 or floorStep == 640 then
            checkthedisk = false
            sillyTween(1)
        end
        if floorStep == 317 or floorStep == 318 or floorStep == 319 or floorStep == 326 or floorStep == 327 or floorStep == 381 or floorStep == 382 or floorStep == 383 or floorStep == 397 or floorStep == 398 or floorStep == 399 or floorStep == 400 or floorStep == 402 or floorStep == 404 or floorStep == 406 or floorStep == 508 or floorStep == 509 or floorStep == 510 or floorStep == 646 or floorStep == 652 or floorStep == 656 or floorStep == 658 or floorStep == 660 or floorStep == 662 or floorStep == 664 or floorStep == 668 or floorStep == 669 or floorStep == 670 then
            sillyTween(-1)
        end
        if floorStep == 336 or floorStep == 388 or floorStep == 1852 then
            checkthedisk = false
            chkdskahh(1, -1, false)
        end
        if floorStep == 340 or floorStep == 391 or floorStep == 518 or floorStep == 528 or floorStep == 532 or floorStep == 534 or floorStep == 1872 or floorStep == 1876 then
            chkdskahh(1, -1, false)
        end
        if floorStep == 338 or floorStep == 342 or floorStep == 390 or floorStep == 524 or floorStep == 530 or floorStep == 533 or floorStep == 535 or floorStep == 1854 or floorStep == 1874 or floorStep == 1878 then
            chkdskahh(-1, 1, false)
        end
        if floorStep == 408 or floorStep == 412 or floorStep == 511 or floorStep == 536 or floorStep == 540 or floorStep == 1856 or floorStep == 1862 or floorStep == 1868 or floorStep == 1880 or floorStep == 1884 then
            sillyTween(1)
            setTheNotesNormal()
        end
        if floorStep == 414 or floorStep == 444 then
            middleScrollLOL()
        end
        if floorStep == 416 then
            for i = 4,7 do
                setProperty('notes'..i..'.alpha', 0.25);
                spinnyfuckiesbutonlyforbf = true
            end
        makeLuaSprite('noteBG','',360,-300)
        makeGraphic('noteBG',520,3000,'000000')
        setObjectCamera('noteBG','HUD')
        addLuaSprite('noteBG',false)
        setProperty('noteBG.alpha', 0.0001)
        doTweenAlpha('noteBGShow','noteBG',0.5,crochet*0.002,'linear')
        end
        if floorStep == 440 then
            spinnyfuckiesbutonlyforbf = false
            for i = 4,7 do
                noteTweenAlpha('alphale1'..i,i,1,crochet*0.001,'expoOut')
                setPropertyFromGroup('strumLineNotes',i,'color',white*255)
            end
            setTheNotesNormal()
        end
        if floorStep == 448 then
            for i = 0,3 do
                setProperty('notes'..i..'.alpha', 0.25);
                spinnyfuckiesbutonlyforoppo = true
            end
        end
        if floorStep == 480 then
            setTheNotesNormal()
            for i = 0,3 do
                setPropertyFromGroup('strumLineNotes',i,'color',white*255)
                setProperty('notes'..i..'.alpha', 1);
                spinnyfuckiesbutonlyforoppo = false
            end
        end
        if floorStep == 476 then
        doTweenAlpha('noteBGHide','noteBG',0,crochet*0.002,'linear')
        end
        if floorStep == 544 then
            guh = true
            checkthedisk = true
        end

        if floorStep == 800 then
            enablethehudthirdbeat = true
        end

        if floorStep == 912 then
            enablethehudthirdbeat = false
            fuckingChuddyHud(-1,-1,1, false)
        end

        if floorStep == 916 then
            fuckingChuddyHud(1,1,-1, false)
        end

        if floorStep == 920 or floorStep == 926 then
            fuckingChuddyHud(-1,-1,1, false)
        end
        if floorStep == 924 then
           doTweenAlpha('noteBGShow','noteBG',0.5,crochet*0.002,'linear')
        end
        if floorStep == 928 then
            middleScrollLOL()
            lol = true
            laescolours = false
            for i = 0,3 do
                setPropertyFromGroup('strumLineNotes',i,'alpha',0.5)
                setProperty('notes'..i..'.alpha', 0.5)
                spinnyfuckiesbutonlyforoppo = true
            end
        end
        if floorStep == 1276 then
           doTweenAlpha('noteBGHide','noteBG',0,crochet*0.002,'linear')
        end
        if floorStep == 1280 then
            speedmult = 2
            for i = 0,3 do
                setPropertyFromGroup('strumLineNotes',i,'alpha',1)
                setProperty('notes'..i..'.alpha', 1)
            end
            for i = 4,7 do
                setPropertyFromGroup('strumLineNotes',i,'alpha',0)
                setProperty('notes'..i..'.alpha', 0)
            end
        end
        if floorStep == 1344 then
            laescolours = true
            speedmult = 1
            lol = false
            setTheNotesNormal()
            doTweenAngle('bru9h6', 'camHUD', 0,crochet*0.005,'cubeOut')
            doTweenAngle('brs92fuh6', 'camStrums', 0,crochet*0.005,'cubeOut')
            for i = 0,3 do
                spinnyfuckiesbutonlyforoppo = false
            end
            for i = 0,7 do
                setPropertyFromGroup('strumLineNotes',i,'alpha',1)
                setProperty('notes'..i..'.alpha', 1)
                setPropertyFromGroup('strumLineNotes',i,'color',white*255)
            end
        end
        if floorStep == 1456 then
            for i = 1,3 do
                noteTweenAngle('bruhg6'..i,i,20*i*2,crochet*0.007*i*2,'sineInOut')
                noteTweenAlpha('alphale1'..i,i,0.0001,crochet*0.005*i*2,'sineInOut')
                doTweenY('wow'..i,'notes'..i,500,crochet*0.004*i*2,'sineInOut')
            end
    
            for i = 0,0 do
                noteTweenAngle('bruhgf6'..i,i,20,crochet*0.007,'sineInOut')
                noteTweenAlpha('alphale51'..i,i,0.0001,crochet*0.005,'sineInOut')
                doTweenY('wow'..i,'notes'..i,500,crochet*0.004,'sineInOut')
            end
        end
        if floorStep == 1552 then
            middleScrollLOL()
        end
        if floorStep == 1808 then
            setTheNotesNormal()
            for i = 0,3 do
                noteTweenAngle('bruhgf6'..i,i,0,crochet*0.00007,'expoOutOut')
                doTweenY('wow'..i,'notes'..i,50,crochet*0.00004,'expoOut')
            end
        end
        if floorStep == 1816 then    
            for i = 0,0 do
                noteTweenAlpha('alphale51'..i,i,1,crochet*0.005,'expoOut')
                doTweenY('wow'..i,'notes'..i,0,crochet*0.004,'expoOut')
            end
        end
        if floorStep == 1818 then    
            for i = 1,1 do
                noteTweenAlpha('alphalfe51'..i,i,1,crochet*0.005,'expoOut')
                doTweenY('wozxw'..i,'notes'..i,0,crochet*0.004,'expoOut')
            end
        end
        if floorStep == 1820 then    
            for i = 2,2 do
                noteTweenAlpha('alphalgfe51'..i,i,1,crochet*0.005,'expoOut')
                doTweenY('weow'..i,'notes'..i,0,crochet*0.004,'expoOut')
            end
        end
        if floorStep == 1822 then    
            for i = 3,3 do
                noteTweenAlpha('alphaelfe51'..i,i,1,crochet*0.005,'expoOut')
                doTweenY('wofw'..i,'notes'..i,0,crochet*0.004,'expoOut')
            end
        end
        if floorStep == 1948 or floorStep == 2080 then
            checkthedisk = false
        end
        if floorStep == 2128 then
            endofThearchyNotePos()
        end
        if floorStep == 2384 then
            for i = 1,3 do
                noteTweenAngle('bruhg6'..i,i,20*i*2,crochet*0.007*i*2,'sineInOut')
                noteTweenAlpha('alphale1'..i,i,0.0001,crochet*0.005*i*2,'sineInOut')
                doTweenY('wow'..i,'notes'..i,700,crochet*0.004*i*2,'sineInOut')
            end
    
            for i = 0,0 do
                noteTweenAngle('bruhgf6'..i,i,20,crochet*0.007,'sineInOut')
                noteTweenAlpha('alphale51'..i,i,0.0001,crochet*0.005,'sineInOut')
                doTweenY('wow'..i,'notes'..i,700,crochet*0.004,'sineInOut')
            end
            for i = 4,7 do
                noteTweenAngle('bruhg6'..i,i,20*i/4,crochet*0.007*i/4,'sineInOut')
                noteTweenAlpha('alphale1'..i,i,0.0001,crochet*0.005*i/4,'sineInOut')
                doTweenY('wow'..i,'notes'..i,500,crochet*0.004*i/4,'sineInOut')
            end
        end
    end
    


function onUpdate(elapsed)
    
        songPos = getSongPosition()
        local currentBeat = (songPos/1000)*(bpm/200)

        currentBeat = (songPos / 1000) * (bpm / 140)

        if lol == true then
            setProperty('camHUD.angle',0 - 5 * math.cos((currentBeat*0.25)*math.pi) )
            setProperty('camHUD.x',0 - 5 * math.cos((currentBeat*0.25)*math.pi) )
            setProperty('camStrums.angle',0 - 5 * math.cos((currentBeat*0.25)*math.pi) )
            setProperty('camStrums.x',0 - 5 * math.cos((currentBeat*0.25)*math.pi) )
        end

        --debugPrint(getProperty('notes.length'))

        if spinnyfuckiesbutonlyforbf == true then
            for i = 4,7 do
                setProperty('scalecontrol'..i..'.x', 0.7 * math.cos((currentBeat*0.25 + i/4)*math.pi) * (1 + math.cos((currentBeat*0.25 + 2 +i/4)*math.pi) * 0.25))
                setProperty('scalecontrol'..i..'.y', 0.7 * (1 + math.cos((currentBeat*0.25 + 2 + i/4)*math.pi) * 0.25))
                setProperty('notes'..i..'.y', 60 - 120 * (math.sin(currentBeat*0.25 + math.sin(20 - (currentBeat*0.25 + i/4)*math.pi) * 1.25)))
                setPropertyFromGroup('strumLineNotes',i,'color',math.abs(math.floor(math.sin((currentBeat*0.25 + i/4)*math.pi) * 150) * white))
                setProperty('notes'..i..'.x', 175 + (0 - 300 * math.sin((currentBeat*0.25 + i/4)*math.pi) + -110*(i-1.5)))
            end
        end 

        if spinnyfuckiesbutonlyforoppo == true then
            for i = 0,3 do
                setProperty('scalecontrol'..i..'.x', 0.7 * math.cos((currentBeat*0.25*speedmult + i/4)*math.pi) * (1 + math.cos((currentBeat*0.25 + 2 +i/4)*math.pi) * 0.25))
                setProperty('scalecontrol'..i..'.y', 0.7 * (1 + math.cos((currentBeat*0.25*speedmult + 2 + i/4)*math.pi) * 0.25))
                setProperty('notes'..i..'.y', 60 - 120 * (math.sin(currentBeat*0.25*speedmult + math.sin(20 - (currentBeat*0.25 + i/4)*math.pi) * 1.25)))
                if laescolours == true then
                    setPropertyFromGroup('strumLineNotes',i,'color',math.abs(math.floor(math.sin((currentBeat*0.25*speedmult + i/4)*math.pi) * 150) * white))
                else
                    setPropertyFromGroup('strumLineNotes',i,'color', 50 * white + math.abs(math.floor(math.sin((currentBeat*speedmult * 0.25 + i/4) * math.pi) * 150)) * 65536)
                end
                setProperty('notes'..i..'.x', 325 + (0 - 300 * math.sin((currentBeat*0.25*speedmult + i/4)*math.pi) + -110*(i-1.5)))
            end
        end

        if spinnyfuckies == true then
            for i = 0,7 do
                setProperty('scalecontrol'..i..'.x', 0.7 * math.cos((currentBeat*0.25 + i/4)*math.pi) * (1 + math.cos((currentBeat*0.25 + 2 +i/4)*math.pi) * 0.25))
                setProperty('scalecontrol'..i..'.y', 0.7 * (1 + math.cos((currentBeat*0.25 + 2 + i/4)*math.pi) * 0.25))
                setProperty('notes'..i..'.y', 60 - 120 * (math.sin(currentBeat*0.25 + math.sin(20 - (currentBeat*0.25 + i/4)*math.pi) * 1.25)))
                setPropertyFromGroup('strumLineNotes',i,'color',math.abs(math.floor(math.sin((currentBeat*0.25 + i/4)*math.pi) * 150) * white))
                --setPropertyFromGroup('strumLineNotes',i,'alpha', 0.5 + 1 * math.cos((currentBeat*0.25 + i/4)*math.pi))
            end

            for i = 0,3 do
                setProperty('notes'..i..'.x', 325 + (0 - 300 * math.sin((currentBeat*0.25 + i/4)*math.pi) + -110*(i-1.5)))
            end

            for i = 4,7 do
                setProperty('notes'..i..'.x', 175 + (0 - 300 * math.sin((currentBeat*0.25 + i/4)*math.pi) + -110*(i-1.5)))
            end

            for i1 = 1, getProperty('notes.length') do
                TN = getPropertyFromGroup('notes',i1,'noteData')
                TND = getPropertyFromGroup('notes',i1,'distance')
                TNOX = getPropertyFromGroup('strumLineNotes',TN,'x')
                TNOY = getPropertyFromGroup('strumLineNotes',TN,'y')
                setPropertyFromGroup('notes',i1,'x',TNOX+(0 - 300 * math.sin((currentBeat*0.25 + TN/4)*math.pi) + -110*(TN-1.5)))
                setPropertyFromGroup('notes',i1,'y',TNOY - 120 * (math.sin(currentBeat*0.25 + math.sin(20 - (currentBeat*0.25 + TN/4)*math.pi) * 1.25))*TND*speed)
                setPropertyFromGroup('notes',i1,'scale.x',0.7 * math.cos((currentBeat*0.25 + TN/4)*math.pi) * (1 + math.cos((currentBeat*0.25 + 2 +TN/4)*math.pi) * 0.25))
                setPropertyFromGroup('notes',i1,'scale.y',0.7 * (1 + math.cos((currentBeat*0.25 + 2 + TN/4)*math.pi) * 0.25))
                setPropertyFromGroup('notes',i1,'color',math.abs(math.floor(math.sin((currentBeat*0.25 + TN/4)*math.pi) * 150) * white))
                if getPropertyFromGroup('notes',i1,'mustPress') then
                    TN = TN+4
                    TNOX = getPropertyFromGroup('strumLineNotes',TN,'x')
                    TNOY = getPropertyFromGroup('strumLineNotes',TN,'y')
                    setPropertyFromGroup('notes',i1,'x',TNOX+(0 - 300 * math.sin((currentBeat*0.25 + TN/4)*math.pi) + -110*(TN-1.5)))
                    setPropertyFromGroup('notes',i1,'y',TNOY - 120 * (math.sin(currentBeat*0.25 + math.sin(20 - (currentBeat*0.25 + TN/4)*math.pi) * 1.25))*TND*speed)
                    setPropertyFromGroup('notes',i1,'scale.x',0.7 * math.cos((currentBeat*0.25 + TN/4)*math.pi) * (1 + math.cos((currentBeat*0.25 + 2 +TN/4)*math.pi) * 0.25))
                    setPropertyFromGroup('notes',i1,'scale.y',0.7 * (1 + math.cos((currentBeat*0.25 + 2 + TN/4)*math.pi) * 0.25))
                    setPropertyFromGroup('notes',i1,'color',math.abs(math.floor(math.sin((currentBeat*0.25 + TN/4)*math.pi) * 150) * white))
                end
            end
        else
            for i1 = 1, getProperty('notes.length') do
                TN = getPropertyFromGroup('notes',i1,'noteData')
                TND = getPropertyFromGroup('notes',i1,'distance')
                TNOX = getPropertyFromGroup('strumLineNotes',TN,'x')
                TNOY = getPropertyFromGroup('strumLineNotes',TN,'y')
                setPropertyFromGroup('notes',i1,'x',TNOX)
                setPropertyFromGroup('notes',i1,'y',TNOY*TND*speed)
                setPropertyFromGroup('notes',i1,'scale.x',0.7)
                setPropertyFromGroup('notes',i1,'scale.y',0.7)
                if laescolours == true then
                    setPropertyFromGroup('notes',i1,'color',255+255 * 256+255 * 65536)
                else
                    setPropertyFromGroup('notes',i1,'color',50 * white + math.abs(math.floor(math.sin((currentBeat * 0.25*speedmult + TN/4) * math.pi) * 150)) * 65536)
                end
                if getPropertyFromGroup('notes',i1,'mustPress') then
                    TN = TN+4
                    TNOX = getPropertyFromGroup('strumLineNotes',TN,'x')
                    TNOY = getPropertyFromGroup('strumLineNotes',TN,'y')
                    setPropertyFromGroup('notes',i1,'x',TNOX)
                    setPropertyFromGroup('notes',i1,'y',TNOY*TND*speed)
                    setPropertyFromGroup('notes',i1,'scale.x',0.7)
                    setPropertyFromGroup('notes',i1,'scale.y',0.7)
                    setPropertyFromGroup('notes',i1,'color',255+255 * 256+255 * 65536)
                end
            end
        end
    end

function setTheNotesNormal()
    for i = 0,7 do
        doTweenY('thesca1e'..i,'scalecontrol'..i,0.7,crochet*0.001,'expoOut')
        doTweenX('thessca1e'..i,'scalecontrol'..i,0.7,crochet*0.001,'expoOut')
        doTweenY('wow'..i,'notes'..i,0,crochet*0.005,'expoOut')
        doTweenX('wowa'..i,'notes'..i,0,crochet*0.005,'expoOut')
    end
end

function middleScrollLOL()
    for i = 0,3 do
        doTweenX('wowa'..i,'notes'..i,345,crochet*0.005,'expoOut')
    end
    for i = 4,7 do
        doTweenX('wowa'..i,'notes'..i,-325,crochet*0.005,'expoOut')
    end
end

function endofThearchyNotePos()
    for i = 0,3 do
        doTweenX('wowa'..i,'notes'..i,100,crochet*0.005,'expoOut')
        doTweenY('wogwa'..i,'notes'..i,450,crochet*0.005,'expoOut')
        noteTweenDirection('anglee1'..i,i,-90,crochet*0.005,'expoOut')	
    end
    for i = 4,7 do
        doTweenX('wowa'..i,'notes'..i,-100,crochet*0.005,'expoOut')
    end
end

function fuckingChuddyHud(negorPos, negorPosx, negorPosy, hastheangle)
    setProperty('camHUD.angle', negorPos*5)

    doTweenAngle('bruh6', 'camHUD', 0,crochet*0.005,'cubeOut')

    setProperty('camStrums.angle', negorPos*10)

    doTweenAngle('brsfuh6', 'camStrums', 0,crochet*0.005,'cubeOut')

    chkdskahh(negorPosx*1,negorPosy*1,false)

    if hastheangle == true then
        for i = 1,7 do
            setPropertyFromGroup('strumLineNotes',i,'angle',negorPos*40*i*2)
            noteTweenAngle('bruhg6'..i,i,0,crochet*0.0005*i*2,'expoOut')
        end

        for i = 0,0 do
            setPropertyFromGroup('strumLineNotes',i,'angle',negorPos*40)
            noteTweenAngle('bruhg6'..i,i,0,crochet*0.0005,'expoOut')
        end
    end
end

function chkdskahh(negorPosx, negorPosy, crazyshit)
    if crazyshit == false then
        for i = 0,7 do
            setProperty('notes'..i..'.x',negorPosx*25)
            setTheNotesNormal()
        end

        for i = 1,2 do
            setProperty('notes'..i..'.y',negorPosy*20*i)
        end
        for i = 5,6 do
            setProperty('notes'..i..'.y',negorPosy*20*i/3)
        end
    else
        sillyTween(1)
        setTheNotesNormal()
    end
end

function sillyTween(negorPos)
    flip = -flip
    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes',i,'angle',20*flip)
        setProperty('scalecontrol'..i..'.x',0.65+math.random(0,3)*0.2)
        setProperty('scalecontrol'..i..'.y',0.65+math.random(0,3)*0.2)
        setProperty('notes'..i..'.x',-247.5+55*(i)+math.sin((i*0.5+math.random(1,200)/100)*math.pi)*70+((640)%1280)-640)
        setProperty('notes'..i..'.y',math.sin((i*0.5+math.random(1,200)/100)*math.pi)*70)
        noteTweenAngle('bruh6'..i,i,0,crochet*0.005,'expoOut')
    end
end

function onUpdatePost(elapsed) --run math modchart scripts, hide some hud elements, and run stepHit()

        noteCount = getProperty('notes.length')
        s = -s
        songPos = getSongPosition()
        currentStep = (songPos/1000)*(curBpm/15)
        if currentStep > floorStep+1 then
            floorStep = floorStep+1
            stepHit(floorStep)
        end
        --tweenable variables for use in anything
        scrSpeedMod = getProperty('extravars.x')*0.9
        var2 = getProperty('extravars.y')
        var3 = getProperty('extravars.angle')
        var4 = getProperty('extravars2.x')
        var5 = getProperty('extravars2.y')
        var6 = getProperty('extravars2.angle')
        --modifier range is 0-1 but can be any value
        --setProperty('modifiers1.angle',triangle(currentStep/16,1)-2)
        --setProperty('modifiers5.angle',triangle(currentStep/16,1)-2)
        --setProperty('modifiers2.x',triangle(currentStep/16,1)-2)
        --setProperty('modifiers6.x',triangle(currentStep/16,1)-2)
        --setProperty('modifiers2.y',triangle(currentStep/16,1)-2)
        --setProperty('modifiers6.y',triangle(currentStep/16,1)-2)
        --setProperty('modifiers2.angle',triangle(currentStep/16,1)-2)
        --setProperty('modifiers6.angle',triangle(currentStep/16,1)-2)
        if holyfuckihatethis == true then
        setProperty('modifiers1.angle',0.5)
        setProperty('modifiers5.angle',0.5)
        setProperty('modifiers2.y',math.sin(currentStep/11,1))
        setProperty('modifiers6.y',math.sin(currentStep/11,1))
        setProperty('modifiers2.x',math.sin(currentStep/5,1))
        setProperty('modifiers6.x',math.sin(currentStep/5,1))
        else
            setProperty('modifiers1.angle',0)
            setProperty('modifiers5.angle',0)
            setProperty('modifiers2.y',0)
            setProperty('modifiers6.y',0)
            setProperty('modifiers2.x',0)
            setProperty('modifiers6.x',0)
        end
        for i = 1,8 do
            modifiers[1+(i-1)*3] = getProperty('modifiers' .. i .. '.x') 
            modifiers[2+(i-1)*3] = getProperty('modifiers' .. i .. '.y') 
            modifiers[3+(i-1)*3] = getProperty('modifiers' .. i .. '.angle') 
        end
        timer1=timer1+elapsed*1*modifiers[5]*(curBpm/15)
        timer2=timer2+elapsed*1*modifiers[6]*(curBpm/15)
        timer3=timer3+elapsed*1*modifiers[17]*(curBpm/15)
        timer4=timer4+elapsed*1*modifiers[18]*(curBpm/15)

        speed = getProperty('SPEED.x')*NoteRD
        triggerEvent('Change Scroll Speed',scrSpeedMod, 0.001)
        setPropertyFromGroup('strumLineNotes',0,'x',(strumx1+(0-1.5)*110+getProperty('notes'..'0'..'.x')+math.cos(0*4+timer2/4)*110*modifiers[4]+modifiers[11]*110+modifiers[7]*220+modifiers[9]*330-(screenWidth/2+55))*(1/getProperty('notes' .. 0 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',1,'x',(strumx1+(1-1.5)*110+getProperty('notes'..'1'..'.x')+math.cos(1*4+timer2/4)*110*modifiers[4]+modifiers[11]*-110+modifiers[10]*110+modifiers[8]*220-(screenWidth/2+55))*(1/getProperty('notes' .. 1 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',2,'x',(strumx1+(2-1.5)*110+getProperty('notes'..'2'..'.x')+math.cos(2*4+timer2/4)*110*modifiers[4]+modifiers[7]*-220+modifiers[10]*-110+modifiers[12]*110-(screenWidth/2+55))*(1/getProperty('notes' .. 2 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',3,'x',(strumx1+(3-1.5)*110+getProperty('notes'..'3'..'.x')+math.cos(3*4+timer2/4)*110*modifiers[4]+modifiers[9]*-330+modifiers[8]*-220+modifiers[12]*-110-(screenWidth/2+55))*(1/getProperty('notes' .. 3 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',4,'x',(strumx2+(0-1.5)*110+getProperty('notes'..'4'..'.x')+math.cos(0*4+timer4/4)*110*modifiers[16]+modifiers[23]*110+modifiers[19]*220+modifiers[21]*330-(screenWidth/2+55))*(1/getProperty('notes' .. 4 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',5,'x',(strumx2+(1-1.5)*110+getProperty('notes'..'5'..'.x')+math.cos(1*4+timer4/4)*110*modifiers[16]+modifiers[23]*-110+modifiers[22]*110+modifiers[20]*220-(screenWidth/2+55))*(1/getProperty('notes' .. 5 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',6,'x',(strumx2+(2-1.5)*110+getProperty('notes'..'6'..'.x')+math.cos(2*4+timer4/4)*110*modifiers[16]+modifiers[19]*-220+modifiers[22]*-110+modifiers[24]*110-(screenWidth/2+55))*(1/getProperty('notes' .. 6 .. '.angle'))+(screenWidth/2+55))
        setPropertyFromGroup('strumLineNotes',7,'x',(strumx2+(3-1.5)*110+getProperty('notes'..'7'..'.x')+math.cos(3*4+timer4/4)*110*modifiers[16]+modifiers[21]*-330+modifiers[20]*-220+modifiers[24]*-110-(screenWidth/2+55))*(1/getProperty('notes' .. 7 .. '.angle'))+(screenWidth/2+55))
        for i = 0,3 do
            setPropertyFromGroup('strumLineNotes',i,'y',(strumy+getProperty('notes'..i..'.y')*mult+math.sin(i*4+timer1/4)*110*modifiers[3]+((i+1)%2)*modifiers[1]*490*mult+(i%2)*modifiers[2]*490*mult-(screenHeight/2+55))*(1/getProperty('notes' .. i .. '.angle'))+(screenHeight/2+55))
        end
        for i = 4,7 do
            setPropertyFromGroup('strumLineNotes',i,'y',(strumy+getProperty('notes'..i..'.y')*mult+math.sin(i*4+timer3/4)*110*modifiers[15]+((i+1)%2)*modifiers[13]*490*mult+(i%2)*modifiers[14]*490*mult-(screenHeight/2+55))*(1/getProperty('notes' .. i .. '.angle'))+(screenHeight/2+55))
        end
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes',i,'scale.x',getProperty('scalecontrol'..i..'.x')*(1/getProperty('notes'..i..'.angle')))
            setPropertyFromGroup('strumLineNotes',i,'scale.y',getProperty('scalecontrol'..i..'.y')*(1/getProperty('notes'..i..'.angle')))
        end
    end



function triangle(t,p)
    return 2*p*math.abs(2*(t-math.floor(t+0.5)))
end

function onBeatHit()
        if checkthedisk == true then
            if curBeat % 2 == 0 then
                chkdskahh(1, -1, guh)
            else
                chkdskahh(-1, 1, guh)
            end  
        end

        if enablethehudthirdbeat == true then
            if curBeat % 8 == 2 then
                fuckingChuddyHud(1,1,-1, true)
            else if curBeat % 4 == 2 then
                fuckingChuddyHud(-1,-1,1, true)
            end 
        end
    end
end