local Credits = {}

scrollY = 80
text = ""
creditsImage = love.graphics.newCanvas()

Credits.init = function()
    love.graphics.setFont(_font)
    love.graphics.setCanvas(creditsImage)

    local offsetY = 0
    local lineHeight = 7
    local colorSwitch = false
    for line in love.filesystem.lines("assets/data/credits.txt") do
        if line ~= "===" then
            love.graphics.printf(line, 0, offsetY * lineHeight, 80, "center")
            offsetY = offsetY + 1
        else
            if colorSwitch then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(99 / 255, 199 / 255, 77 / 255)
            end
            colorSwitch = not colorSwitch
        end
    end

    love.graphics.setCanvas()
end

Credits.enter = function()
    love.graphics.setFont(_font)

    scrollY = 80
end

Credits.update = function()
    scrollY = scrollY - 0.2

    if (scrollY * -1) > creditsImage:getHeight() - 80 then
        if Credits.endGame then
            love.event.quit()
        else
            Gamestate.switch(Menu)
        end
    end

    lb.update()
end

Credits.keypressed = function(keycode, key)
    if Credits.endGame then
        love.event.quit()
    else
        Gamestate.switch(Menu)
    end
end

Credits.draw = function()
    love.graphics.push()
    love.graphics.scale(5, 5)

    love.graphics.draw(creditsImage, 0, scrollY)

    love.graphics.pop()
end

return Credits
