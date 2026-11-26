local spriteName = 'stopfucking'
local startEffect = false
local tsuka = false

function onCreatePost()
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
    setProperty('aaa.alpha', 0.5)
    
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

function onBeatHit()
 
    runHaxeCode([[
        var shader = game.variables.get('glitchShader');
        if (shader != null) {
            shader.setFloat('amount', 0.08);
        }
    ]])

    if startEffect then
        if curBeat % 2 == 0 then
            setProperty('leftScroll.velocity.y', 500)
            setProperty('rightScroll.velocity.y', -100)
        else
            setProperty('leftScroll.velocity.y', 100)
            setProperty('rightScroll.velocity.y', -500)
        end
    end
end
