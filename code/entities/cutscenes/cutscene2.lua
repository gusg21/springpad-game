Cutscene2 = class("Cutscene #2 (Davey office)")

function Cutscene2:initialize(data)
    if not _cutscene2 then
        self.id = Entities:addEntity(self)

        self.daveyImage = EntityImages["Davey"]
        self.daveyPos = Vector(5 * 8, 7 * 8 + 4)

        self.daveyText = DialogText(self.daveyPos.x - 27, self.daveyPos.y - 20, 60, 220)

        self.phase = 0

        _player:canMove(false)

        _cutscene2 = true
    end
end

function Cutscene2:update()
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
                "WELCOME TO MY OFFICE!",
                "(MY CORPORATE ABODE.)",
                "HOW ARE YOU?",
                "(I'M QUITE WELL.)",
                "I'LL GO GET MY MECH SUIT!",
                "(READY FOR THE FINAL BOSS?)"
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

function Cutscene2:draw()
    self.daveyText:draw(self.daveyPos.x - 39, self.daveyPos.y - 18)
end

function Cutscene2:uiDraw()
    love.graphics.draw(self.daveyImage, (self.daveyPos.x) * _zoom, (self.daveyPos.y) * _zoom)
end

return Cutscene2
