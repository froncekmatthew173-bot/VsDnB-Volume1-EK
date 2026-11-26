local scrollSpeed = 500
local sizeMult = 50
local screenW = 1280
local hacked = false

function onCreate()
initLuaShader("Wavy")
	
-- background color 'red' sprite first
	

	-- background color 'red' sprite first
	makeLuaSprite('bgLoop2', 'basyl/basyl_bg3', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 5, 720 * 5)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)
		setSpriteShader('bgLoop2', "Wavy")


makeLuaSprite('bgLoop6', 'basyl/basyl_bg2', 0, -0)
	setScrollFactor('bgLoop6', 0.2, 0.2)
	setGraphicSize('bgLoop6', 1280 * 2, 720 * 4)
	updateHitbox('bgLoop6')
	setProperty('bgLoop6.angle', 90)
	addLuaSprite('bgLoop6', false)
		setSpriteShader('bgLoop6', "Wavy")
	screenCenter('bgLoop6', 'xy')
	-- red grid 1 infinite scroll
	-- darktri background with wavy shader
	makeLuaSprite('bgLoop3', 'basyl/clouds', 0, 0)
	setScrollFactor('bgLoop3', 0, 0)
	setGraphicSize('bgLoop3', 1280 * 3, 720 * 3)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	
	-- unfair ground
	makeLuaSprite('floor', 'basyl/cloudplatform', 1600, 400)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 5)
	setProperty('floor.scale.y', 5)
	addLuaSprite('floor', false)
	

	
end

function onUpdate(elapsed)


	-- cubes wavy
	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.1)
	setShaderFloat('bgLoop3', 'uFrequency', 50)
	setShaderFloat('bgLoop3', 'uSpeed', 5)
	-- dad hover)
	
	

end

function onBeatHit()
if curBeat % 2 == 0 then 
setProperty('idk.flipX', false)
objectPlayAnimation('idk', 'dancer', true)
else
setProperty('idk.flipX', true)
objectPlayAnimation('idk', 'dancer', true)
end
end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop2', 'uTime', os.clock())
	setShaderFloat('bgLoop3', 'uTime', os.clock())
    setShaderFloat('bgLoop6', 'uTime', os.clock())
	setProperty('portal.angle', getProperty('portal.angle') + 0.1)
end
