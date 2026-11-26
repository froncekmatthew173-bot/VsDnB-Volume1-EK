local mult = 1
local randomArray = {math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random()}
local randomArrayTwo = {math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random()}
local randomArrayThree = {math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random()}

function onCreate()
    randomArray = {math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random()}
    randomArrayTwo = {math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random()}
    randomArrayThree = {math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random(), math.random()}
end

function onCreatePost()
    mult = 1
    if downscroll then
        mult = -1
    end
end

local split = {0, 0}
local invert = {0, 0}
local tipsy = {0, 0}

local baseStumx = {240, 900}
local baseStumy = {60, 60}
local baseStuma = {0, 0}
local baseThoseStrums = {0.7, 0.7}
local baseThoseStrumsAwesome = 112

local baseStrumHeight = 0

local vars = {0, 10}
local thoseStrums = {0.7, 0.7}

local songPos = 0
local step = 0
local beat = 0
local stealyourgendergock = 0
local s = 0

local flip = 1

local camCheck = 'game.camHUD'

local offsets = {
    stumx = {0, 0},
    stumy = {0, 0},
    stuma = {0, 0},
    stumf = {1, 1},
    stums = {0.7, 0.7, 0.7, 0.7},
    notex = {0, 0, 0, 0, 0, 0, 0, 0},
    notey = {0, 0, 0, 0, 0, 0, 0, 0},
    notea = {0, 0, 0, 0, 0, 0, 0, 0},
    snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    split = {0, 0},
    invert = {0, 0},
    tipsy = {0, 0},
    tipsyoffset = {0, 0},
    tipsyphase = {0, 0},
    drunkpath = 0,
    hudanglemod = {0, 0},
    hudxmod = 0,
    strumsfollowhud = false,
    speed = {1, 1},
    extra_drunk = 0,
    bumpy_val = 0,
    square_mod = 0,
    spiral_x = 0,
    spiral_y = 0
}

