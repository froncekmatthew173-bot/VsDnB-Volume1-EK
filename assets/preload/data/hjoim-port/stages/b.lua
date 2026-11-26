
local rescale = 1
function onCreate()
    	
		runHaxeCode([[
		import flixel.addons.display.FlxBackdrop;

		var grid1:FlxBackdrop = new FlxBackdrop(Paths.image('B/Gradient'), 0x01);
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
	
	
	runHaxeCode([[
		import flixel.addons.display.FlxBackdrop;

		var grid2:FlxBackdrop = new FlxBackdrop(Paths.image('B/cloudsyay'), 0x01);
		grid2.velocity.set(100, 1);
		grid2.antialiasing = ClientPrefs.data.antialiasing;
		grid2.scrollFactor.set(1, 1);
		grid2.scale.set(]] .. rescale .. [[, ]] .. rescale .. [[);
		grid2.cameras = [game.camGame];
		grid2.x = 0;
		grid2.y = -320;
		game.variables.set('grid2', grid2);

		var pos:Int = game.members.indexOf(game.getLuaObject('bgLoop2'));
		game.insert(pos + 2, grid2);
	]])
	
    makeLuaSprite('hills', 'B/hills', -400, -100)
	setScrollFactor('hills', 0.5, 0.5)
	setProperty('hills.scale.x', 1)
	setProperty('hills.scale.y', 1)
	addLuaSprite('hills', false)
	
	makeLuaSprite('floor', 'B/housepart', -400, -500)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 1.2)
	setProperty('floor.scale.y', 1.2)
	addLuaSprite('floor', false)

	

	
	
	makeAnimatedLuaSprite('Jaarlid', 'B/Jaarlid', -400, -200)
	addAnimationByPrefix('Jaarlid', 'idle', 'Guy1', 24, false)
	setScrollFactor('Jaarlid', 1, 1)
	setProperty('Jaarlid.scale.x', 1)
	setProperty('Jaarlid.scale.y', 1)
	addLuaSprite('Jaarlid', false)
	
	makeAnimatedLuaSprite('jim', 'B/Jimmmy', 1200, -200)
	addAnimationByPrefix('jim', 'idle', 'Guy2', 24, false)
	setScrollFactor('jim', 1, 1)
	setProperty('jim.scale.x', 1)
	setProperty('jim.scale.y', 1)
	addLuaSprite('jim', false)
end

function onBeatHit()
if curBeat % 2 == 0 then
objectPlayAnimation('Jaarlid', 'idle', true)
objectPlayAnimation('jim', 'idle', true)
end
end