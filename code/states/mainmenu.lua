local MainMenu = {}

local MenuSystem = require("states.menuutils.menusystem")

menuBackground = love.graphics.newImage("assets/menu/background.png")
logo = love.graphics.newImage("assets/menu/logo.png")
howTo = love.graphics.newImage("assets/menu/howto.png")

menuCursor = love.graphics.newImage("assets/menu/arrow.png")
cursorY = 0

logoY = 0
ticks = 0

menuPos = 37

isFading = false
fadeAlpha = 0

MainMenu.init = function()
end

MainMenu.update = function(dt)
    if MenuSystem.currentMenu == "main" then
        extraY = 0
    elseif MenuSystem.currentMenu == "howToPlay" then
        extraY = 22
    end

    logoY = math.sin(ticks / 30) * 2

    ticks = ticks + 1

    if isFading then
        fadeAlpha = fadeAlpha + 0.01

        if fadeAlpha > 1 then
            Gamestate.switch(Game)
        end
    end

    lb.update()
end

MainMenu.keypressed = function(keycode, key)
    if key == "down" then
        cursorY = cursorY + 7
    end

    if key == "up" then
        cursorY = cursorY - 7
    end

    if key == "escape" then
        love.event.quit()
    end

    if key == "z" then
        MenuSystem:userSelection(cursorY / 7)
    end

    cursorY = math.clamp(cursorY, 0, MenuSystem:getCurrentLength() * 7)
end

MainMenu.draw = function()
    love.graphics.setColor(1, 1, 1)

    love.graphics.push()
    love.graphics.scale(5, 5)

    love.graphics.draw(menuBackground)
    if MenuSystem.currentMenu == "howToPlay" then
        love.graphics.draw(howTo, 0, 0)
    end
    love.graphics.draw(menuCursor, 10, menuPos - 1 + cursorY + extraY)

    love.graphics.setFont(_font)
    love.graphics.setColor(99 / 255, 199 / 255, 77 / 255)

    local offsetY = 0
    for _, item in ipairs(MenuSystem:getCurrentMenu()) do
        love.graphics.printf(item, 0, menuPos + extraY + offsetY, 80, "center")
        offsetY = offsetY + 7
    end

    love.graphics.setColor(1, 1, 1)

    if MenuSystem.currentMenu ~= "howToPlay" then
        love.graphics.draw(logo, 6, math.round(5 + logoY))
    end

    love.graphics.pop()

    love.graphics.setColor(0, 0, 0, fadeAlpha)
    love.graphics.rectangle("fill", 0, 0, 400, 400)
end

return MainMenu
