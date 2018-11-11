local MacroAttack = class("Macro Attack")

function MacroAttack:initialize(parent)
    self.id = Entities:addEntity(self)

    self.pos = Vector(
        parent.pos.x + 8, parent.pos.y - 18 
    )
    self.velocity = Vector(0, -1)
    self.parent = parent

    self.image = EntityImages["Macro Attack"]

    self.timer = 15
    self.state = "held"
end

function MacroAttack:update()
    self.timer = self.timer - 1

    if self.state == "held" then
        self.pos = Vector(
            self.parent.pos.x + 8, self.parent.pos.y - 18 
        )
    elseif self.state == "dropped" then
        self.velocity.y = self.velocity.y + _gravity
        self.pos = self.pos + self.velocity
    end

    if self.timer == 0 then
        self.state = "dropped"
        self.parent.dropTimer = 20
    end

    if self.state == "dropped" and self.pos.y > 81 then
        Entities:removeEntity(self.id)
    end

    if rectanglesOverlap(self.pos.x, self.pos.y, 7, 7, _player.pos.x, _player.pos.y, _player.width, _player.height) then
        _player:die()
    end
end

function MacroAttack:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return MacroAttack