function onUpdatePost(grandfatherclock)
    songPos = getPropertyFromClass('backend.Conductor', 'songPosition')
    step = (songPos / 1000) * (getPropertyFromClass('backend.Conductor', 'bpm') / 15)
    beat = curBeat
    stealyourgendergock = stealyourgendergock + grandfatherclock
    s = curStep % 16

    addNotes(t(0, 256))
    mc_Sec1(t(256, 512))
    mc_Sec2(t(768, 880))
    mc_Sec2Out(t(880, 896))
    mc_Sec3(t(896, 1136))
    mc_Sec3Out(t(1136, 1152))
    mc_Sec4(t(1152, 1392))
    mc_Sec4Out(t(1392, 1408))
    mc_Sec5(t(1408, 1776))
    mc_Sec5Out(t(1776, 1792))
    mc_Sec6(t(1792, 1904))
    mc_Sec7(t(1904, 2176))
    outro(t(2176, 2208))
    goodbyenotesiloveyou(t(2208, 2290))

    for i = 0, 7 do
        local idx = i % 4
        local side = (i < 4 and 1 or 2)

        local splitOffset = (i % 2 == 0 and offsets.split[side] or -offsets.split[side])
        local invertOffset = (i % 2 == 0 and offsets.invert[side] or -offsets.invert[side])
        
        local sOffsetX = (i % 2 == 0 and offsets.stums[1] or offsets.stums[3])
        local sOffsetY = (i % 2 == 0 and offsets.stums[2] or offsets.stums[4])

        local strumOffsetY = offsets.stumy[side]

        local receptorOffsetX = offsets.notex[i + 1]
        local receptorOffsetY = offsets.notey[i + 1]

        local spiralX = math.cos(step / 4 + (i * 0.5)) * offsets.spiral_x
        local spiralY = math.sin(step / 4 + (i * 0.5)) * offsets.spiral_y

        local baseX = (((baseStumx[side] + (idx - 1.5) * 110) + offsets.stumx[side]) + receptorOffsetX) + invertOffset + spiralX
        local baseY = (baseStumy[side] + strumOffsetY + receptorOffsetY) + splitOffset + (math.sin(offsets.tipsyphase[side] + (offsets.tipsyoffset[side] * idx)) * offsets.tipsy[side]) + spiralY
        
        setPropertyFromGroup('strumLineNotes', i, 'x', baseX)
        setPropertyFromGroup('strumLineNotes', i, 'y', downscroll and 620 - baseY or baseY)
        
        setPropertyFromGroup('strumLineNotes', i, 'scale.x', (sOffsetX + offsets.snote[i + 1]))
        setPropertyFromGroup('strumLineNotes', i, 'scale.y', (sOffsetY + offsets.snote[i + 1]))
        setPropertyFromGroup('strumLineNotes', i, 'angle', baseStuma[side] + offsets.stuma[side] + offsets.notea[i + 1])
        setPropertyFromGroup('strumLineNotes', i, 'alpha', offsets.stumf[side])

        baseStrumHeight = getPropertyFromGroup('strumLineNotes', i, 'height')
    end

    local noteCount = getProperty('notes.length')
    for i = 0, noteCount - 1 do
        local nD = getPropertyFromGroup('notes', i, 'noteData') + (getPropertyFromGroup('notes', i, 'mustPress') and 4 or 0)
        local side = (getPropertyFromGroup('notes', i, 'mustPress') and 2 or 1)
        local oX = getPropertyFromGroup('strumLineNotes', nD, 'x')
        local oY = getPropertyFromGroup('strumLineNotes', nD, 'y')
        local isLong = getPropertyFromGroup('notes', i, 'isSustainNote')
        local isLongNOTEND = isLong and getPropertyFromGroup('notes', i, 'nextNote') ~= nil
        local distance = getPropertyFromGroup('notes', i, 'distance')

        local bumpy = math.sin(distance * 0.01) * offsets.bumpy_val
        local extraDrunk = math.cos((songPos / 1000) + (distance / 100)) * offsets.extra_drunk
        
        setPropertyFromGroup('notes', i, 'x', oX + math.sin(distance * 0.003 * math.pi) * offsets.drunkpath + (isLong and 35 or 0) + extraDrunk)
        setPropertyFromGroup('notes', i, 'y', oY + distance * offsets.speed[side] + (35 * offsets.speed[side]) * (isLong and 1 or 0) + (35 - 35 * offsets.speed[side]) * (1 - (isLongNOTEND and 1 or 0)) + bumpy)
        setPropertyFromGroup('notes', i, 'scale.x', (offsets.stums[(getPropertyFromGroup('notes', i, 'mustPress') and 3 or 1)] + offsets.snote[(nD % 2) + 1]))
        setPropertyFromGroup('notes', i, 'scale.y', (offsets.stums[(getPropertyFromGroup('notes', i, 'mustPress') and 4 or 2)] + offsets.snote[(nD % 2) + 1]) + 2.5 * offsets.speed[side] * (isLongNOTEND and 1 or 0))
        setPropertyFromGroup('notes', i, 'alpha', offsets.stumf[side])
    end

    if not offsets.strumsfollowhud then
        setProperty('camStrums.angle', offsets.hudanglemod[2])
    else
        setProperty('camStrums.angle', offsets.hudanglemod[1])
    end

    setProperty('camHUD.angle', offsets.hudanglemod[1])
    setProperty('camHUD.x', offsets.hudxmod)
end

function setOffsets(vals)
    for k, v in pairs(vals) do
        offsets[k] = v
    end
end

