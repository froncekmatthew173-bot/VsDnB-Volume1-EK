
local isLong = false
local isLongNOTEND = false
local TN = 0
local TND = 0
local TNOX = 0
local TNOY = 0
local TNOA = 0
local noteX = 0
local noteY = 0
local noteX2 = 0
local noteY2 = 0
local LNnumber = -180/math.pi
local songScrollSpeed = 1
local LNpoint = 1
local LNoffset = 100
local minsquare = 0
local squares = 0
function onCreate()
end
function onCreatePost()
    mult = 1
    if downscroll then
        mult = -1
    end 
    makeLuaSprite('blackSquare',1,1)
    makeGraphic('blackSquare', 1282, 722, 'FFFFFF')
    addLuaSprite('blackSquare',true)
    setProperty('blackSquare.x',-1)
    setProperty('blackSquare.y',-1)
    setProperty('blackSquare.alpha',0.4)
    setObjectCamera('blackSquare', 'other')
    setBlendMode('blackSquare','add')

    makeLuaSprite('whiteSquare',1,1)
    makeGraphic('whiteSquare', 1282, 722, 'FFFFFF')
    addLuaSprite('whiteSquare',true)
    setProperty('whiteSquare.x',-1)
    setProperty('whiteSquare.y',-1)
    setProperty('whiteSquare.alpha',0.4)
    setObjectCamera('whiteSquare', 'other')
    setBlendMode('whiteSquare','subtract')
