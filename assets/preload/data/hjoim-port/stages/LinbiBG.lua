
local rescale = 1
function onCreate()
    	
	makeLuaSprite('cl', 'lib/sky', -250, -600)
	setScrollFactor('cl', 0, 0)
	setProperty('cl.scale.x', 2)
	setProperty('cl.scale.y', 2)
	addLuaSprite('cl', false)
	
	
	runHaxeCode([[
		import flixel.addons.display.FlxBackdrop;

		var grid2:FlxBackdrop = new FlxBackdrop(Paths.image('lib/clouds'), 0x01);
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
	
    makeLuaSprite('hills', 'lib/white', -400, -150)
	setScrollFactor('hills', 0.5, 0.5)
	setProperty('hills.scale.x', 1)
	setProperty('hills.scale.y', 1)
	addLuaSprite('hills', false)
	
	    makeLuaSprite('g', 'lib/hills', -200, -100)
	setScrollFactor('g', 0.8, 0.8)
	setProperty('g.scale.x', 1)
	setProperty('g.scale.y', 1)
	addLuaSprite('g', false)

	
	makeLuaSprite('floor', 'lib/main', -0, -500)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 1.2)
	setProperty('floor.scale.y', 1.2)
	addLuaSprite('floor', false)

    makeLuaSprite('cleE', 'lib/linbibgouter', -0, -0)
	setScrollFactor('cleE', 1, 1)
	setProperty('cleE.scale.x', 1)
	setProperty('cleE.scale.y', 1)
	setObjectCamera('cleE', 'hud')
	addLuaSprite('cleE', false)
end
