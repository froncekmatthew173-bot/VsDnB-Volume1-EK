function onCreatePost()
    if downscroll then
        setProperty('healthBar.y', -500)
    else
        setProperty('healthBar.y', 1000)
    end
end