end
function onUpdatePost()
   
    songPos = getSongPosition()
    step = (songPos/1000)*(curBpm/15)
    graphicEffect = 0.12-math.cos(step*math.pi/(24-passStep(712)*15))*0.12+powOut(-2,0,clamp(0,1,(step-704)/8),5)*passStep(704)+powIn(0,1,clamp(0,1,(step-1100)/4),2)
    if t(704,708) then
            for i = 0,15 do
	        makeSquare(math.random(-200,1280),math.random(-200,720),true,linear(2,0,clamp(0,1,(step-704)/4)))
            end
    end
    strumx1 = 240
    strumx2 = 900
    strumxs1 = 0.7
    strumys1 = 0.7
    strumxs2 = 0.7
    strumys2 = 0.7
    strumy1 = 60
    strumy2 = 60
    strumxN = {0,0,0,0,0,0,0,0}
    strumyN = {0,0,0,0,0,0,0,0}
    strumxsN = {1,1,1,1,1,1,1,1}
    strumysN = {1,1,1,1,1,1,1,1}
    strumalphaN = {1,1,1,1,1,1,1,1}
    split1 = 0
    split2 = 0
    struma1 = 0
    struma2 = 0 
    strumalpha1 = 1
    strumalpha2 = 1
    strumcolor1 = 255+255*256+255*65536
    strumcolor2 = 255+255*256+255*65536
    flip1 = 0
    flip2 = 0
    invert1 = 0
    invert2 = 0
    speed1 = 1.6
    speed2 = 1.6
    scrollx1 = 0
    scrollx2 = 0
    drunkNotepath1 = 0
    drunkNotepath2 = 0
    testmodifier = 0
    hjoim_mod1 = 0
    hjoim_mod2 = 7
    hjoim_mod3 = -1
    hjoim_mod4 = -2
    beatNotepath2 = 0
    beatNotepath1 = 0
    healthbarY = 100
    var1 = 0
    var2 = 0
    var3 = 0
    var4 = 0
    var5 = 0
    if getPropertyFromClass('backend.ClientPrefs', 'data.modchart') then
    hjoimHide(t(0,56))
    hjoimIntro(t(56,64),56)
    hjoimHide(t(576,584))
    hjoimFASTS(t(540,576),540)
    hjoimIntro(t(584,592),584)
    --hjoimHide(t(976,978))
    --hjoimIntroEvil(t(978,986),978)
    hjoimTransition1(t(304,448),304)
    hjoimStandard1(t(64,320))
    end
    -- modchartSection00000(t(0,99999))
    -- modchartSection00001(t(128,99999))
    -- modchartSection00002(t(382,640),382)
    -- modchartSection00002(t(894,1152),894)
    -- modchartSection00003(t(1264,99999))
    -- --t(192,196) or t(320,324) or t(380,384) or t(636,640) or t(704,708) or t(832,836) or t(892,896) or t(1148,9999)
    -- modchartSection00004(t(192,198),192)
    -- modchartSection00004(t(320,326),320)
    -- modchartSection00004(t(380,386),380)
    -- modchartSection00004(t(636,642),636)
    -- modchartSection00004(t(704,710),704)
    -- modchartSection00004(t(832,838),832)
    -- modchartSection00004(t(892,898),892)
    speed1 = speed1*1.28
    speed2 = speed2*1.28
    setProperty('blackSquare.alpha',graphicEffect)
    setProperty('whiteSquare.alpha',graphicEffect)
    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes',i,'x',(strumx1+(i-1.5)*(110-flip1))+invert1*(((i+0.5)%2-1)*2)+strumxN[i+1])
        setPropertyFromGroup('strumLineNotes',i+4,'x',(strumx2+(i-1.5)*(110-flip2))+invert2*(((i+0.5)%2-1)*2)+strumxN[i+5])
        setPropertyFromGroup('strumLineNotes',i,'scale.x',strumxs1*strumxsN[i+1])
        setPropertyFromGroup('strumLineNotes',i+4,'scale.x',strumxs2*strumxsN[i+5])
        setPropertyFromGroup('strumLineNotes',i,'scale.y',strumys1*strumysN[i+1])
        setPropertyFromGroup('strumLineNotes',i+4,'scale.y',strumys2*strumysN[i+5])
        setPropertyFromGroup('strumLineNotes',i,'angle',struma1)
        setPropertyFromGroup('strumLineNotes',i+4,'angle',struma2)
        setPropertyFromGroup('strumLineNotes',i,'alpha',strumalpha1*strumalphaN[i+1])
        setPropertyFromGroup('strumLineNotes',i+4,'alpha',strumalpha2*strumalphaN[i+5])
        setPropertyFromGroup('strumLineNotes',i,'color',strumcolor1)
        setPropertyFromGroup('strumLineNotes',i+4,'color',strumcolor2)
    end
    if downscroll then
        for i = 0,3 do
        setPropertyFromGroup('strumLineNotes',i,'y',620-strumy1+split1*((i+0.5)%2*2)-strumyN[i+1])
        setPropertyFromGroup('strumLineNotes',i+4,'y',620-strumy2+split2*((i+0.5)%2*2)-strumyN[i+5])
        end
        setProperty('healthBar.y',healthbarY)
        setProperty('healthBarBG.y',healthbarY)
        setProperty('healthBarOverlay.y',healthbarY)
        setProperty('iconP1.y',-50+healthbarY)
        setProperty('iconP2.y',-50+healthbarY)
    else
        for i = 0,3 do
        setPropertyFromGroup('strumLineNotes',i,'y',strumy1+split1*((i+0.5)%2*2)+strumyN[i+1])
        setPropertyFromGroup('strumLineNotes',i+4,'y',strumy2+split2*((i+0.5)%2*2)+strumyN[i+5])
        end
        setProperty('healthBar.y',720-healthbarY)
        setProperty('healthBarBG.y',720-healthbarY)
        setProperty('healthBarOverlay.y',720-healthbarY)
        setProperty('iconP1.y',670-healthbarY)
        setProperty('iconP2.y',670-healthbarY)
    end
    --debugPrint(getPropertyFromGroup('notes',1,'isSustainNote') and getPropertyFromGroup('notes',1,'nextNote'))
    --debugPrint(getPropertyFromGroup('notes',1,'nextNote'))
    for i1 = 0, getProperty('notes.length')-1 do
      isLong = bool_to_number(getPropertyFromGroup('notes',i1,'isSustainNote'))
      isLongNOTEND = bool_to_number(getPropertyFromGroup('notes',i1,'isSustainNote') and (getPropertyFromGroup('notes',i1,'nextNote') == 'nextNote'))
      isLongEND = isLong - isLongNOTEND
      isDown = 1-bool_to_number(downscroll)*2
      TN = getPropertyFromGroup('notes',i1,'noteData')
      TND = getPropertyFromGroup('notes',i1,'distance')
      TNType = getPropertyFromGroup('notes',i1,'noteType')
      getNoteData(TN)
      getNotePos1(i1,LNpoint)
      setNotePos1(i1)
      if getPropertyFromGroup('notes',i1,'mustPress') then
        getNoteData(TN+4)
        getNotePos2(i1,LNpoint)
        setNotePos2(i1)
      end
      if TNType == 'No Animation' then
        setPropertyFromGroup('notes',i1,'alpha',getPropertyFromGroup('notes',i1,'alpha')*0.3)
      end
    end
    upd_squares()
