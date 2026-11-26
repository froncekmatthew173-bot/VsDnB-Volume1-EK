local scrollSpeed = 500
local sizeMult = 10
local screenW = 1280
local hacked = false

function onCreate()
initLuaShader("Wavy")
	
-- background color 'red' sprite first
	    makeLuaSprite('b', nil, 0, 0)
		setScrollFactor('b', 0, 0)
        makeGraphic('b', screenWidth * 10, screenHeight * 10, 'FFFFFF')
        setObjectCamera('b', 'camGame')
        screenCenter('b', 'xy')
        setProperty('b.alpha', 1)
        addLuaSprite('b', true)

	-- background color 'red' sprite first
	makeLuaSprite('bgLoop2', 'white', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)
	
		makeLuaSprite('bgLoop35', 'oppobackcubes', 0, 0)
	setScrollFactor('bgLoop35', 0, 0)
	setGraphicSize('bgLoop35', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop35')
	screenCenter('bgLoop35', 'xy')
	addLuaSprite('bgLoop35', false)
	setSpriteShader('bgLoop35', "Wavy")



makeLuaSprite('bgLoop6', 'wtfisthisthing', 0, 0)
	setScrollFactor('bgLoop6', 0, 0)
	setGraphicSize('bgLoop6', 1280 * 2, 720 * 10)
	updateHitbox('bgLoop6')
	screenCenter('bgLoop6', 'xy')
	setProperty('bgLoop6.angle', 90)
	addLuaSprite('bgLoop6', false)
	setSpriteShader('bgLoop6', "Wavy")
	
	-- red grid 1 infinite scroll
	makeLuaSprite('grid1', 'textw', 0, 0)
	setScrollFactor('grid1', 0, 0)
	setGraphicSize('grid1', screenW * sizeMult, 720 * sizeMult)
	updateHitbox('grid1')
	screenCenter('grid1', 'y')
	addLuaSprite('grid1', false)

	-- red grid 2 infinite scroll
	makeLuaSprite('grid2', 'textw', screenW * sizeMult, 0)
	setScrollFactor('grid2', 0, 0)
	setGraphicSize('grid2', screenW * sizeMult, 720 * sizeMult)
	updateHitbox('grid2')
	screenCenter('grid2', 'y')
	addLuaSprite('grid2', false)

	-- darktri background with wavy shader
	makeLuaSprite('bgLoop3', 'cubescum', 0, 0)
	setScrollFactor('bgLoop3', 0, 0)
	setGraphicSize('bgLoop3', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	

	-- unfair ground
	makeLuaSprite('floor', 'OppoGround', 0, -100)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 0.5)
	setProperty('floor.scale.y', 0.5)
	addLuaSprite('floor', false)
	setObjectOrder('floor', 20)
	setObjectOrder('boyfriend', 50)
	
	setProperty('gf.alpha', 0)
	setProperty('gf.visible', false)
	
	setProperty('floor.color', getColorFromHex('000000'))

	-- UNIVERSAL RED BLOOM HAXE

	
		makeLuaSprite('bgLoop5', 'grad', 0, 0)
	setScrollFactor('bgLoop5', 1, 1)
	updateHitbox('bgLoop5')
	addLuaSprite('bgLoop5', false)
	setObjectCamera('bgLoop5', 'hud')
	setProperty('bgLoop5.scale.x', 1.6)
	setProperty('bgLoop5.scale.y', 1.6)
	setBlendMode('bgLoop5', 'add')
end

function onStepHit()
if curStep == 120 then
        doTweenAlpha('bahhh', 'b', 0, 1, 'linear')
		setProperty('floor.color', getColorFromHex('FFFFFF'))

if curStep == 1558 then
setCharacterY('dad', -380)
setCharacterX('dad', 1320)
end
end
end
function onUpdate(elapsed)
setObjectOrder('boyfriend', 50)
	setProperty('gf.visible', false)

 

	-- cubes wavy
	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.2)
	setShaderFloat('bgLoop3', 'uFrequency', 60)
	setShaderFloat('bgLoop3', 'uSpeed', 3)
	-- dad hover)
	
	
	-- red grid infinite loop
	local w = screenW * sizeMult
	setProperty('grid1.x', getProperty('grid1.x') - (scrollSpeed * elapsed))
	setProperty('grid2.x', getProperty('grid2.x') - (scrollSpeed * elapsed))
	if getProperty('grid1.x') <= -w then setProperty('grid1.x', getProperty('grid2.x') + w) end
	if getProperty('grid2.x') <= -w then setProperty('grid2.x', getProperty('grid1.x') + w) end
end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop3', 'uTime', os.clock())
        setProperty('iconP2.angle', math.random(-1, 1))
		    local step = (songPos / 1000) * (bpm / 15)

    if step >= 1558 then
        setProperty('iconP2.angle', math.random(-2, 2))
    end
    end
	
	