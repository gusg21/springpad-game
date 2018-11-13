local BigDaveyShot = class("Davey Shot")

function BigDaveyShot:initialize(x, y, vel)
    self.id = Entities:addEntity(self)

    self.pos = Vector(x, y)
    self.vel = vel
    local colors = {{99 / 255, 199 / 255, 77 / 255}, {247 / 255, 118 / 255, 34 / 255}}
    self.color = colors[math.random(#colors)]
end

function BigDaveyShot:update()
    self.pos = self.pos + self.vel

    if not isOnScreen(self.pos) then
        Entities:removeEntity(self.id)
    end

    if
        rectanglesOverlap(
            self.pos.x - 10,
            self.pos.y - 10,
            20,
            20,
            _player.pos.x,
            _player.pos.y,
            _player.width,
            _player.height
        )
     then
        _player:die()
    end
end

function BigDaveyShot:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", math.round(self.pos.x - 10), math.round(self.pos.y - 10), 20, 20)
    love.graphics.setColor(1, 1, 1)
end

return BigDaveyShot