end
function getNoteData(n)
    TNOX = getPropertyFromGroup('strumLineNotes',n,'x')
    TNOY = getPropertyFromGroup('strumLineNotes',n,'y')
    TNOA = getPropertyFromGroup('strumLineNotes',n,'angle')
    TNOAlpha = getPropertyFromGroup('strumLineNotes',n,'alpha')
end
function getNotePos1(n,ms)
    spd = speed1
    TND = getPropertyFromGroup('notes',n,'distance')+LNoffset*isLong*mult-70*isLongEND*mult
    noteX = TNOX+math.sin(TND*pi_adjusted()*4)*drunkNotepath1+(math.cos(TND*pi_adjusted()*4)-1)/2*testmodifier+35*isLong+TND*isDown*scrollx1+beat(2+TND*0.02)*2*beatNotepath1*(1-isLong)
    noteY = TNOY+TND*spd+25*isLongEND-35*isLongNOTEND-80*isLongNOTEND*(-1+isDown)+math.sin(TND*pi_adjusted()*4)/2*testmodifier
    TND = getPropertyFromGroup('notes',n,'distance')+ms+LNoffset*isLong*mult-70*isLongEND*mult
    noteX2 = TNOX+math.sin(TND*pi_adjusted()*4)*drunkNotepath1+(math.cos(TND*pi_adjusted()*4)-1)/2*testmodifier+35*isLong+TND*isDown*scrollx1+beat(2+TND*0.02)*2*beatNotepath1*(1-isLong)
    noteY2 = TNOY+TND*spd+25*isLongEND-35*isLongNOTEND-80*isLongNOTEND*(-1+isDown)+math.sin(TND*pi_adjusted()*4)/2*testmodifier
    TND = getPropertyFromGroup('notes',n,'distance')+LNoffset*isLong*mult-70*isLongEND*mult
end
function getNotePos2(n,ms)
    spd = speed2
    TND = getPropertyFromGroup('notes',n,'distance')+LNoffset*isLong*mult-70*isLongEND*mult
    noteX = TNOX+math.sin(TND*pi_adjusted()*4)*drunkNotepath2+(math.cos(TND*pi_adjusted()*4)-1)/2*testmodifier+35*isLong+TND*isDown*scrollx2+beat(2+TND*0.02)*2*beatNotepath2*(1-isLong)
    noteY = TNOY+TND*spd+25*isLongEND-35*isLongNOTEND-80*isLongNOTEND*(-1+isDown)+math.sin(TND*pi_adjusted()*4)/2*testmodifier
    TND = getPropertyFromGroup('notes',n,'distance')+ms+LNoffset*isLong*mult-70*isLongEND*mult
    noteX2 = TNOX+math.sin(TND*pi_adjusted()*4)*drunkNotepath2+(math.cos(TND*pi_adjusted()*4)-1)/2*testmodifier+35*isLong+TND*isDown*scrollx2+beat(2+TND*0.02)*2*beatNotepath2*(1-isLong)
    noteY2 = TNOY+TND*spd+25*isLongEND-35*isLongNOTEND-80*isLongNOTEND*(-1+isDown)+math.sin(TND*pi_adjusted()*4)/2*testmodifier
    TND = getPropertyFromGroup('notes',n,'distance')+LNoffset*isLong*mult-70*isLongEND*mult
