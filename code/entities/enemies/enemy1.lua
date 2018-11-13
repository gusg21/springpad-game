local Enemy1 = class("Enemy #1")

function Enemy1:initialize(data)
    self.id = Entities:addEntity(self)

    self.image = MapControl.Tileset("assets/enemy1.png", 16)
    self.imageIndex = 0

    self.pos = Vector(data.x, data.y)
end

function Enemy1:update()
    self.imageIndex = self.imageIndex + 0.15
    if self.imageIndex >= 2 then
        self.imageIndex = 0
    end

    local direction = _player.pos - self.pos
    direction = direction:normalized()

    self.pos = self.pos + (direction * 0.25)

    if rectanglesOverlap(self.pos.x, self.pos.y, 8, 8, _player.pos.x, _player.pos.y, _player.width, _player.height) then
        _player:die()
    end
end

function Enemy1:onHammered()
    Entities:removeEntity(self.id)
    EntityIndex["Explosion"](self.pos.x + 4, self.pos.y + 4)
    ScreenShake:shake(1, 5)

    return true
end

function Enemy1:draw()
    self.image:drawTile(math.floor(self.imageIndex), math.round(self.pos.x - 4), math.round(self.pos.y - 4))
end

return Enemy1