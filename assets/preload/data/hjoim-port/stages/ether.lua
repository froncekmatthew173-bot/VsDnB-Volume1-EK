local scrollSpeed = 500
local sizeMult = 50
local screenW = 1280
local hacked = false

function onCreate()
	initLuaShader("Wavy")

	makeLuaSprite('bgLoop2', 'marb/starsbg', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 5, 720 * 5)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)
	setSpriteShader('bgLoop2', "Wavy")

	makeLuaSprite('bgLoop6', 'marb/mars', 0, -1000)
	setScrollFactor('bgLoop6', 0.2, 0.2)
	setGraphicSize('bgLoop6', 1280 * 2, 720 * 4)
	updateHitbox('bgLoop6')
	setProperty('bgLoop6.angle', 90)
	addLuaSprite('bgLoop6', false)
	
	makeLuaSprite('bgLoop3', 'marb/cubes', 0, 0)
	setScrollFactor('bgLoop3', 0, 0)
	setGraphicSize('bgLoop3', 1280 * 3, 720 * 3)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	
	makeLuaSprite('floora', 'marb/howardplatform', 700, 300)
	setScrollFactor('floora', 1, 1)
	setProperty('floora.scale.x', 2)
	setProperty('floora.scale.y', 2)
	addLuaSprite('floora', false)
	
	makeLuaSprite('floor', 'marb/bfplatform', 1500, 300)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 1.5)
	setProperty('floor.scale.y', 1.5)
	addLuaSprite('floor', false)
	
	makeAnimatedLuaSprite('idk', 'marb/howardthealien', getProperty('floora.x' ) - 150, getProperty('floora.y' ) - 400)
	addAnimationByPrefix('idk', 'idle', 'altidle', 24, false)
	addAnimationByPrefix('idk', 'dance1', 'dance1', 24, false)
	addAnimationByPrefix('idk', 'dancer', 'dancer', 24, false)
	objectPlayAnimation('idk', 'idle', true)
	setScrollFactor('idk', 1, 1)
	addLuaSprite('idk', false)
	setProperty('idk.scale.x', 1.5)
	setProperty('idk.scale.y', 1.5)
end

function onUpdate(elapsed)
	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.1)
	setShaderFloat('bgLoop3', 'uFrequency', 1)
	setShaderFloat('bgLoop3', 'uSpeed', 1)
end

function onBeatHit()
	if curBeat < 64 then
		if curBeat % 2 == 0 then 
			objectPlayAnimation('idk', 'idle', true)
		end
	else
		if curBeat % 2 == 0 then 
			setProperty('idk.flipX', false)
			objectPlayAnimation('idk', 'dancer', true)
		else
			setProperty('idk.flipX', true)
			objectPlayAnimation('idk', 'dancer', true)
		end
	end
end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop2', 'uTime', os.clock())
	setShaderFloat('bgLoop3', 'uTime', os.clock())
	setProperty('portal.angle', getProperty('portal.angle') + 0.1)
end