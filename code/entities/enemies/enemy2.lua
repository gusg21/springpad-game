local Enemy2 = class("Enemy #2")

function Enemy2:initialize(data)
    self.id = Entities:addEntity(self)

    self.image = MapControl.Tileset("assets/enemy2.png", 8)
    self.imageIndex = 0
    self.direction = 0

    self.pos = Vector(data.x, data.y)
    self.velocity = Vector()

    _bumpWorld:add(self, self.pos.x, self.pos.y, 8, 8)
end

function Enemy2:update()
    self.imageIndex = self.imageIndex + 0.15
    if self.imageIndex >= 2 then
        self.imageIndex = 0
    end

    if _player.pos.x > self.pos.x then
        self.velocity.x = 0.25
    elseif _player.pos.x < self.pos.x then
        self.velocity.x = -0.25
    elseif math.abs(_player.pos.x - self.pos.x) < 2 then
        self.velocity.x = 0
    end

    self.direction = btoi(self.velocity.x >= 0)

    self.velocity.y = self.velocity.y + _gravity
    self.pos = self.pos + self.velocity

    self.pos.x, self.pos.y, cols, _ = _bumpWorld:move(self, self.pos.x, self.pos.y)

    if rectanglesOverlap(self.pos.x, self.pos.y, 8, 8, _player.pos.x, _player.pos.y, _player.width, _player.height) then
        _player:die()
    end

    for _, col in pairs(cols) do
        if col.normal.y == -1 then
            self.velocity.y = 0
        end
    end
end

function Enemy2:onHammered()
    Entities:removeEntity(self.id)
    EntityIndex["Explosion"](self.pos.x + 4, self.pos.y + 4)

    return true
end

function Enemy2:onRemove()
    _bumpWorld:remove(self)
end

function Enemy2:draw()
    self.image:drawTile(math.floor(self.imageIndex + self.direction * 2), math.round(self.pos.x), math.round(self.pos.y))
end

return Enemy2