
local rescale = 1
function onCreate()
    	
	makeLuaSprite('cl', 'lib/white', -250, -600)
	setScrollFactor('cl', 0, 0)
	setProperty('cl.scale.x', 50)
	setProperty('cl.scale.y', 50)
	addLuaSprite('cl', false)
end