end
function setNotePos1(n)
    setPropertyFromGroup('notes',n,'x',noteX)
    setPropertyFromGroup('notes',n,'y',noteY)
    setPropertyFromGroup('notes',n,'angle',TNOA*(1-isLong)-(dir_x_to_y(noteX,noteY,noteX2,noteY2)+90/LNnumber)*isLong*LNnumber+180*bool_to_number(noteX>noteX2)*isLongEND)
    setPropertyFromGroup('notes',n,'alpha',TNOAlpha*(1-c_linear(0,1,-hjoim_mod2+TND*0.013*isDown))-c_linear(0,1,hjoim_mod3-TND*0.013*isDown))
    setPropertyFromGroup('notes',n,'scale.x',strumxs1)
    setPropertyFromGroup('notes',n,'scale.y',(strumys1*(1-isLongNOTEND)*(1-hjoim_mod1+math.cos(math.pi*bool_to_number(hjoim_mod4+TND*isDown>3*math.pi/0.02)+clamp(0,math.pi*2,hjoim_mod4+TND*0.02*isDown)/2)*hjoim_mod1)+dist_x_to_y(noteX,noteY,noteX2,noteY2)*songScrollSpeed*(isLongNOTEND)*1.1/LNpoint))
end
function setNotePos2(n)
    setPropertyFromGroup('notes',n,'x',noteX)
    setPropertyFromGroup('notes',n,'y',noteY)
    setPropertyFromGroup('notes',n,'angle',TNOA*(1-isLong)-(dir_x_to_y(noteX,noteY,noteX2,noteY2)+90/LNnumber)*isLong*LNnumber+180*bool_to_number(noteX>noteX2)*isLongEND)
    setPropertyFromGroup('notes',n,'alpha',TNOAlpha*(1-c_linear(0,1,-hjoim_mod2+TND*0.013*isDown))-c_linear(0,1,hjoim_mod3-TND*0.013*isDown))
    setPropertyFromGroup('notes',n,'scale.x',strumxs2)
    setPropertyFromGroup('notes',n,'scale.y',(strumys2*(1-isLongNOTEND)*(1-hjoim_mod1+math.cos(math.pi*bool_to_number(hjoim_mod4+TND*isDown>3*math.pi/0.02)+clamp(0,math.pi*2,hjoim_mod4+TND*0.02*isDown)/2)*hjoim_mod1)+dist_x_to_y(noteX,noteY,noteX2,noteY2)*songScrollSpeed*(isLongNOTEND)*1.1/LNpoint))
end
function hjoimHide(range)
    if range then
        strumalpha1 = 0
        strumalpha2 = 0
    end
