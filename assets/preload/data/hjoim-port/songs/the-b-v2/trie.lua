local currentAnim = 'idle-altdef'
local isDancing = false

function onStepHit()
    if curStep == 1 then
        isDancing = false
        currentAnim = 'idle-altdef'
    elseif curStep == 128 then
        isDancing = true
    elseif curStep == 256 then
        isDancing = false
        currentAnim = 'idle-alt3'
    elseif curStep == 512 then
        isDancing = false
        currentAnim = 'idle-alt2'
    elseif curStep == 568 then
        isDancing = false
        currentAnim = 'idle-alt4'
    end
end

function onBeatHit()
    runHaxeCode([[
        var isDancing = ]]..tostring(isDancing)..[[;
        var anim = "]]..currentAnim..[[";
        
        if (!isDancing) {
            game.gf.danceIdle = false;
            game.gf.playAnim(anim, true);
            game.gf.specialAnim = true;
        } else {
            game.gf.danceIdle = true;
            game.gf.specialAnim = false;
            game.gf.dance();
        }
    ]])
end