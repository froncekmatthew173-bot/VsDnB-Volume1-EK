function onCreatePost()
    addHaxeLibrary('FlxRuntimeShader')
    
    runHaxeCode([[
        var shaderCode:String = '
            #pragma header
            uniform float amount;
            void main() {
                vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
                float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
                gl_FragColor = vec4(mix(color.rgb, vec3(gray), amount), color.a);
            }
        ';
        
        game.variables.set('grayShader', new FlxRuntimeShader(shaderCode));
        game.variables.get('grayShader').setFloat('amount', 0.0);
        
        game.camGame.setFilters([new openfl.filters.ShaderFilter(game.variables.get('grayShader'))]);
        game.camHUD.setFilters([new openfl.filters.ShaderFilter(game.variables.get('grayShader'))]);
    ]])

    makeLuaSprite('blackScreen', '', -200, -200)
    makeGraphic('blackScreen', screenWidth * 2, screenHeight * 2, '000000')
    setObjectCamera('blackScreen', 'other')
    setProperty('blackScreen.alpha', 0)
    addLuaSprite('blackScreen', true)
end

function onUpdate(elapsed)
    local songPos = getSongPosition()
    local startFade = songLength * 0.8
    
    if songPos >= startFade then
        local percent = (songPos - startFade) / (songLength - startFade)
        
        runHaxeCode([[
            game.variables.get('grayShader').setFloat('amount', ]] .. percent .. [[);
        ]])
        
        if percent > 0.6 then
            local darkAlpha = (percent - 0.6) / 0.4
            setProperty('blackScreen.alpha', darkAlpha)
        end
    end
end