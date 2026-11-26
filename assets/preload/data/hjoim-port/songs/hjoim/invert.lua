local shaderName = "invert"

function onCreate()
    shaderCoordFix()

    makeLuaSprite("invert")
    makeGraphic("invert", screenWidth, screenHeight)

    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        game.initLuaShader(shaderName);
        var shader0 = game.createRuntimeShader(shaderName);
        game.getLuaObject("invert").shader = shader0;
    ]])
end

function onStepHit()
    if curStep == 590 then
        runHaxeCode([[
            var shader0 = game.getLuaObject("invert").shader;
            var filter = new ShaderFilter(shader0);
            game.camGame.setFilters([filter]);
            game.camHUD.setFilters([filter]);
            game.camOther.setFilters([filter]);
        ]])
    end

    if curStep == 700 then
        runHaxeCode([[
            game.camGame.setFilters([]);
            game.camHUD.setFilters([]);
            game.camOther.setFilters([]);
        ]])
    end
end

function onUpdate(elapsed)
    setShaderFloat("invert", "iTime", os.clock())
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
        ]])
        if (temp) then temp() end
    end
end