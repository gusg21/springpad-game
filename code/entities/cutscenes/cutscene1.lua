Cutscene1 = class("Cutscene #1 (Davey talk one)")

function Cutscene1:initialize(data)
    self.id = Entities:addEntity(self)

    self.daveyImage = EntityImages["Davey"]
    self.daveyPos = Vector(5 * 8, 8 * 8 + 2)

    self.daveyText = DialogText(self.daveyPos.x - 39, self.daveyPos.y - 20, 80)

    self.phase = 0

    _player:canMove(false)
end

function Cutscene1:update()
    if self.phase == 0 then -- player walking
        if _player.pos.x < 20 then
            print("Moving player right")
            _player.velocity.x = _player.movespeed
        elseif _player.pos.x > 60 then
            print("Moving player left")
            _player.velocity.x = -_player.movespeed
        else
            print("Stopping player")
            _player.velocity.x = 0
            self.phase = 1
        end
    elseif self.phase == 1 then
        self.daveyText:show(
            {
                "HI! I'M DAVEY!",
                "(THE NAME'S DAVE.)",
                "WHO ARE YOU?",
                "(MMM... TUNA SANDWICH.)",
                "OOPS! TIME TO GO TO WORK!",
                "(WE CAN TALK AT 5.)"
            }
        )
        self.phase = 2
    elseif self.phase == 2 then
        if self.daveyText.done == true then
            _player:canMove(true)
        end
    end

    self.daveyText:update()
end

function Cutscene1:draw()
    self.daveyText:draw()
end

function Cutscene1:uiDraw()
    love.graphics.draw(self.daveyImage, (self.daveyPos.x) * _zoom, (self.daveyPos.y) * _zoom)
end

return Cutscene1
