function onCreate()
    runHaxeCode([[
        var shaderCode:String = '
            #pragma header
            uniform float amount;
            void main()
            {
                vec2 uv = openfl_TextureCoordv;
                vec2 center = vec2(0.5, 0.5);
                
                float r = 0.0;
                float g = 0.0;
                float b = 0.0;
                float a = 0.0;

                for (float i = 0.0; i < 10.0; i++) {
                    float scaleR = 1.0 + (i * amount * 0.05);
                    float scaleG = 1.0 + (i * amount * 0.025);
                    float scaleB = 1.0;
                    
                    vec2 offsetR = (uv - center) * scaleR + center;
                    vec2 offsetG = (uv - center) * scaleG + center;
                    vec2 offsetB = (uv - center) * scaleB + center;
                    
                    r += flixel_texture2D(bitmap, clamp(offsetR, 0.0, 1.0)).r;
                    g += flixel_texture2D(bitmap, clamp(offsetG, 0.0, 1.0)).g;
                    b += flixel_texture2D(bitmap, clamp(offsetB, 0.0, 1.0)).b;
                    a += flixel_texture2D(bitmap, uv).a;
                }
                
                gl_FragColor = vec4(r / 10.0, g / 10.0, b / 10.0, a / 10.0);
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
            var curAmount:Float = shader.getFloat('amount');
            if (curAmount > 0) {
                var newValue:Float = curAmount - (]] .. elapsed .. [[ * 0.8);
                if (newValue < 0) newValue = 0;
                shader.setFloat('amount', newValue);
            }
        }
    ]])
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    runHaxeCode([[
        var shader = game.variables.get('zoomShader');
        if (shader != null) {
            shader.setFloat('amount', 0.15);
        }
    ]])
end