function addNotes(range)
    if not range then return end

    setOffsets({
        stums = {0.7, 0.7, 0.7, 0.7},
        split = {0, 0},
        extra_drunk = pingasOut(0, 20, c_linear(0, 1, step / 128), 2),
        spiral_x = pingasOut(0, 50, c_linear(0, 1, step / 256), 4)
    })

    offsets.stumx[1] = 300 + (math.cos(c_linear(1, 2, (step - 80) / 128) * math.pi) + 1) * -100 + pingasIn(0, -130, c_linear(0, 1, (step - 224) / 16), 2)
    offsets.stumx[2] = -300 + (math.cos(c_linear(1, 2, (step - 80) / 128) * math.pi) + 1) * 100 + pingasIn(0, 130, c_linear(0, 1, (step - 224) / 16), 2)

    flip = 1

    for i = 1, 2 do
        offsets.tipsy[i] = pingasOut(0, 10, c_linear(0, 1, step / 128), 2)
        offsets.tipsyoffset[i] = 2
        offsets.tipsyphase[i] = step / 8

        offsets.speed[i] = 0.35 + (math.cos(c_linear(1, 2, (step - 240) / 16) * math.pi) + 1) * 0.325
    end

    for i = 1, 8 do
        offsets.notey[i] = pingasOut(1000, 0, c_linear(0, 1, (step - 120 + randomArray[i] * 100) / 160), 5)
        offsets.notea[i] = pingasOut(((i - 1) % 4 - 1.5) * 40, 0, c_linear(0, 1, (step - 120 + randomArray[i] * 100) / 160), 5)
    end

    for i = 1, 15 do
        local sVal = i % 16
        local chart = '+-+++-+-+++-+-++'
        if string.sub(chart, sVal + 1, sVal + 1) == '+' then
            flip = -flip
            offsets.stums[1] = offsets.stums[1] + pingasOut(0.25, 0, c_linear(0, 1, (step - (239 + i)) / 1.4), 3) * bool_to_number((step - (239 + i)) / 1.2 > 0)
            offsets.stums[2] = offsets.stums[2] + pingasOut(0.25, 0, c_linear(0, 1, (step - (239 + i)) / 1.4), 3) * bool_to_number((step - (239 + i)) / 1.2 > 0)
            offsets.split[1] = offsets.split[1] + pingasOut(flip * 18, 0, c_linear(0, 1, (step - (239 + i)) / 0.6), 1.5) * bool_to_number((step - (239 + i)) / 1.2 > 0)
            offsets.split[2] = offsets.split[2] + pingasOut(flip * 18, 0, c_linear(0, 1, (step - (239 + i)) / 0.6), 1.5) * bool_to_number((step - (239 + i)) / 1.2 > 0)
        end
            
        local chart2 = '++----+-----+---'
        if string.sub(chart2, sVal + 1, sVal + 1) == '+' then
            flip = -flip
            offsets.stums[3] = offsets.stums[3] + pingasOut(0.5, 0, c_linear(0, 1, (step - (239 + i)) / 1.4), 3) * bool_to_number((step - (239 + i)) / 1.2 > 0)
            offsets.stums[4] = offsets.stums[4] + pingasOut(0.5, 0, c_linear(0, 1, (step - (239 + i)) / 1.4), 3) * bool_to_number((step - (239 + i)) / 1.2 > 0)
            offsets.stumx[1] = offsets.stumx[1] + pingasOut(flip * 30, 0, c_linear(0, 1, (step - (239 + i)) / 4), 1.5) * bool_to_number((step - (239 + i)) / 1.2 > 0)
            offsets.stumx[2] = offsets.stumx[2] + pingasOut(flip * 30, 0, c_linear(0, 1, (step - (239 + i)) / 4), 1.5) * bool_to_number((step - (239 + i)) / 1.2 > 0)
        end
    end   
end

