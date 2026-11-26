function onStartCountdown()
	if not allowCountdown then
		endLuaScript()
		return Function_Continue
	end
	if not allowCountdown then
		allowCountdown = true
		startCountdown()
		return Function_Stop
	end
	return Function_Continue
end

function onCreate()
	setProperty('skipCountdown', true)
end