end
function hjoimIntro(range,start)
    if range then
        hjoim_mod2 = c_linear(0,7,(step-start)/4)
        speed1 = powIn(0.3,1.6,clamp(0,1,(step-start)/8),5)
        speed2 = powIn(0.3,1.6,clamp(0,1,(step-start)/8),5)
        strumxs1 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumxs2 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumys1 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumys2 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        flip1 = powIn(55,0,clamp(0,1,(step-start-4)/2),5)
        flip2 = powIn(55,0,clamp(0,1,(step-start-4)/2),5)
        strumy1 = powIn(160,60,clamp(0,1,(step-start-4)/2),5)
        strumy2 = powIn(160,60,clamp(0,1,(step-start-4)/2),5)
            strumalphaN[1]=passStep(start)
            strumalphaN[2]=passStep(start+3)
            strumalphaN[3]=passStep(start+2)
            strumalphaN[4]=passStep(start+4)
            strumxsN[1]=powOut(2,1,clamp(0,1,(step-start)/2),4)*passStep(start)
            strumxsN[2]=powOut(2,1,clamp(0,1,(step-start-3)/2),4)*passStep(start+3)
            strumxsN[3]=powOut(2,1,clamp(0,1,(step-start-2)/2),4)*passStep(start+2)
            strumxsN[4]=powOut(2,1,clamp(0,1,(step-start-4)/2),4)*passStep(start+4)
            strumysN[1]=powOut(2,1,clamp(0,1,(step-start)/2),4)*passStep(start)
            strumysN[2]=powOut(2,1,clamp(0,1,(step-start-3)/2),4)*passStep(start+3)
            strumysN[3]=powOut(2,1,clamp(0,1,(step-start-2)/2),4)*passStep(start+2)
            strumysN[4]=powOut(2,1,clamp(0,1,(step-start-4)/2),4)*passStep(start+4)
            strumalphaN[5]=passStep(start+2)
            strumalphaN[6]=passStep(start+4)
            strumalphaN[7]=passStep(start+3)
            strumalphaN[8]=passStep(start+6)
            strumxsN[5]=powOut(2,1,clamp(0,1,(step-start-2)/2),4)*passStep(start-2)
            strumxsN[6]=powOut(2,1,clamp(0,1,(step-start-4)/2),4)*passStep(start+4)
            strumxsN[7]=powOut(2,1,clamp(0,1,(step-start-3)/2),4)*passStep(start+3)
            strumxsN[8]=powOut(2,1,clamp(0,1,(step-start-6)/2),4)*passStep(start+6)
            strumysN[5]=powOut(2,1,clamp(0,1,(step-start-2)/2),4)*passStep(start-2)
            strumysN[6]=powOut(2,1,clamp(0,1,(step-start-4)/2),4)*passStep(start+4)
            strumysN[7]=powOut(2,1,clamp(0,1,(step-start-3)/2),4)*passStep(start+3)
            strumysN[8]=powOut(2,1,clamp(0,1,(step-start-6)/2),4)*passStep(start+6)
    end
