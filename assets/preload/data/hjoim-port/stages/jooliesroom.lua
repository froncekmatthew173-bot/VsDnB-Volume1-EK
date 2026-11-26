
function onCreate()
	makeLuaSprite('floor', 'Golden/bg_joold', -1000, -2200)
	setScrollFactor('floor', 1, 1)
	setProperty('floor.scale.x', 0.7)
	setProperty('floor.scale.y', 0.7)
	addLuaSprite('floor', false)
end