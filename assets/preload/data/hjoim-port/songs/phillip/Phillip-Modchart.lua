local lmaoflicker = true
local s = 2
local randomtable = {math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random()} 
function onCreatePost()
    mult = 1
    if downscroll then
        mult = -1
    end
    randomtable = {math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random()} 
end
function onUpdatePost()
    songPos = getSongPosition()
    step = (songPos/1000)*(curBpm/15)
    strumx1 = 240
    strumx2 = 900
    strumxs1 = 0.7
    strumys1 = 0.7
    strumxs2 = 0.7
    strumys2 = 0.7
    strumy1 = 60
    strumy2 = 60
    tipsy1 = 0
    tipsy1_phase = 0
    tipsy1_offset = 0
    tipsy2 = 0
    tipsy2_phase = 0
    tipsy2_offset = 0

    tipsy12 = 0
    tipsy12_phase = 0
    tipsy12_offset = 0
    tipsy22 = 0
    tipsy22_phase = 0
    tipsy22_offset = 0
    
    strumxah = {0,0,0,0,0,0,0,0} 
    strumyah = {0,0,0,0,0,0,0,0}
    strumah = {0,0,0,0,0,0,0,0} 
    guh = -500
    split1 = 0
    split2 = 0
    struma1 = 0
    struma2 = 0
    invert1 = 0
    invert2 = 0
    alphamod = 1
    speed = 1
    drunkNotepath = 0
    var1 = 0
    var2 = 10
    hudanglemod = 0
    hudanglemod2 = 0
    hudxmod = 0
    strumsfollowhud = false
  
        bestmodchartever2(t(0,2))
        bestmodchartever(t(3,524))
        bestmodchartever2(t(524,2555))

    setProperty('camHUD.angle',hudanglemod)
    setProperty('camHUD.x',hudxmod)
    if strumsfollowhud == false then
        setProperty('camStrums.angle',hudanglemod2)
    else
        setProperty('camStrums.angle',hudanglemod)
    end
    
    setPropertyFromGroup('strumLineNotes',0,'x',(strumx1+(0-1.5)*110)+invert1+strumxah[1]+math.sin(tipsy12_phase)*tipsy12)
    setPropertyFromGroup('strumLineNotes',1,'x',(strumx1+(1-1.5)*110)-invert1+strumxah[2]+math.sin(tipsy12_phase+tipsy12_offset)*tipsy12)
    setPropertyFromGroup('strumLineNotes',2,'x',(strumx1+(2-1.5)*110)+invert1+strumxah[3]+math.sin(tipsy12_phase+tipsy12_offset*2)*tipsy12)
    setPropertyFromGroup('strumLineNotes',3,'x',(strumx1+(3-1.5)*110)-invert1+strumxah[4]+math.sin(tipsy12_phase+tipsy12_offset*3)*tipsy12)
    setPropertyFromGroup('strumLineNotes',4,'x',(strumx2+(0-1.5)*110)+invert2+strumxah[5]+math.sin(tipsy22_phase)*tipsy22)
    setPropertyFromGroup('strumLineNotes',5,'x',(strumx2+(1-1.5)*110)-invert2+strumxah[6]+math.sin(tipsy22_phase+tipsy22_offset)*tipsy22)
    setPropertyFromGroup('strumLineNotes',6,'x',(strumx2+(2-1.5)*110)+invert2+strumxah[7]+math.sin(tipsy22_phase+tipsy22_offset*2)*tipsy22)
    setPropertyFromGroup('strumLineNotes',7,'x',(strumx2+(3-1.5)*110)-invert2+strumxah[8]+math.sin(tipsy22_phase+tipsy22_offset*3)*tipsy22)
    if downscroll then
        setPropertyFromGroup('strumLineNotes',0,'y',620-strumy1+split1-strumyah[1]-math.sin(tipsy1_phase)*tipsy1)
        setPropertyFromGroup('strumLineNotes',1,'y',620-strumy1-split1-strumyah[2]-math.sin(tipsy1_phase+tipsy1_offset)*tipsy1)
        setPropertyFromGroup('strumLineNotes',2,'y',620-strumy1+split1-strumyah[3]-math.sin(tipsy1_phase+tipsy1_offset*2)*tipsy1)
        setPropertyFromGroup('strumLineNotes',3,'y',620-strumy1-split1-strumyah[4]-math.sin(tipsy1_phase+tipsy1_offset*3)*tipsy1)
        setPropertyFromGroup('strumLineNotes',4,'y',620-strumy2+split2-strumyah[5]-math.sin(tipsy2_phase)*tipsy2)
        setPropertyFromGroup('strumLineNotes',5,'y',620-strumy2-split2-strumyah[6]-math.sin(tipsy2_phase+tipsy2_offset)*tipsy2)
        setPropertyFromGroup('strumLineNotes',6,'y',620-strumy2+split2-strumyah[7]-math.sin(tipsy2_phase+tipsy2_offset*2)*tipsy2)
        setPropertyFromGroup('strumLineNotes',7,'y',620-strumy2-split2-strumyah[8]-math.sin(tipsy2_phase+tipsy2_offset*3)*tipsy2)
    else
        setPropertyFromGroup('strumLineNotes',0,'y',strumy1+split1+strumyah[1]+math.sin(tipsy1_phase)*tipsy1)
        setPropertyFromGroup('strumLineNotes',1,'y',strumy1-split1+strumyah[2]+math.sin(tipsy1_phase+tipsy1_offset)*tipsy1)
        setPropertyFromGroup('strumLineNotes',2,'y',strumy1+split1+strumyah[3]+math.sin(tipsy1_phase+tipsy1_offset*2)*tipsy1)
        setPropertyFromGroup('strumLineNotes',3,'y',strumy1-split1+strumyah[4]+math.sin(tipsy1_phase+tipsy1_offset*3)*tipsy1)
        setPropertyFromGroup('strumLineNotes',4,'y',strumy2+split2+strumyah[5]+math.sin(tipsy2_phase)*tipsy2)
        setPropertyFromGroup('strumLineNotes',5,'y',strumy2-split2+strumyah[6]+math.sin(tipsy2_phase+tipsy2_offset)*tipsy2)
        setPropertyFromGroup('strumLineNotes',6,'y',strumy2+split2+strumyah[7]+math.sin(tipsy2_phase+tipsy2_offset*2)*tipsy2)
        setPropertyFromGroup('strumLineNotes',7,'y',strumy2-split2+strumyah[8]+math.sin(tipsy2_phase+tipsy2_offset*3)*tipsy2)
    end
    setPropertyFromGroup('strumLineNotes',0,'scale.x',strumxs1)
    setPropertyFromGroup('strumLineNotes',1,'scale.x',strumxs1)
    setPropertyFromGroup('strumLineNotes',2,'scale.x',strumxs1)
    setPropertyFromGroup('strumLineNotes',3,'scale.x',strumxs1)
    setPropertyFromGroup('strumLineNotes',4,'scale.x',strumxs2)
    setPropertyFromGroup('strumLineNotes',5,'scale.x',strumxs2)
    setPropertyFromGroup('strumLineNotes',6,'scale.x',strumxs2)
    setPropertyFromGroup('strumLineNotes',7,'scale.x',strumxs2)
    setPropertyFromGroup('strumLineNotes',0,'scale.y',strumys1)
    setPropertyFromGroup('strumLineNotes',1,'scale.y',strumys1)
    setPropertyFromGroup('strumLineNotes',2,'scale.y',strumys1)
    setPropertyFromGroup('strumLineNotes',3,'scale.y',strumys1)
    setPropertyFromGroup('strumLineNotes',4,'scale.y',strumys2)
    setPropertyFromGroup('strumLineNotes',5,'scale.y',strumys2)
    setPropertyFromGroup('strumLineNotes',6,'scale.y',strumys2)
    setPropertyFromGroup('strumLineNotes',7,'scale.y',strumys2)
    setPropertyFromGroup('strumLineNotes',0,'angle',struma1+strumah[1])
    setPropertyFromGroup('strumLineNotes',1,'angle',struma1+strumah[2])
    setPropertyFromGroup('strumLineNotes',2,'angle',struma1+strumah[3])
    setPropertyFromGroup('strumLineNotes',3,'angle',struma1+strumah[4])
    setPropertyFromGroup('strumLineNotes',4,'angle',struma2+strumah[5])
    setPropertyFromGroup('strumLineNotes',5,'angle',struma2+strumah[6])
    setPropertyFromGroup('strumLineNotes',6,'angle',struma2+strumah[7])
    setPropertyFromGroup('strumLineNotes',7,'angle',struma2+strumah[8])
    for i1 = 0, getProperty('notes.length')-1 do
        TN = getPropertyFromGroup('notes',i1,'noteData')
        TND = getPropertyFromGroup('notes',i1,'distance')
        TNOX = getPropertyFromGroup('strumLineNotes',TN,'x')
        TNOY = getPropertyFromGroup('strumLineNotes',TN,'y')
        isLong = bool_to_number(getPropertyFromGroup('notes',i1,'isSustainNote'))
        isLongNOTEND = bool_to_number(getPropertyFromGroup('notes',i1,'isSustainNote') and getPropertyFromGroup('notes',i1,'nextNote'))
        setPropertyFromGroup('notes',i1,'x',TNOX+math.sin(TND*0.003*math.pi)*drunkNotepath+35*isLong)
        setPropertyFromGroup('notes',i1,'y',TNOY+TND*speed+(35*speed)*isLong+(35-35*speed)*(1-isLongNOTEND))
        setPropertyFromGroup('notes',i1,'scale.x',strumxs1)
        setPropertyFromGroup('notes',i1,'scale.y',(strumys1+2.5*speed*isLongNOTEND))
        if getPropertyFromGroup('notes',i1,'mustPress') then
          TN = TN+4
          TNOX = getPropertyFromGroup('strumLineNotes',TN,'x')
          TNOY = getPropertyFromGroup('strumLineNotes',TN,'y')
          setPropertyFromGroup('notes',i1,'x',TNOX+math.sin(TND*0.003*math.pi)*drunkNotepath+35*isLong)
          setPropertyFromGroup('notes',i1,'y',TNOY+TND*speed+(35*speed)*isLong+(35-35*speed)*(1-isLongNOTEND))
          setPropertyFromGroup('notes',i1,'scale.x',strumxs2)
          setPropertyFromGroup('notes',i1,'scale.y',(strumys2*(1-isLongNOTEND)+3.15*speed*isLongNOTEND))
        end
    end
