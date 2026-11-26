local elapsedTime = 0

function onUpdatePost(elapsed)
	elapsedTime = elapsedTime + elapsed
	setCharacterY("dad", defaultOpponentY + (250 * math.sin(elapsedTime)))
	setCharacterX("dad", defaultOpponentX + (250 * math.cos(elapsedTime)))
end