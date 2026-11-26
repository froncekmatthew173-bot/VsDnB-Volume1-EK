function onUpdatePost(elapsed)
    setProperty('cameraSpeed', 0.2)
    runHaxeCode([[
        if (game.variables.get("alaskashadertungsahur") == null) {
            var alaskashadertungsahurCode:String = "
                #pragma header
                uniform float whiteIntensity;
                uniform float blueIntensity;
                uniform float bloomGlow;

                void main() {
                    vec2 uv = openfl_TextureCoordv;
                    vec4 color = flixel_texture2D(bitmap, uv);
                    
                    vec3 white = vec3(1.0, 1.0, 1.0);
                    vec3 blue = vec3(0.6, 0.8, 1.0);
                    
                    vec3 base = mix(color.rgb, white, whiteIntensity);
                    vec3 withBlue = mix(base, blue, blueIntensity);
                    
                    float luminance = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
                    vec3 glow = white * luminance * bloomGlow;
                    
                    gl_FragColor = vec4(withBlue + glow, color.a);
                }
            ";
            var shader = new FlxRuntimeShader(alaskashadertungsahurCode);
            shader.setFloat("whiteIntensity", 0.2);
            shader.setFloat("blueIntensity", 0.2);
            shader.setFloat("bloomGlow", 0.1);
            game.variables.set("alaskashadertungsahur", new ShaderFilter(shader));
        }

        var filter = game.variables.get("alaskashadertungsahur");
        if (game.camGame.filters == null) {
            game.camGame.filters = [filter];
        } else {
            var hasShader:Bool = false;
            for (f in game.camGame.filters) {
                if (f == filter) {
                    hasShader = true;
                    break;
                }
            }
            if (!hasShader) {
                game.camGame.filters.push(filter);
            }
        }
    ]])
end