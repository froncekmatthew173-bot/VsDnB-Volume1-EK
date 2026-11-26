local rescale = 1
function onCreate()
    makeLuaSprite('hills', 'bgref', 150, -300)
	setScrollFactor('hills', 1, 1)
	setProperty('hills.scale.x', 3)
	setProperty('hills.scale.y', 3)
	addLuaSprite('hills', false)
end