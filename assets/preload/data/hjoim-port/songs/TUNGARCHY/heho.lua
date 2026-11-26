function onUpdatePost(elapsed)
	for i = 0, getProperty('notes.length') - 1 do
		if getPropertyFromGroup('notes', i, 'noAnimation') == true then
			setPropertyFromGroup('notes', i, 'visible', false)
		end
	end
end

function onUpdate(elapsed)
	for i = 0, getProperty('unspawnNotes.length') - 1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noAnimation') == true then
			setPropertyFromGroup('unspawnNotes', i, 'visible', false)
		end
	end
end