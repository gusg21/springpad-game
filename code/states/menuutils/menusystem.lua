local empty = function (...) end

local MenuSystem = {
        structure = {
            main = {
                "PLAY",
                "CREDITS",
                "HOW TO PLAY",
                "QUIT"
            },
            howToPlay = {
                "BACK"
            }
        },
        actions = {
            main = {
                ["PLAY"] = function ()
                    Gamestate.switch(Game)
                end,
                ["CREDITS"] = function ()
                    Gamestate.switch(Credits)
                end,
                ["HOW TO PLAY"] = "howToPlay",
                ["QUIT"] = function ()
                    love.event.quit()
                end
            },
            howToPlay = {
                ["BACK"] = "main"
            },
        },

        currentMenu = "main",
}

function MenuSystem:getCurrentMenu()
    return self.structure[self.currentMenu]
end

function MenuSystem:getCurrentLength()
    return #self:getCurrentMenu() - 1
end

function MenuSystem:userSelection(index)
    -- process user's selection

    index = index + 1

    local targetAction = self.actions[self.currentMenu][self:getCurrentMenu()[index]]
    if type(targetAction) == "function" then
        targetAction()
    elseif type(targetAction) == "string" then
        self.currentMenu = targetAction
    end
end

return MenuSystem