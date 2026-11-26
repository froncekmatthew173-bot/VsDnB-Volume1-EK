local spriteName = 'stopfucking'
local startEffect = false
local tsuka = false
local elapsedTime = 0

function onCreatePost()
    setProperty('dad.y', -1000)
    addHaxeLibrary('FlxBackdrop', 'flixel.addons.display')

    makeLuaSprite('blackScareen', 'thearchyRedThing', 0, 0)
    setObjectCamera('blackScareen', 'hud')
    screenCenter('blackScareen', 'xy')
    setProperty('blackScareen.alpha', 0)
    addLuaSprite('blackScareen', true)

    makeLuaSprite('aaa', 'red', 0, 0)
    setObjectCamera('aaa', 'other')
    screenCenter('aaa', 'xy')
    addLuaSprite('aaa', true)
    setProperty('aaa.scale.x', 5)
    setProperty('aaa.scale.y', 5)
    setProperty('aaa.alpha', 0)
    
    runHaxeCode([[
        var shaderCode:String = '
            #pragma header
            uniform float amount;
            uniform float iTime;
            
            float rand(vec2 co){
                return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
            }

            void main()
            {
                vec2 uv = openfl_TextureCoordv;
                vec2 center = vec2(0.5, 0.5);
                
                float glitch = step(0.9, rand(vec2(floor(uv.y * 20.0), iTime))) * amount * 0.5;
                vec2 offset = ((uv - center) * amount) + vec2(glitch, 0.0);
                
                vec2 rUV = clamp(uv - offset, 0.0, 1.0);
                vec2 bUV = clamp(uv + offset, 0.0, 1.0);
                
                vec4 rCol = flixel_texture2D(bitmap, rUV);
                vec4 gCol = flixel_texture2D(bitmap, uv);
                vec4 bCol = flixel_texture2D(bitmap, bUV);
                
                float mainAlpha = gCol.a;
                
                if (mainAlpha <= 0.0) {
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
                } else {
                    float rMask = step(0.01, rCol.a);
                    float bMask = step(0.01, bCol.a);
                    vec3 finalRGB = vec3(rCol.r * rMask, gCol.g, bCol.b * bMask);
                    gl_FragColor = vec4(finalRGB, mainAlpha);
                }
            }
        ';
        
        var glitchShader:FlxRuntimeShader = new FlxRuntimeShader(shaderCode);
        game.variables.set('glitchShader', glitchShader);
        glitchShader.setFloat('amount', 0.0);
        glitchShader.setFloat('iTime', 0.0);

        var leftScroll:FlxBackdrop = new FlxBackdrop(Paths.image('text'), 0x10);
        leftScroll.cameras = [game.camHUD];
        leftScroll.alpha = 0;
        leftScroll.x = 0;
        leftScroll.shader = glitchShader;
        game.add(leftScroll);
        game.variables.set('leftScroll', leftScroll);

        var rightScroll:FlxBackdrop = new FlxBackdrop(Paths.image('text'), 0x10);
        rightScroll.cameras = [game.camHUD];
        rightScroll.alpha = 0;
        rightScroll.shader = glitchShader;
        game.add(rightScroll);
        game.variables.set('rightScroll', rightScroll);
    ]])
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    hitEffect()
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    hitEffect()
end

function hitEffect()
    setProperty('aaa.alpha', 0.4)
    doTweenAlpha('coolestaabro', 'aaa', 0, 0.1, 'linear')
    
    runHaxeCode([[
        var shader = game.variables.get('glitchShader');
        if (shader != null) {
            shader.setFloat('amount', 0.08);
        }
    ]])
end

function onBeatHit()
    if startEffect then
        setProperty('blackScareen.alpha', 0.5)
        doTweenAlpha('coolestbro', 'blackScareen', 0, 0.2, 'linear')
        
        if curBeat % 2 == 0 then
            runHaxeCode([[
                game.variables.get('leftScroll').velocity.y = 500;
                game.variables.get('rightScroll').velocity.y = -100;
            ]])
        else
            runHaxeCode([[
                game.variables.get('leftScroll').velocity.y = 100;
                game.variables.get('rightScroll').velocity.y = -500;
            ]])
        end
    end
