function onCreate()
    runHaxeCode([[
        var shaderCode:String = '
            #pragma header
            uniform float amount;
            void main()
            {
                vec2 uv = openfl_TextureCoordv;
                vec2 center = vec2(0.5, 0.5);
                
                vec2 offset = (uv - center) * amount;
                
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
        
        var runtimeShader:FlxRuntimeShader = new FlxRuntimeShader(shaderCode);
        game.camGame.setFilters([new ShaderFilter(runtimeShader)]);
        game.camHUD.setFilters([new ShaderFilter(runtimeShader)]);
        game.variables.set('zoomShader', runtimeShader);
        runtimeShader.setFloat('amount', 0.0);
    ]])
end

function onUpdate(elapsed)
    runHaxeCode([[
        var shader = game.variables.get('zoomShader');
        if (shader != null) {
            var wave:Float = Math.sin(Conductor.songPosition / 150) * 0.02;
            var curAmount:Float = shader.getFloat('amount');
            
            if (curAmount > 0) {
                var newValue:Float = curAmount - (]] .. elapsed .. [[ * 0.8);
                if (newValue < 0) newValue = 0;
                shader.setFloat('amount', newValue + Math.abs(wave * 0.1));
            } else {
                shader.setFloat('amount', Math.abs(wave * 0.05));
            }
        }
    ]])
end

function onBeatHit()
    runHaxeCode([[
        var shader = game.variables.get('zoomShader');
        if (shader != null) {
            var bump:Float = 0.06;
            shader.setFloat('amount', bump);
        }
    ]])
end