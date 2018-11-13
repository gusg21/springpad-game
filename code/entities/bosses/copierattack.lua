local CopierAttack = class("Copier Attack")

function CopierAttack:initialize(pos)
    self.id = Entities:addEntity(self)

    self.pos = pos
    self.velocity = (_player.pos - self.pos):normalized()

    self.image = EntityImages["Copier Attack"]
    self.imageIndex = 0
end

function CopierAttack:update()
    self.pos = self.pos + self.velocity

    if self.imageIndex == 4 then self.imageIndex = 0 end
    self.imageIndex = self.imageIndex + 0.25

    if rectanglesOverlap(self.pos.x + 2, self.pos.y + 2, 4, 4, _player.pos.x, _player.pos.y, _player.width, _player.height) then
        _player:die()
    end
end

function CopierAttack:draw()
    self.image:drawTile(math.floor(self.imageIndex), self.pos.x, self.pos.y)
end

return CopierAttack