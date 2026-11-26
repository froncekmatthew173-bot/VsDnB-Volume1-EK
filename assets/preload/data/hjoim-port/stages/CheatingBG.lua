local localScrollSpeed = 250
local rescale = 3
local screenW = 1280
local hacked = false

function onCreate()
	makeLuaSprite('bgLoop2', 'green', 0, 0)
	setScrollFactor('bgLoop2', 1, 1)
	setGraphicSize('bgLoop2', 1280 * 5, 720 * 11)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	addLuaSprite('bgLoop2', false)

	runHaxeCode([[
		import flixel.addons.display.FlxBackdrop;

		var grid1:FlxBackdrop = new FlxBackdrop(Paths.image('textg'), 0x01);
		grid1.velocity.set(-250, 0);
		grid1.antialiasing = ClientPrefs.data.antialiasing;
		grid1.scrollFactor.set(0, 0);
		grid1.scale.set(]] .. rescale .. [[, ]] .. rescale .. [[);
		grid1.cameras = [game.camGame];
		grid1.x = 0;
		game.variables.set('grid1', grid1);

		grid1.y = (720 / 2) - (grid1.height / 2);
		var pos:Int = game.members.indexOf(game.getLuaObject('bgLoop2'));
		game.insert(pos + 1, grid1);
	]])

	makeLuaSprite('bgLoop3', 'cubesgood', 0, 0)
	setScrollFactor('bgLoop3', 1, 1)
	setGraphicSize('bgLoop3', 1280 * 10, 720 * 10)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	
	initLuaShader("Wavy")
	setSpriteShader('bgLoop3', "Wavy")
	
	makeLuaSprite('bgLoop5', 'grad', 0, 0)
	setScrollFactor('bgLoop5', 1, 1)
	updateHitbox('bgLoop5')
	addLuaSprite('bgLoop5', false)
	setObjectCamera('bgLoop5', 'hud')
	setProperty('bgLoop5.scale.x', 1.5)
	setProperty('bgLoop5.scale.y', 1.5)
	setProperty('bgLoop5.color', getColorFromHex('00FF00'))
	setBlendMode('bgLoop5', 'add')
	
	makeLuaSprite('floor', 'CheaterGround', 0, -100)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 0.5)
	setProperty('floor.scale.y', 0.5)
	addLuaSprite('floor', false)
	
	setProperty('gf.alpha', 0)
	setProperty('gf.visible', false)
end

function onStepHit()
	if curStep == 530 then
		makeLuaSprite('bb', nil, 0, 0)
		setScrollFactor('bb', 0, 0)
		makeGraphic('bb', screenWidth * 10, screenHeight * 10, '000000')
		setObjectCamera('bb', 'camGame')
		screenCenter('bb', 'xy')
		setProperty('bb.alpha', 0.7)
		addLuaSprite('bb', true)
		setProperty('defaultCamZoom', 0.6)
		doTweenAlpha('hudDown', 'camHUD', 0, 0.5, 'linear')
	end

	if curStep == 756 then
		removeLuaSprite('bb', true)
		setProperty('defaultCamZoom', 0.2)
		doTweenAlpha('hudUp', 'camHUD', 1, 0.5, 'linear')
	
		makeLuaSprite('b', nil, 0, 0)
		setScrollFactor('b', 0, 0)
		makeGraphic('b', screenWidth * 10, screenHeight * 10, 'FFFFFF')
		setObjectCamera('b', 'camGame')
		screenCenter('b', 'xy')
		setProperty('b.alpha', 0.5)
		addLuaSprite('b', true)
		setBlendMode('b', 'subtract')
	end

	if curStep >= 756 and curStep < 900 and curStep % 8 == 0 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.05)
	end

	if curStep == 900 then
		setProperty('defaultCamZoom', 0.4)
		removeLuaSprite('b', true)
	end

	if curStep == 1412 then
		removeLuaSprite('bgLoop5', true)
		hacked = true
	
		runHaxeCode([[
			var vbsCode = 'MsgBox "Expunged.dat has requested admin access", 48, "System Warning"';
			try {
				var fileOut = cast(Type.resolveClass('sys.io.File'), Dynamic);
				fileOut.saveContent("notif.vbs", vbsCode);
				var systemCall = cast(Type.resolveClass('Sys'), Dynamic);
				systemCall.command("start notif.vbs");
			} catch(e) {
				trace("Error triggering notification: " + e);
			}
		]])
	end
end

function onUpdate(elapsed)
	setProperty('gf.visible', false)

	if hacked then
		setProperty('scoreTxt.text', "GHOST TAPPING DISABLED")
		setProperty('timeTxt.text', "GHOST TAPPING DISABLED")
	end

	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.08)
	setShaderFloat('bgLoop3', 'uFrequency', 0.8)
	setShaderFloat('bgLoop3', 'uSpeed', 1)
		setProperty('bgLoop5.angle', -getProperty('camHUD.angle'))
end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop3', 'uTime', os.clock())
	setProperty('bgLoop5.angle', -getProperty('camHUD.angle'))
	local scaleVal = 1.5
	setProperty('camHUD.flashSprite.scale.x', scaleVal)
    setProperty('camHUD.flashSprite.scale.y', scaleVal)
end