end
function hjoimStandard1(range)
    var1=powIn(0,8,clamp(0,1,(step-64)/2),2)+powOut(0,45,clamp(0,1,(step-66)/30),4)+powIn(0,-11,clamp(0,1,(step-92)/4),2)+powOut(0,-50,clamp(0,1,(step-96)/22),4)+powOut(0,-15,clamp(0,1,(step-112)/8),4)+powIn(0,3,clamp(0,1,(step-118)/2),2)+powOut(0,15,clamp(0,1,(step-120)/12),4)+powIn(0,4,clamp(0,1,(step-126)/2),2)+powOut(0,20,clamp(0,1,(step-128)/32),4)+powIn(0,-2,clamp(0,1,(step-156)/4),2)+powOut(0,-12,clamp(0,1,(step-160)/24),4)
    var2=powIn(0,5,clamp(0,1,(step-64)/2),2)+powOut(0,30,clamp(0,1,(step-66)/30),4)+powIn(0,4,clamp(0,1,(step-92)/4),2)+powOut(0,22,clamp(0,1,(step-96)/22),4)+powOut(0,-15,clamp(0,1,(step-112)/8),4)+powIn(0,2,clamp(0,1,(step-118)/2),2)+powOut(0,12,clamp(0,1,(step-120)/12),4)+powIn(0,-11,clamp(0,1,(step-126)/2),2)+powOut(0,-50,clamp(0,1,(step-128)/32),4)+powIn(0,6,clamp(0,1,(step-156)/4),2)+powOut(0,65,clamp(0,1,(step-160)/24),4)
    var3=powIn(0,0.3,clamp(0,1,(step-124)/4),2)+powOut(0,0.3,clamp(0,1,(step-128)/4),2)
    var4=powIn(1,0,clamp(0,1,(step-184)/4),5)
    var5=powOut(0,1,clamp(0,1,(step-192)/4),5)-powOut(0,1,clamp(0,1,(step-316)/4),5)
    if passStep(192) == 1 then
        step = step-128
        var1=powIn(0,8,clamp(0,1,(step-64)/2),2)+powOut(0,45,clamp(0,1,(step-66)/30),4)+powIn(0,-11,clamp(0,1,(step-92)/4),2)+powOut(0,-50,clamp(0,1,(step-96)/22),4)+powOut(0,-15,clamp(0,1,(step-112)/8),4)+powIn(0,3,clamp(0,1,(step-118)/2),2)+powOut(0,15,clamp(0,1,(step-120)/12),4)+powIn(0,4,clamp(0,1,(step-126)/2),2)+powOut(0,20,clamp(0,1,(step-128)/32),4)+powIn(0,-2,clamp(0,1,(step-156)/4),2)+powOut(0,-12,clamp(0,1,(step-160)/24),4)
        var2=powIn(0,5,clamp(0,1,(step-64)/2),2)+powOut(0,30,clamp(0,1,(step-66)/30),4)+powIn(0,4,clamp(0,1,(step-92)/4),2)+powOut(0,22,clamp(0,1,(step-96)/22),4)+powOut(0,-15,clamp(0,1,(step-112)/8),4)+powIn(0,2,clamp(0,1,(step-118)/2),2)+powOut(0,12,clamp(0,1,(step-120)/12),4)+powIn(0,-11,clamp(0,1,(step-126)/2),2)+powOut(0,-50,clamp(0,1,(step-128)/32),4)+powIn(0,6,clamp(0,1,(step-156)/4),2)+powOut(0,65,clamp(0,1,(step-160)/24),4)
        var3=0.3
        step = step+128
    end
    strumx1 = strumx1+var1*(1-var3)*(var4+var5)
    strumy1 = strumy1+var2*(1-var3)*(var4+var5)
    strumx2 = strumx2+var1*(0.4+var3)*(var4+var5)
    strumy2 = strumy2+var2*(0.4+var3)*(var4+var5)
    strumx1 = strumx1+(powOut(0,25,clamp(0,1,(step%16)/2),3)+powIn(0,-25,clamp(0,1,((step%16)-2)/2),3)+powOut(0,-25,clamp(0,1,((step%16)-6)/2),3)+powIn(0,25,clamp(0,1,((step%16)-8)/4),3))*var5
    strumx2 = strumx2+(powOut(0,25,clamp(0,1,(step%16)/2),3)+powIn(0,-25,clamp(0,1,((step%16)-2)/2),3)+powOut(0,-25,clamp(0,1,((step%16)-6)/2),3)+powIn(0,25,clamp(0,1,((step%16)-8)/4),3))*var5
    drunkNotepath1 =(powOut(0,25,clamp(0,1,(step%16)/2),3)+powIn(0,-25,clamp(0,1,((step%16)-2)/2),3)+powOut(0,-25,clamp(0,1,((step%16)-6)/2),3)+powIn(0,25,clamp(0,1,((step%16)-8)/4),3))*var5
    drunkNotepath2 =(powOut(0,25,clamp(0,1,(step%16)/2),3)+powIn(0,-25,clamp(0,1,((step%16)-2)/2),3)+powOut(0,-25,clamp(0,1,((step%16)-6)/2),3)+powIn(0,25,clamp(0,1,((step%16)-8)/4),3))*var5
    for i = 1,4 do
        strumyN[i+0]=math.sin(step/4+i*2)*powOut(0,20,clamp(0,1,(step-64)/4),4)*var4+(math.sin(step/4+i*2)*(powOut(35,0,clamp(0,1,((step%16)-4)/2),3)*passStep(math.floor((step)/16)*16+4)+powOut(35,0,clamp(0,1,((step%16)-12)/2),3)*passStep(math.floor((step)/16)*16+12)))*var5
        strumyN[i+4]=math.sin(step/4+i*2)*powOut(0,20,clamp(0,1,(step-64)/4),4)*var4+(math.sin(step/4+i*2)*(powOut(35,0,clamp(0,1,((step%16)-4)/2),3)*passStep(math.floor((step)/16)*16+4)+powOut(35,0,clamp(0,1,((step%16)-12)/2),3)*passStep(math.floor((step)/16)*16+12)))*var5*0.7
    end
