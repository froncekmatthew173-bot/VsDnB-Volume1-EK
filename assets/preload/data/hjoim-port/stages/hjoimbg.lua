local scrollSpeed = 500
local sizeMult = 50
local screenW = 1280
local hacked = false

function onCreate()
initLuaShader("Wavy")
	
-- background color 'red' sprite first
	

	-- background color 'red' sprite first
	makeLuaSprite('bgLoop2', 'M/sky', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 5, 720 * 5)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)
		setSpriteShader('bgLoop2', "Wavy")


makeLuaSprite('bgLoop6', 'M/whowannaplaytictactoe', 0, 0)
	setScrollFactor('bgLoop6', 0, 0)
	setGraphicSize('bgLoop6', 1280 * 2, 720 * 10)
	updateHitbox('bgLoop6')
	screenCenter('bgLoop6', 'xy')
	setProperty('bgLoop6.angle', 90)
	addLuaSprite('bgLoop6', false)
	setSpriteShader('bgLoop6', "Wavy")
	
	-- red grid 1 infinite scroll
	-- darktri background with wavy shader
	makeLuaSprite('bgLoop3', 'M/whowannaplaytictactoe', 0, 0)
	setScrollFactor('bgLoop3', 0, 0)
	setGraphicSize('bgLoop3', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	
		makeLuaSprite('portal', 'M/weeeportal', 0, -1000)
	setScrollFactor('portal', 0.2, 0.2)
	setProperty('portal.scale.x', 1)
	setProperty('portal.scale.y', 1)
	addLuaSprite('portal', false)

	-- unfair ground
	makeLuaSprite('floor', 'M/BlackPlatform', 500, -100)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 0.9)
	setProperty('floor.scale.y', 0.9)
	addLuaSprite('floor', false)
	
	
	makeLuaSprite('pat', 'M/island_p', -100, -500)
	setScrollFactor('pat', 0.5, 0.5)
	setProperty('pat.scale.x', 0.9)
	setProperty('pat.scale.y', 0.9)
	addLuaSprite('pat', false)
	
	makeLuaSprite('pas', 'M/island_s', 1000, -1000)
	setScrollFactor('pas', 0.8, 0.8)
	setProperty('pas.scale.x', 0.9)
	setProperty('pas.scale.y', 0.9)
	addLuaSprite('pas', false)
	
	makeLuaSprite('pab', 'M/island_b', -500, -700)
	setScrollFactor('pab', 0.3, 0.3)
	setProperty('pab.scale.x', 0.9)
	setProperty('pab.scale.y', 0.9)
	addLuaSprite('pab', false)
	
	setProperty('gf.alpha', 0)
	setProperty('gf.visible', false)
	
end

function onUpdate(elapsed)
	setProperty('gf.visible', false)


	-- cubes wavy
	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.1)
	setShaderFloat('bgLoop3', 'uFrequency', 1)
	setShaderFloat('bgLoop3', 'uSpeed', 1)
	-- dad hover)
	

end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop2', 'uTime', os.clock())
	setShaderFloat('bgLoop3', 'uTime', os.clock())
	setProperty('portal.angle', getProperty('portal.angle') + 0.1)
end
