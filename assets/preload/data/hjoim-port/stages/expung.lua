local scrollSpeed = 250
local rescale = 2
local screenW = 1280
local hacked = false

function onCreate()
	initLuaShader("Wavy")
makeLuaSprite('bgLoop9', 'grad', 0, 0)
		setScrollFactor('bgLoop9', 0, 0)
		updateHitbox('bgLoop9')
		screenCenter('bgLoop9', 'xy')
		addLuaSprite('bgLoop9', true)
		setProperty('bgLoop9.scale.x', 5)
		setProperty('bgLoop9.scale.y', 5)
		setProperty('bgLoop9.color', getColorFromHex('FF0000'))
			setBlendMode('bgLoop9', 'add')
	
	if stringStartsWith(version, '0.6') then
		setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
	else
		setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', false)
	end

	makeLuaSprite('bgLoop2', 'red', 0, 0)
	setScrollFactor('bgLoop2', 0, 0)
	setGraphicSize('bgLoop2', 1280 * 2, 720 * 10)
	updateHitbox('bgLoop2')
	screenCenter('bgLoop2', 'xy')
	setProperty('bgLoop2.angle', 90)
	addLuaSprite('bgLoop2', false)

	runHaxeCode([[
		import flixel.addons.display.FlxBackdrop;

		var grid1:FlxBackdrop = new FlxBackdrop(Paths.image('textr'), 0x01);
		grid1.velocity.set(-]] .. scrollSpeed .. [[, 0);
		grid1.antialiasing = ClientPrefs.data.antialiasing;
		grid1.scrollFactor.set(0, 0);
		grid1.scale.set(]] .. rescale .. [[, ]] .. rescale .. [[);
		grid1.cameras = [game.camGame];
		game.variables.set('grid1', grid1);

		grid1.y = (720 / 2) - (grid1.height / 2);
		var pos:Int = game.members.indexOf(game.getLuaObject('bgLoop2'));
		game.insert(pos + 1, grid1);
	]])

	makeLuaSprite('bgLoop3', 'darktri', 0, 0)
	setScrollFactor('bgLoop3', 0, 0)
	setGraphicSize('bgLoop3', 1280 * 6, 720 * 6)
	updateHitbox('bgLoop3')
	screenCenter('bgLoop3', 'xy')
	addLuaSprite('bgLoop3', false)
	setSpriteShader('bgLoop3', "Wavy")
	
	makeLuaSprite('bgLoop15', 'triangles1', 0, 0)
	setScrollFactor('bgLoop15', 0, 0)
	setGraphicSize('bgLoop15', 1280 * 5, 720 * 5)
	updateHitbox('bgLoop15')
	screenCenter('bgLoop15', 'xy')
	addLuaSprite('bgLoop15', false)
	setSpriteShader('bgLoop15', "Wavy")
	



	makeLuaSprite('floor', 'UnfairGround', 0, -450)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 0.5)
	setProperty('floor.scale.y', 0.5)
	addLuaSprite('floor', false)
	
	setProperty('gf.alpha', 0)
	setProperty('gf.visible', false)
	removeLuaSprite('bgLoop5', true)
end

function onDestroy()
	if stringStartsWith(version, '0.6') then
		setPropertyFromClass('ClientPrefs', 'ghostTapping', true)
	else
		setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', true)
	end
end

function onStepHit()
	if curStep == 1412 then
		removeLuaSprite('bgLoop5', true)

	
		hacked = true
		makeLuaText('ghostText', 'GHOST TAPPING DISABLED', 0, 0, 0)
		setTextSize('ghostText', 80)
		setTextColor('ghostText', 'FF0000')
		setObjectCamera('ghostText', 'other')
		screenCenter('ghostText', 'xy')
		addLuaText('ghostText')
		
		setProperty('ghostText.acceleration.y', 500)
		runTimer('crushText', 0.5)
		
		if stringStartsWith(version, '0.6') then
			setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
		else
			setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', false)
		end
		
		runHaxeCode([[
			game.controls.setKeyboardScheme(Controls.KeyboardScheme.None); 
		]])

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
	if getProperty('ghostText.alpha') > 0 then
		setProperty('ghostText.x', (1280 / 2 - getProperty('ghostText.width') / 2) + math.random(-5, 5))
		setProperty('ghostText.y', (720 / 2 - getProperty('ghostText.height') / 2) + math.random(-5, 5))
	end

	setShaderFloat('bgLoop3', 'uWaveAmplitude', 0.01)
	setShaderFloat('bgLoop3', 'uFrequency', 0.5)
	setShaderFloat('bgLoop3', 'uSpeed', 2)

	setShaderFloat('bgLoop15', 'uWaveAmplitude', 0.02)
	setShaderFloat('bgLoop15', 'uFrequency', 1)
	setShaderFloat('bgLoop15', 'uSpeed', 2)

	setProperty("defaultCamZoom", 0.3)
	removeLuaSprite('bgLoop5', true)
end

function onUpdatePost(elapsed)
	setShaderFloat('bgLoop3', 'uTime', os.clock())
		setShaderFloat('bgLoop15', 'uTime', os.clock())
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'crushText' then
		doTweenY('squashY', 'ghostText.scale', 0, 0.3, 'expoIn')
		doTweenX('stretchX', 'ghostText.scale', 2, 0.3, 'expoIn')
		doTweenAlpha('byeText', 'ghostText', 0, 0.3, 'linear')
	end
end

function onTweenCompleted(tag)
	if tag == 'byeText' then
		removeLuaText('ghostText', true)
	end
end