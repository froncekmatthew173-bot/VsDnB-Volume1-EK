local scrollSpeed = 500
local sizeMult = 50
local screenW = 1280
local hacked = false

function onCreate()
initLuaShader("Wavy")
	
-- background color 'red' sprite first
	

	-- background color 'red' sprite first
	makeLuaSprite('bgLoop2', 'Golden/GoldenClouds', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 5, 720 * 5)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)
		setSpriteShader('bgLoop2', "Wavy")


makeLuaSprite('bgLoop6', 'Golden/CubesGolden', 0, 0)
	setScrollFactor('bgLoop6', 0, 0)
	setGraphicSize('bgLoop6', 1280 * 3, 720 * 5)
	updateHitbox('bgLoop6')
	screenCenter('bgLoop6', 'xy')
	setProperty('bgLoop6.angle', 90)
	addLuaSprite('bgLoop6', false)
	setSpriteShader('bgLoop6', "Wavy")
	
	-- red grid 1 infinite scroll
	-- darktri background with wavy shader
	makeLuaSprite('bgLoop3', 'Golden/TrianglesGolden', 0, 0)
	setScrollFactor('bgLoop3', 0, 0)
	setGraphicSize('bgLoop3', 1280 * 3, 720 * 3)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	
	-- unfair ground
	makeLuaSprite('floor', 'golden/platform', 1400, 50)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 1)
	setProperty('floor.scale.y', 1)
	addLuaSprite('floor', false)
	
	setProperty('gf.flipX', false)

	
end

function onUpdate(elapsed)


	-- cubes wavy
	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.1)
	setShaderFloat('bgLoop3', 'uFrequency', 1)
	setShaderFloat('bgLoop3', 'uSpeed', 1)
	-- dad hover)
	setProperty('gf.flipX', false)

end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop2', 'uTime', os.clock())
	setShaderFloat('bgLoop3', 'uTime', os.clock())
end