end

function t(x,y)
    return x < step and step < y
end

function bestmodchartever(range)
    if range then
        drunkNotepath = 40;
        tipsy1 = 50+math.sin(pingasOut(140,0,tri(step/2+1), 1)*2)
        tipsy1_offset = 2
        tipsy1_phase = step/8
        tipsy2 = 50+math.sin(pingasOut(70,0,tri(step/2+1), 1)*2)
        tipsy2_offset = 2
        tipsy2_phase = step/8

        tipsy12 = -50+math.sin(pingasOut(140,0,tri(step/2+1),1)*2)
        tipsy12_offset = step/40
        tipsy12_phase = step/6
        tipsy22 = -50+math.sin(pingasOut(70,0,tri(step/2+1), 1)*2)
        tipsy22_offset = step/40
        tipsy22_phase = step/6
    end
end

function bestmodchartever2(range)
    if range then
        drunkNotepath = 75;
        tipsy1 = 520+math.sin(pingasOut(140,0,tri(step/2+1), 1)*2)
        tipsy1_offset = step/2*0.15
        tipsy1_phase = step/8
        tipsy2 = 520+math.sin(pingasOut(70,0,tri(step/2+1), 1)*2)
        tipsy2_offset = step/2*0.15
        tipsy2_phase = step/8

        tipsy12 = -80+math.sin(pingasOut(140,0,tri(step/2+1),1)*2)
        tipsy12_offset = step/0.1
        tipsy12_phase = step/6*2
        tipsy22 = -80+math.sin(pingasOut(70,0,tri(step/2+1), 1)*2)
        tipsy22_offset = step/0.1
        tipsy22_phase = step/6*2
    end
end

function changeProperty(tag,value)
    setProperty(tag,getProperty(tag)+value)
end

function tri(x)
    return math.abs((((x/2)%1)-0.5)*2)
end
function c_linear(a,b,x)
    if x < 0 then
        return a
    end
    if x > 1 then
        return b
    end
    return b*x+a*(1-x)
end
function linear(a,b,x)
    return b*x+a*(1-x)
end
function pingasIn(a,b,x,n)
    return linear(a,b,math.pow(x,n))
end
function pingasOut(a,b,x,n)
    return pingasIn(b,a,1-x,n)
end

function bool_to_number(value)
    return value and 1 or 0
  end
--string.sub(s, 1, 1) WOW
--string.sub('x--x--x-', math.floor(step) % 8 + 1, math.floor(step) % 8 + 1) == 'x' WOW