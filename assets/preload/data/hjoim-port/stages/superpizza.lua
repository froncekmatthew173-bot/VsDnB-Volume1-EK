local rescale = 1
function onCreate()
    makeLuaSprite('hills', 'DORT/outdoorNear0', -400, -900)
	setScrollFactor('hills', 0.5, 1)
	setProperty('hills.scale.x', 1)
	setProperty('hills.scale.y', 1)
	addLuaSprite('hills', false)
	
	makeLuaSprite('floor', 'DORT/indoor', -700, -400)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 1.2)
	setProperty('floor.scale.y', 1.2)
	addLuaSprite('floor', false)

	runHaxeCode([[
		import flixel.addons.display.FlxBackdrop;

		var grid2:FlxBackdrop = new FlxBackdrop(Paths.image('DORT/outdoorFar0'), 0x01);
		grid2.velocity.set(100, 1);
		grid2.antialiasing = ClientPrefs.data.antialiasing;
		grid2.scrollFactor.set(1, 1);
		grid2.scale.set(]] .. rescale .. [[, ]] .. rescale .. [[);
		grid2.cameras = [game.camGame];
		grid2.x = 0;
		grid2.y = -900;
		game.variables.set('grid2', grid2);

		var pos:Int = game.members.indexOf(game.getLuaObject('hills'));
		game.insert(pos, grid2);
	]])
end