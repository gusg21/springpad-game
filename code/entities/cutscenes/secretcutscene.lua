SecretCutscene = class("Cutscene #1 (Davey talk one)")

function SecretCutscene:initialize(data)
    if not _secretDaveyCutscene then
        self.id = Entities:addEntity(self)

        self.daveyImage = EntityImages["Davey"]
        self.daveyPos = Vector(36, 30)

        self.daveyText = DialogText(self.daveyPos.x - 35, self.daveyPos.y - 20, 80)

        self.phase = 0

        _player:canMove(false)

        self.elapsed = 0

        _secretDaveyCutscene = true
    end
end

function SecretCutscene:update()
    self.elapsed = self.elapsed + 1

    if self.elapsed == 60 then
        self.daveyText:show(
            {
                "hey",
                "dont do that",
                "you might unlock something",
                "and we dont want that",
                "now do we?"
            }
        )
    end

    if self.daveyText.done and self.elapsed > 80 then
        _player:canMove(true)
    end

    self.daveyText:update()
end

function SecretCutscene:draw()
    self.daveyText:draw()
end

function SecretCutscene:uiDraw()
    if not self.daveyText.done then
        love.graphics.draw(self.daveyImage, (self.daveyPos.x) * _zoom, (self.daveyPos.y) * _zoom)
    end
end

return SecretCutscene