end
function hjoimTransition1(range,start)
    if range then
        var1 = powOut(0,1,clamp(0,1,(step-start-12)/2),2)-powIn(0,1,clamp(0,1,(step-start-14)/2),2)
        var2 = powOut(0,1,clamp(0,1,(step-start-16)/32),2)
        var3 = (math.floor(step/4)%2-0.5)*powIn(-2,2,(step%4)/4,5)
        var4 = powIn(0,1,clamp(0,1,(step-start-8)/8),5)*1+powIn(0,-0.5,clamp(0,1,(step-start-138)/2),2)+powOut(0,-0.5,clamp(0,1,(step-start-140)/2),2)
        --var5 = 1+powIn(0,-1,clamp(0,1,(step-start-140)/4),2)
        var5 = 1
        drunkNotepath1 = var3*20*var2*var5
        drunkNotepath2 = var1*100+var3*20*var2*var5
        speed1 = 1.6-var4*2.8
        speed2 = 1.6-var4*2.8
        strumy1 = 60+var4*500+math.sin((step-start-16)*4)*passStep(start+16)*powOut(50,0,clamp(0,1,(step-start-16)/4),2)
        strumy2 = 60+var4*500+math.sin((step-start-16)*4)*passStep(start+16)*powOut(50,0,clamp(0,1,(step-start-16)/4),2)
        scrollx1 = var3*var2*0.25*var5
        scrollx2 = var3*var2*0.25*var5
        strumx1 = 570-var5*330+beat(step-math.abs(math.sin(step*math.pi/4)*1.3))*var2*-40+var3*-35*var2
        strumx2 = 570+var5*330+beat(step-math.abs(math.sin(step*math.pi/4)*1.3))*var2*-40+var3*-35*var2
        hjoim_mod1 = var4
        hjoim_mod2 = 7*(1-var4)+var2*4*var5
        hjoim_mod3 = -1+3*var2*var5
        healthbarY = 100+var4*520
        struma1 = var4*180+(powIn(0,-0.5,clamp(0,1,(step-start-138)/2),2)+powOut(0,-0.5,clamp(0,1,(step-start-140)/2),2))*-360
        struma2 = var4*180+(powIn(0,-0.5,clamp(0,1,(step-start-138)/2),2)+powOut(0,-0.5,clamp(0,1,(step-start-140)/2),2))*-360
    end
end
function hjoimFASTS(range,start)
    if range then
        speed1 = speed1*((1-powOut(0,0.7,c_linear(0,1,(step-start-4)/4),2))*passStep(start+4)+(powIn(1,2,c_linear(0,1,(step-start)/16),3)+powOut(0,1,c_linear(0,1,(step-start-16)/16),3)))
    end
end
function hjoimIntroEvil(range,start)
    if range then
        hjoim_mod2 = c_linear(0,7,(step-start)/4)
        speed1 = powIn(0.3,1.6,clamp(0,1,(step-start)/6),5)
        speed2 = powIn(0.3,1.6,clamp(0,1,(step-start)/6),5)
        strumxs1 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumxs2 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumys1 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumys2 = powIn(0.35,0.7,clamp(0,1,(step-start-4)/2),5)
        strumx1 = 570
        strumx2 = 570
        flip1 = powIn(55,0,clamp(0,1,(step-start-4)/2),5)
        flip2 = powIn(55,0,clamp(0,1,(step-start-4)/2),5)
        strumy1 = powIn(160,60,clamp(0,1,(step-start-4)/2),5)
        strumy2 = powIn(160,60,clamp(0,1,(step-start-4)/2),5)
        for i = 0,1 do
            strumalphaN[1+i*4]=passStep(start+2)
            strumalphaN[2+i*4]=passStep(start)
            strumalphaN[3+i*4]=passStep(start+4)
            strumalphaN[4+i*4]=passStep(start+1)
            strumxsN[1+i*4]=powOut(2,1,clamp(0,1,(step-start-2)/2),4)*passStep(start+2)
            strumxsN[2+i*4]=powOut(2,1,clamp(0,1,(step-start)/2),4)*passStep(start)
            strumxsN[3+i*4]=powOut(2,1,clamp(0,1,(step-start-4)/2),4)*passStep(start+4)
            strumxsN[4+i*4]=powOut(2,1,clamp(0,1,(step-start-1)/2),4)*passStep(start+1)
            strumysN[1+i*4]=powOut(2,1,clamp(0,1,(step-start-2)/2),4)*passStep(start+2)
            strumysN[2+i*4]=powOut(2,1,clamp(0,1,(step-start)/2),4)*passStep(start)
            strumysN[3+i*4]=powOut(2,1,clamp(0,1,(step-start-4)/2),4)*passStep(start+4)
            strumysN[4+i*4]=powOut(2,1,clamp(0,1,(step-start-1)/2),4)*passStep(start+1)
        end
    end