function mc_Sec1(range)
    if not range then return end

    setOffsets({
        drunkpath = 12,
        stumx = {0, 0},
        stums = {0.7, 0.7, 0.7, 0.7},
        tipsy = {0, 0},
        tipsyoffset = {4, 4},
        tipsyphase = {step / 4, step / 4},
        hudanglemod = {0, 0},
        strumsfollowhud = false,
        speed = {0.5, 0.5},
        bumpy_val = pingasIn(0, 40, c_linear(0, 1, (step - 256) / 256), 3)
    })

    flip = 2
    local flipeq = (flip < 1 and 1 or 2)

    for i = 1, 2 do
        offsets.stuma[i] = math.sin((step / 8) * 8) * 4
        offsets.stumy[i] = offsets.stumy[i] - math.sin((step / 12) * 4)
    end

    for i = 1, 16 do
        local sVal = i % 16
        if string.sub('+-----+-----+---', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 16) / 4
            local trigger = bool_to_number(stepMod > 0)
            offsets.stums[1] = offsets.stums[1] + pingasOut(0.15, 0, c_linear(0, 1, stepMod), 3) * trigger
            offsets.stums[3] = offsets.stums[3] + pingasOut(0.15, 0, c_linear(0, 1, stepMod), 3) * trigger
            offsets.hudanglemod[1] = offsets.hudanglemod[1] + pingasOut(flip * 0.75 * flipeq, 0, c_linear(0, 1, stepMod), 3) * trigger
            for j = 1, 2 do
                offsets.tipsy[j] = offsets.tipsy[j] + pingasOut(flip * 10 * flipeq, 0, c_linear(0, 1, stepMod), 3) * trigger
                offsets.stumx[j] = offsets.stumx[j] + pingasOut(flip * 20 * flipeq, 0, c_linear(0, 1, stepMod), 1.75) * trigger
                offsets.speed[j] = offsets.speed[j] * pingasOut(1.7, 1, c_linear(0, 1, stepMod), 3) * trigger
            end
        end
        if string.sub('---+-----+-----+', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 16) / 4
            local trigger = bool_to_number(stepMod > 0)
            offsets.stums[2] = offsets.stums[2] + pingasOut(0.15, 0, c_linear(0, 1, stepMod), 3) * trigger
            offsets.stums[4] = offsets.stums[4] + pingasOut(0.15, 0, c_linear(0, 1, stepMod), 3) * trigger
            offsets.hudanglemod[1] = offsets.hudanglemod[1] + pingasOut(flip * 0.75 * flipeq, 0, c_linear(0, 1, stepMod), 3) * trigger
            for j = 1, 2 do
                offsets.tipsy[j] = offsets.tipsy[j] + pingasOut(flip * 10 * flipeq, 0, c_linear(0, 1, stepMod), 3) * trigger
                offsets.stumx[j] = offsets.stumx[j] + pingasOut(flip * 20 * flipeq, 0, c_linear(0, 1, stepMod), 1.75) * trigger
                offsets.speed[j] = offsets.speed[j] * pingasOut(1.7, 1, c_linear(0, 1, stepMod), 3) * trigger
            end
        end
    end
end

function mc_Sec2(range)
    if not range then return end
    setOffsets({
        stumx = {0, 0}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, tipsy = {0.25, 0.25},
        tipsyoffset = {4, 4}, tipsyphase = {step / 4, step / 4}, hudanglemod = {0, 0},
        strumsfollowhud = false, split = {0, 0}, invert = {0, 0}, drunkpath = 12, hudxmod = 0, speed = {0.5, 0.5},
        extra_drunk = 40, spiral_x = 100, spiral_y = 100
    })
    flip = 2
    local flipeq = (flip < 1 and 1 or 2)
    for i = 1, 2 do
        offsets.stuma[i] = math.sin((step / 8) * 8) * 4
        offsets.stumx[i] = offsets.stumx[i] + math.sin((step / 8) * 8) * 4
        offsets.invert[i] = offsets.invert[i] + math.sin((step / 8) * 8) * 4
    end
    for i = 1, 32 do
        local sVal = i % 32
        if string.sub('+--+--+--+--+---+--+--+--+--++++', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 32) / 4
            local trigger = bool_to_number(stepMod > 0)
            offsets.hudxmod = offsets.hudxmod + pingasOut(flip * 20 * flipeq, 0, c_linear(0, 1, stepMod), 3) * trigger
            for j = 1, 2 do 
                offsets.split[j] = offsets.split[j] + pingasOut(flip * 20 * flipeq, 0, c_linear(0, 1, stepMod), 4) * trigger 
                offsets.spiral_x = offsets.spiral_x + pingasOut(flip * 50, 0, c_linear(0, 1, stepMod), 2) * trigger
            end
        end
    end
end