end

function onMoveCamera(focus)
    if tsuka then
        if focus == 'dad' then
            setProperty('defaultCamZoom', 0.8)
        else
            setProperty('defaultCamZoom', 0.6)
        end
    end
end

function onUpdate(elapsed)
    elapsedTime = elapsedTime + elapsed
    
    if tsuka then
        setProperty('dad.y', -1100)
        setProperty('dad.x', 800)
        
        -- lock camera to dad while in tsuka mode
        if mustHitSection == false then
            local camPosX = getMidpointX('dad') - 150
            local camPosY = getMidpointY('dad') - 100
            setProperty('camFollow.x', camPosX)
            setProperty('camFollow.y', camPosY)
        end
    elseif curStep >= 142 and curStep < 927 then
        setProperty('dad.y', defaultOpponentY + (300 * math.sin(elapsedTime * 1)))
        setProperty('dad.x', defaultOpponentX + (300 * math.cos(elapsedTime * 1)))
    elseif curStep >= 928 and curStep < 1280 then
        setProperty('dad.x', defaultOpponentX + (300 * math.cos(elapsedTime * 4)))
    end
end

function onStepHit()
    if curStep == 127 then
        doTweenY('dadEntrance', 'dad', defaultOpponentY, 2, 'elasticOut')
        doTweenX('dadEntrance2', 'dad', defaultOpponentX, 2, 'elasticOut')
    end
    if curStep == 1558 then
        tsuka = true
        makeLuaSprite('e', nil, 0, 0)
        makeGraphic('e', screenWidth * 100, screenHeight * 100, '000000')
        setObjectCamera('e', 'camGame')
        screenCenter('e', 'xy')
        setProperty('e.alpha', 0.5)
        addLuaSprite('e', false)
    end
    if curStep == 2067 then
        makeLuaSprite('blackScreen', nil, 0, 0)
        makeGraphic('blackScreen', screenWidth * 3, screenHeight * 3, '000000')
        setObjectCamera('blackScreen', 'hud')
        screenCenter('blackScreen', 'xy')
        setProperty('blackScreen.alpha', 0)
        addLuaSprite('blackScreen', true)

        makeAnimatedLuaSprite('coolAnim', spriteName, 0, 0)
        addAnimationByPrefix('coolAnim', 'idle', 'idle', 10, false)
        setObjectCamera('coolAnim', 'hud')
        setProperty('coolAnim.alpha', 0)
        screenCenter('coolAnim', 'xy')
        addLuaSprite('coolAnim', true)
        setProperty('coolAnim.scale.y', 0.5)
        setProperty('coolAnim.scale.x', 0.5)
        
        doTweenAlpha('fadeBlack', 'blackScreen', 1, 0.1, 'linear')
        doTweenAlpha('fadeAnim', 'coolAnim', 1, 0.1, 'linear')
        
        startEffect = true
        runHaxeCode([[
            game.variables.get('leftScroll').alpha = 1;
            game.variables.get('rightScroll').alpha = 1;
            game.variables.get('rightScroll').x = FlxG.width - game.variables.get('rightScroll').width;
        ]])
    end
end

function onTweenCompleted(tag)
    if tag == 'fadeAnim' then
        playAnim('coolAnim', 'idle', true)
    end
    if tag == 'byeAnim' then
        removeLuaSprite('blackScreen', true)
        removeLuaSprite('coolAnim', true)
    end
end

function onUpdatePost(elapsed)
    runHaxeCode([[
        var shader = game.variables.get('glitchShader');
        if (shader != null) {
            shader.setFloat('iTime', shader.getFloat('iTime') + ]] .. elapsed .. [[);
            var cur = shader.getFloat('amount');
            if (cur > 0) {
                shader.setFloat('amount', cur - (]] .. elapsed .. [[ * 0.5));
            }
        }
    ]])

    if getProperty('coolAnim.animation.curAnim.finished') and getProperty('coolAnim.alpha') == 1 then
        doTweenAlpha('byeBlack', 'blackScreen', 0, 1, 'linear')
        doTweenAlpha('byeAnim', 'coolAnim', 0, 1, 'linear')
    end
end