end
function hjoimEnd(range)
end
function changeProperty(tag,value)
    setProperty(tag,getProperty(tag)+value)
end
function colorRGB(r,g,b) return math.floor(r)+math.floor(g)*256+math.floor(b)*65536 end
function HSV(h, s, v)
    local vert = math.ceil(h / 120)
    local r = math.abs(((h / 60) - 2 * vert))
    local r, g, b = clamp(1 - s, 1, r), clamp(1 - s, 1, 2 - r), (1 - s * v)

    if vert == 1 then return colorRGB(r * 255, g * 255, b * 255) end
    if vert == 2 then return colorRGB(b * 255, r * 255, g * 255) end
    if vert == 3 then return colorRGB(g * 255, b * 255, r * 255) end
end
function t(x,y) return x < step and step < y end
function tri(x) return math.abs((((x/2)%1)-0.5)*2) end
function beat(x) return (tri(x/2)+tri(x)/2-0.5)*(math.floor(x/4-0.5)/2%1*2-0.5) end
function quant(x,y) return x-x%y end
function c_linear(a,b,x) if x < 0 then return a end if x > 1 then return b end return b*x+a*(1-x) end
function clamp(a,b,x) if x < a then return a end if x > b then return b end return x end
function linear(a,b,x) return b*x+a*(1-x) end
function quadIn(a,b,x) return linear(a,b,x*x) end
function quadOut(a,b,x) return quadIn(b,a,1-x) end
function expoOut(a,b,x) return linear(a,b,2-2^1-x*10/2) end
function powIn(a,b,x,n) return linear(a,b,x^n) end
function powOut(a,b,x,n) return powIn(b,a,1-x,n) end
function powInOut(a,b,x,n)
    if x < 0.5 then
        powIn(a,(a+b)/2,x*2,n)
    else
        powOut((a+b)/2,b,(x-0.5)*2,n)
    end
end
function passStep(value) return (step>value) and 1 or 0 end
function bool_to_number(value) return value and 1 or 0 end
function dir_x_to_y(x1,y1,x2,y2) return math.atan((y2-y1)/(x2-x1)) end
function dist_x_to_y(x1,y1,x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
function pi_adjusted() return 0.002*math.pi/songScrollSpeed end
--string.sub(s, 1, 1) WOW
--string.sub('x--x--x-', math.floor(step) % 8 + 1, math.floor(step) % 8 + 1) == 'x' WOW
function upd_squares()
    for i = minsquare,squares-1 do
        setProperty('sqrthing'..i..'.scale.x',getProperty('sqrthing'..i..'.scale.x')*0.84)
        setProperty('sqrthing'..i..'.scale.y',getProperty('sqrthing'..i..'.scale.y')*0.84)
        setProperty('sqrthing'..i..'.x',linear(getProperty('sqrthing'..i..'.x'),640,-0.002))
        setProperty('sqrthing'..i..'.y',linear(getProperty('sqrthing'..i..'.y'),360,0.004))
        if (getProperty('sqrthing'..i..'.scale.x')+getProperty('sqrthing'..i..'.scale.y')) < 0.001 then
            removeLuaSprite('sqrthing'..i,true)
            minsquare = minsquare+1
        end
    end
end
function makeSquare(x,y,layer,scale)
    squaresize = math.random(50,280)
    makeLuaSprite('sqrthing'..squares,'',x,y)
    makeGraphic('sqrthing'..squares,squaresize*scale,280/(squaresize/50)*scale,'FFFFFF')
    setProperty('sqrthing'..squares..'.color',HSV(math.random(1,3)*120,1,1))
    setBlendMode('sqrthing'..squares,'subtract')
    setObjectCamera('sqrthing'..squares,'other')
    addLuaSprite('sqrthing'..squares,layer)
    squares = squares+1
end