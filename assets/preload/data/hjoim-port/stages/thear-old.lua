local scrollSpeed = 250
local sizeMult = 10
local screenW = 1280
local hacked = false

function onCreate()
initLuaShader("Wavy")
	
		    makeLuaSprite('b', nil, 0, 0)
		setScrollFactor('b', 0, 0)
        makeGraphic('b', screenWidth * 10, screenHeight * 10, 'FFFFFF')
        setObjectCamera('b', 'camGame')
        screenCenter('b', 'xy')
        setProperty('b.alpha', 1)
        addLuaSprite('b', true)
		
			setObjectOrder('boyfriend', 50)


	-- background color 'red' sprite first
	makeLuaSprite('bgLoop2', 'bgoldlol', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)
	
	-- background color 'red' sprite firs

	-- red grid 1 infinite scroll
	makeLuaSprite('grid1', 'textold', 0, 0)
	setScrollFactor('grid1', 0, 0)
	setGraphicSize('grid1', screenW * sizeMult, 720 * sizeMult)
	updateHitbox('grid1')
	screenCenter('grid1', 'y')
	addLuaSprite('grid1', false)

	-- red grid 2 infinite scroll
	makeLuaSprite('grid2', 'textold', screenW * sizeMult, 0)
	setScrollFactor('grid2', 0, 0)
	setGraphicSize('grid2', screenW * sizeMult, 720 * sizeMult)
	updateHitbox('grid2')
	screenCenter('grid2', 'y')
	addLuaSprite('grid2', false)


	
	-- darktri background with wavy shader
	makeLuaSprite('bgLoop3', 'cubesoldlol', 0, 0)
	setScrollFactor('bgLoop3', 1, 1)
	setGraphicSize('bgLoop3', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	

	-- unfair ground
	makeLuaSprite('floor', 'gro', 1000, -100)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 0.5)
	setProperty('floor.scale.y', 0.5)
	addLuaSprite('floor', true)
		setObjectOrder('boyfriend', 50)
	setProperty('gf.alpha', 0)
	setProperty('gf.visible', false)
	
end

function onStepHit()
if curStep == 111 then
        doTweenAlpha('bahhh', 'b', 0, 3, 'linear')
end
end

function onUpdate(elapsed)
	setObjectOrder('boyfriend', 50)
	setProperty('gf.visible', false)

    -- FORCING the text every frame so the engine can't change it back
    if hacked then
        setTextString('scoreTxt', "GHOST TAPPING DISABLED")
        setTextString('timeTxt', "GHOST TAPPING DISABLED")
    end


	-- cubes wavy
	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.08)
	setShaderFloat('bgLoop3', 'uFrequency', 0.8)
	setShaderFloat('bgLoop3', 'uSpeed', 1)

	-- dad hover
	local songPos = getSongPosition()
	local currentBeat = (songPos / 500) * (curBpm / 100)
	setCharacterX('dad', -1000)
	setProperty('dad.y', getProperty('dad.y') + (math.cos(currentBeat) * 5))
	
	setProperty("defaultCamZoom", 0.3)
	
	-- red grid infinite loop
	local w = screenW * sizeMult
	setProperty('grid1.x', getProperty('grid1.x') - (scrollSpeed * elapsed))
	setProperty('grid2.x', getProperty('grid2.x') - (scrollSpeed * elapsed))
	if getProperty('grid1.x') <= -w then setProperty('grid1.x', getProperty('grid2.x') + w) end
	if getProperty('grid2.x') <= -w then setProperty('grid2.x', getProperty('grid1.x') + w) end
end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop3', 'uTime', os.clock())
end