function onCreatePost()
    runHaxeCode([[
        var shaderCode:String = '
            #pragma header

            uniform float iTime;

            const float PI = 3.14159265;
            float wobble_intensity = 0.002;
            float grade_intensity = 0.5;
            float vignette_intensity = 0.2;

            float rand(vec2 co){
                return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
            }

            void main()
            {
                vec2 uv = openfl_TextureCoordv;
                
                vec2 p = uv * 2.0 - 1.0;
                float r = length(p);
                float theta = atan(p.y, p.x);
                float rf = pow(r, 1.2); 
                vec2 bentuv = vec2(rf * cos(theta), rf * sin(theta));
                uv = (bentuv + 1.0) * 0.5;
                
                float r_val = rand(vec2(iTime, uv.y));
                vec2 wobbl = vec2(wobble_intensity * r_val, 0.0);
                float t_val = tan(0.25 * iTime + uv.y * PI * 0.67);
                vec2 tan_off = vec2(wobbl.x * min(0.0, t_val), 0.0);
                
                vec4 baseCol = flixel_texture2D(bitmap, uv + tan_off);
                vec4 color1 = flixel_texture2D(bitmap, uv + wobbl + tan_off);
                vec4 color2 = flixel_texture2D(bitmap, (uv + (wobbl * 1.5) + (tan_off * 1.3)) * 1.001);
                
                vec3 colorRGB = vec3(color2.r, color2.g, pow(max(0.0, color1.b), 0.67));
                colorRGB = mix(baseCol.rgb, colorRGB, grade_intensity);
                
                float s_val = ((sin(2.0 * PI * uv.y + iTime * 20.0) + sin(2.0 * PI * uv.y)) / 2.0) * 0.015 * sin(iTime);
                colorRGB += s_val;
                
                float gray = dot(colorRGB, vec3(0.299, 0.587, 0.114));
                colorRGB = vec3(gray);
                
                float vig = 1.0 - sin(PI * uv.x) * sin(PI * uv.y);
                colorRGB -= (vig * vignette_intensity);
                
                gl_FragColor = vec4(colorRGB, baseCol.a);
            }
        ';

        var runtimeShader:FlxRuntimeShader = new FlxRuntimeShader(shaderCode);
        game.variables.set('vhs_shader', runtimeShader);
    ]])
end

function onStepHit()
    if curStep == 768 then
        runHaxeCode([[
            var shader = game.variables.get('vhs_shader');
            var filter = new ShaderFilter(shader);
            game.camGame.setFilters([filter]);
            game.camHUD.setFilters([filter]);
            game.camOther.setFilters([filter]);
        ]])
    end

    if curStep == 895 then
        runHaxeCode([[
            game.camGame.setFilters([]);
            game.camHUD.setFilters([]);
            game.camOther.setFilters([]);
        ]])
    end
end

function onUpdate(elapsed)
    if curStep >= 768 and curStep < 895 then
        runHaxeCode([[
            var shader = game.variables.get('vhs_shader');
            if (shader != null) {
                shader.setFloat('iTime', Conductor.songPosition / 1000);
            }
        ]])
    end
end