function mc_Sec2Out(range)
    if not range then return end
    setOffsets({
        stumx = {0, 0}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, tipsy = {0, 0},
        tipsyoffset = {0, 0}, tipsyphase = {0, 0}, hudanglemod = {0, 0}, strumsfollowhud = true,
        split = {0, 0}, invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 6, hudxmod = 0, extra_drunk = 0, spiral_x = 0, spiral_y = 0
    })
    flip = -1
    for i = 1, 2 do
        offsets.tipsy[i] = 10
        offsets.tipsyoffset[i] = 2
        offsets.tipsyphase[i] = step / 8
        offsets.speed[i] = 0.35 + (math.cos(c_linear(1, 2, (step - 880) / 16) * math.pi) + 1) * 0.325
    end
    for i = 1, 15 do
        local sVal = i % 16
        if string.sub('+-+++-+-+++-+-++', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            offsets.stums[1] = offsets.stums[1] + pingasOut(0.25, 0, c_linear(0, 1, (step - (880 + i)) / 1.4), 3) * bool_to_number((step - (880 + i)) / 1.2 > 0)
            offsets.stums[2] = offsets.stums[2] + pingasOut(0.25, 0, c_linear(0, 1, (step - (880 + i)) / 1.4), 3) * bool_to_number((step - (880 + i)) / 1.2 > 0)
            offsets.split[1] = offsets.split[1] + pingasOut(flip * 18, 0, c_linear(0, 1, (step - (880 + i)) / 0.6), 1.5) * bool_to_number((step - (880 + i)) / 1.2 > 0)
            offsets.split[2] = offsets.split[2] + pingasOut(flip * 18, 0, c_linear(0, 1, (step - (880 + i)) / 0.6), 1.5) * bool_to_number((step - (880 + i)) / 1.2 > 0)
        end
        if string.sub('++----+-----+---', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            offsets.stums[3] = offsets.stums[3] + pingasOut(0.5, 0, c_linear(0, 1, (step - (880 + i)) / 1.4), 3) * bool_to_number((step - (880 + i)) / 1.2 > 0)
            offsets.stums[4] = offsets.stums[4] + pingasOut(0.5, 0, c_linear(0, 1, (step - (880 + i)) / 1.4), 3) * bool_to_number((step - (880 + i)) / 1.2 > 0)
            offsets.stumx[1] = offsets.stumx[1] + pingasOut(flip * 30, 0, c_linear(0, 1, (step - (880 + i)) / 4), 1.5) * bool_to_number((step - (880 + i)) / 1.2 > 0)
            offsets.stumx[2] = offsets.stumx[2] + pingasOut(flip * 30, 0, c_linear(0, 1, (step - (880 + i)) / 4), 1.5) * bool_to_number((step - (880 + i)) / 1.2 > 0)
        end
    end
end

function mc_Sec3(range)
    if not range then return end
    setOffsets({
        stumx = {0, 0}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, tipsy = {25, 25},
        tipsyoffset = {4, 4}, tipsyphase = {step / 8, step / 8}, hudanglemod = {0, 0}, strumsfollowhud = true,
        split = {0, 0}, invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 6, hudxmod = 0, speed = {1, 1}, extra_drunk = 60, bumpy_val = 20
    })
    flip = 3
    for i = 1, 8 do
        offsets.notex[i] = offsets.notex[i] + math.sin((step / 10) * 3) * (12.5) * (i % 2 == 0 and 1 or -1)
        offsets.notey[i] = offsets.notey[i] + math.cos((step / 10) * 3) * (12.5) * (i % 2 == 0 and 1 or -1)
        offsets.notea[i] = offsets.notea[i] + math.sin((step / 10) * 3) * (7.5) * (i % 2 == 0 and 1 or -1)
    end
    for i = 1, 2 do offsets.tipsy[i] = offsets.tipsy[i] + math.sin((step / 10) * 3) * (7.5) / 35 end
    for i = 1, 8 do
        local sVal = i % 8
        if string.sub('+-++-++-', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 8)
            local trigger = bool_to_number(stepMod > 0)
            for j = 1, 2 do offsets.split[j] = offsets.split[j] + pingasOut(-10 * flip, 0, c_linear(0, 1, stepMod), 3) * trigger end
        end
        if string.sub('--+---+-', sVal + 1, sVal + 1) == '+' then
            local stepMod = ((step / 2 - i) % 8)
            local trigger = bool_to_number(stepMod > 0)
            for j = 1, 2 do
                local val = 0.1
                offsets.stums[((j-1) % 2) + 1] = offsets.stums[((j-1) % 2) + 1] + pingasOut(val * flip, 0, c_linear(0, 1, stepMod), 1) * trigger
                offsets.stums[((j-1) % 2) + 3] = offsets.stums[((j-1) % 2) + 3] + pingasOut(val * -flip, 0, c_linear(0, 1, stepMod), 1) * trigger
            end
        end
    end
end

function mc_Sec3Out(range)
    if not range then return end
    setOffsets({
        stumx = {0, 0}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, tipsy = {0, 0},
        tipsyoffset = {0, 0}, tipsyphase = {0, 0}, hudanglemod = {0, 0}, strumsfollowhud = true,
        split = {0, 0}, invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 6, hudxmod = 0, extra_drunk = 0, bumpy_val = 0
    })
    flip = -1
    for i = 1, 2 do
        offsets.tipsy[i] = 10
        offsets.tipsyoffset[i] = 2
        offsets.tipsyphase[i] = step / 8
        offsets.speed[i] = 0.35 + (math.cos(c_linear(1, 2, (step - 1136) / 16) * math.pi) + 1) * 0.325
    end
    for i = 1, 15 do
        local sVal = i % 16
        if string.sub('+-+++-+-+++-+-++', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            offsets.stums[1] = offsets.stums[1] + pingasOut(0.25, 0, c_linear(0, 1, (step - (1136 + i)) / 1.4), 3) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
            offsets.stums[2] = offsets.stums[2] + pingasOut(0.25, 0, c_linear(0, 1, (step - (1136 + i)) / 1.4), 3) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
            offsets.split[1] = offsets.split[1] + pingasOut(flip * 18, 0, c_linear(0, 1, (step - (1136 + i)) / 0.6), 1.5) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
            offsets.split[2] = offsets.split[2] + pingasOut(flip * 18, 0, c_linear(0, 1, (step - (1136 + i)) / 0.6), 1.5) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
        end
        if string.sub('++----+-----+---', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            offsets.stums[3] = offsets.stums[3] + pingasOut(0.5, 0, c_linear(0, 1, (step - (1136 + i)) / 1.4), 3) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
            offsets.stums[4] = offsets.stums[4] + pingasOut(0.5, 0, c_linear(0, 1, (step - (1136 + i)) / 1.4), 3) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
            offsets.stumx[1] = offsets.stumx[1] + pingasOut(flip * 30, 0, c_linear(0, 1, (step - (1136 + i)) / 4), 1.5) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
            offsets.stumx[2] = offsets.stumx[2] + pingasOut(flip * 30, 0, c_linear(0, 1, (step - (1136 + i)) / 4), 1.5) * bool_to_number((step - (1136 + i)) / 1.2 > 0)
        end
    end
end

function mc_Sec4(range)
    if not range then return end
    setOffsets({
        stumx = {0, 0}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, tipsy = {30, 30},
        tipsyoffset = {4, 4}, tipsyphase = {step / 8, step / 8}, hudanglemod = {0, 0}, strumsfollowhud = false,
        split = {0, 0}, invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 2, hudxmod = 0, speed = {0.4, 0.4}, extra_drunk = 20, spiral_x = 200, spiral_y = 50
    })
    for i = 1, 8 do offsets.notea[i] = offsets.notea[i] + math.sin((step / 8)) * (22.5) * (i % 2 == 0 and 1 or -1) end
    for i = 1, 2 do offsets.stumx[i] = pingasOut(0, 330 * (i == 1 and 1 or -1), c_linear(0, 1, (step - 1152) / 16), 2) end
    if step < 1220 then offsets.stumf[1] = pingasOut(1, 0.5, c_linear(0, 1, (step - 1200) / 16), 2) end
    if step > 1270 then offsets.stumf[1] = pingasOut(0.5, 0, c_linear(0, 1, (step - 1280) / 16), 0.5) end
    offsets.tipsy[1] = pingasOut(30, 0, c_linear(0, 1, (step - 1280) / 16), 0.5)
    offsets.stumy[1] = pingasOut(0, 300, c_linear(0, 1, (step - 1280) / 16), 0.5)
end

function mc_Sec4Out(range)
    if not range then return end
    offsets.speed[1] = 0.1
    offsets.stumy[1] = 0
    offsets.stumf[1] = pingasIn(0, 1, c_linear(0, 1, (step - 1392) / 16), 0.5)
    for i = 1, 2 do
        offsets.tipsy[i] = pingasIn(30, 0, c_linear(0, 1, (step - 1392) / 16), 0.5)
        offsets.stumx[i] = pingasIn(330 * (i == 1 and 1 or -1), 0, c_linear(0, 1, (step - 1392) / 16), 0.5)
    end
    offsets.speed[2] = pingasIn(0.4, 4, c_linear(0, 1, (step - 1392) / 16), 5)
    for i = 1, 8 do offsets.notea[i] = pingasOut(offsets.notea[i], 360, c_linear(0, 1, (step - 1392) / 16), 0.3) end
    for i = 1, 8 do offsets.notex[i] = ((((step - math.floor(step)))) * 100 + (50 * (i % 2 == 0 and -1 or 1))) * (i % 2 == 0 and -1 or 1) / (0.1) / 4 end
    offsets.drunkpath = pingasIn(2, 100, c_linear(0, 1, (step - 1392) / 16), 5)
    setProperty('camStrums.angle', math.tan(step * 10))
end

function mc_Sec5(range)
    if not range then return end
    setOffsets({
        stumx = {0, 0}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, stumf = {1, 1},
        notey = {0, 0, 0, 0, 0, 0, 0, 0}, notea = {0, 0, 0, 0, 0, 0, 0, 0}, split = {0, 0}, invert = {0, 0},
        tipsy = {0, 0}, tipsyoffset = {0, 0}, tipsyphase = {0, 0}, hudanglemod = {0, 0}, extra_drunk = 10,
        bumpy_val = 0, spiral_x = 0, spiral_y = 0
    })
    for i = 1, 8 do offsets.notex[i] = pingasOut(offsets.notex[i], 0, c_linear(0, 1, (step - 1408) / 16), 2) end
    offsets.drunkpath = pingasOut(100, 10, c_linear(0, 1, (step - 1408) / 16), 2)
    offsets.speed[1] = pingasOut(0.1, 1, c_linear(0, 1, (step - 1408) / 16), 7)
    offsets.speed[2] = pingasOut(4, 1, c_linear(0, 1, (step - 1408) / 16), 7)
    for i = 1, 8 do
        offsets.notex[i] = offsets.notex[i] + (math.cos(step / 2) * 50 * (i % 2 == 0 and 1 or -1)) / 2
        offsets.notey[i] = (math.sin(step / 2) * 30 * (i % 2 == 0 and 1 or -1)) / 2
        offsets.notea[i] = offsets.notea[i] + math.sin(step / 16) * 360
    end
    for i = 1, 8 do
        local sVal = i % 8
        if string.sub('+-++-++-', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 8)
            local trigger = bool_to_number(stepMod > 0)
            for j = 1, 2 do offsets.invert[j] = offsets.invert[j] + pingasOut(-10 * flip, 0, c_linear(0, 1, stepMod), 3) * trigger end
        end
    end
end

function mc_Sec5Out(range)
    if not range then return end
    setOffsets({
        stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, stumf = {1, 1}, split = {0, 0},
        tipsy = {0, 0}, tipsyoffset = {0, 0}, tipsyphase = {0, 0}, hudanglemod = {0, 0}
    })
    offsets.drunkpath = pingasOut(10, 0, c_linear(0, 1, (step - 1776) / 22), 10)
    for i = 1, 8 do
        offsets.notex[i] = pingasOut(offsets.notex[i], 0, c_linear(0, 1, (step - 1776) / 20), 0.25)
        offsets.notey[i] = pingasOut(offsets.notey[i], 0, c_linear(0, 1, (step - 1776) / 20), 0.25)
        offsets.notea[i] = pingasOut(offsets.notea[i], math.sin((step / 8)) * (22.5) * (i % 2 == 0 and 1 or -1), c_linear(0, 1, (step - 1776) / 40), 0.05)
    end
    for i = 1, 2 do
        offsets.invert[i] = pingasIn(offsets.invert[i], 0, c_linear(0, 1, (step - 1776) / 40), 7)
        offsets.speed[i] = pingasIn(1, 0.7, c_linear(0, 1, (step - 1776) / 22), 7)
        offsets.stumx[i] = pingasIn(0, 330 * (i == 1 and 1 or -1), c_linear(0, 1, (step - 1776) / 16), 8)
    end
end

function mc_Sec6(range)
    if not range then return end
    setOffsets({
        stumx = {330, -330}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, stuma = {0, 0}, tipsy = {30, 30},
        tipsyoffset = {4, 4}, tipsyphase = {step / 8, step / 8}, hudanglemod = {0, 0}, strumsfollowhud = false,
        split = {0, 0}, invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 2, hudxmod = 0, speed = {0.2, 0.7}, extra_drunk = 100, bumpy_val = 50
    })
    for i = 1, 8 do offsets.notea[i] = offsets.notea[i] + math.sin((step / 8)) * (22.5) * (i % 2 == 0 and 1 or -1) end
    offsets.stumf[1] = pingasOut(0.25, 1, c_linear(0, 1, (step - 1904) / 16), 0.5)
    offsets.tipsy[1] = pingasOut(0, 30, c_linear(0, 1, (step - 1904) / 16), 0.5)
end

function mc_Sec7(range)
    if not range then return end
    setOffsets({
        stumx = {330, -330}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, tipsyoffset = {4, 4},
        tipsyphase = {step / 8, step / 8}, hudanglemod = {0, 0}, strumsfollowhud = false, split = {0, 0},
        invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 2, hudxmod = 0, speed = {0.7, 0.7}, extra_drunk = 10, bumpy_val = 10
    })
    offsets.tipsy[1] = pingasOut(30, 0, c_linear(0, 1, (step - 2176) / 16), 0.5)
end

function outro(range)
    if not range then return end
    setOffsets({
        stumx = {330, -330}, stumy = {0, 0}, stums = {0.7, 0.7, 0.7, 0.7}, tipsyoffset = {4, 4},
        tipsyphase = {step / 8, step / 8}, hudanglemod = {0, 0}, strumsfollowhud = false, split = {0, 0},
        invert = {0, 0}, notex = {0, 0, 0, 0, 0, 0, 0, 0}, notey = {0, 0, 0, 0, 0, 0, 0, 0},
        notea = {0, 0, 0, 0, 0, 0, 0, 0}, snote = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        drunkpath = 2, hudxmod = 0, speed = {0.7, 0.7}
    })
    local flipeq = (flip < 1 and 1 or 2)
    for i = 1, 2 do offsets.tipsy[i] = pingasOut(30, 0, c_linear(0, 1, (step - 2176) / 16), 3) end
    for i = 1, 32 do
        local sVal = i % 32
        if string.sub('+-----+-----+-----------+---+-+-', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 32) / 8
            local trigger = bool_to_number(stepMod > 0)
            for j = 1, 2 do offsets.invert[j] = offsets.invert[j] + pingasOut(flip * -10 * flipeq, 0, c_linear(0, 1, stepMod), 3) * trigger end
        end
        if string.sub('------------------+-----+---+-+-', sVal + 1, sVal + 1) == '+' then
            flip = -flip
            local stepMod = ((step / 2 - i) % 32) / 8
            local trigger = bool_to_number(stepMod > 0)
            for j = 1, 2 do offsets.split[j] = offsets.split[j] + pingasOut(flip * 20 * flipeq, 0, c_linear(0, 1, stepMod), 4) * trigger end
        end
    end
end

function goodbyenotesiloveyou(range)
    if not range then return end
    for i = 1, 2 do offsets.stumf[i] = pingasOut(1, 0, c_linear(0, 1, (step - 2208 - ((i-1) * 0.45)) / 64), 4) end
    for i = 1, 8 do
        local idx = (i-1) % 4
        local v = {-80, -20, 20, 80}
        offsets.notex[i] = pingasOut(0, (v[idx + 1] * 2), c_linear(0, 1, (step - 2208) / 54), 2)
        offsets.notey[i] = pingasOut(0, 720 * (idx == 0 and 1.2 or 0.7), c_linear(0, 1, (step - 2208 - ((i-1) * 0.45)) / 65), 2)
        offsets.notea[i] = pingasIn(0, 73 * (idx == 0 and 1.2 or 0.7), c_linear(0, 1, (step - 2208) / 62), 1)
    end
end

function t(x, y) return (x < step and step < y) end
function tri(x) return math.abs((((x / 2) % 1) - 0.5) * 2) end
function c_linear(a, b, x)
    if x < 0 then return a end
    if x > 1 then return b end
    return b * x + a * (1 - x)
end
function linear(a, b, x) return b * x + a * (1 - x) end
function pingasIn(a, b, x, n) return linear(a, b, math.pow(x, n)) end
function pingasOut(a, b, x, n) return pingasIn(b, a, 1 - x, n) end
function bool_to_number(v) return (v and 1 or 0) end