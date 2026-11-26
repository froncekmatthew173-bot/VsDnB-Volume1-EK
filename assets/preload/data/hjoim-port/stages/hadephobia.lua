

function onCreate()
	-- background shit
	makeLuaSprite('red', 'red', -5000, -5000);
	setLuaSpriteScrollFactor('red', 0, 0);
	scaleObject('red', 3, 3)
	addLuaSprite('red', false);
end


local shadname = "Wavy"

	function onCreatePost()
		initLuaShader("Wavy")
		setSpriteShader('red', shadname)
	end
	
	function onUpdate(elapsed)
	setShaderFloat('red', 'uWaveAmplitude', 0.1)
	setShaderFloat('red', 'uFrequency', 5)
	setShaderFloat('red', 'uSpeed', 2.25)
		end

	function onUpdatePost(elapsed)
    setProperty('defaultCamZoom', 0.2)
	setShaderFloat('red', 'uTime', os.clock())
	end