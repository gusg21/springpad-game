local DaveyShot = class("Davey Shot")

function DaveyShot:initialize(x, y, vel)
    self.id = Entities:addEntity(self)

    self.pos = Vector(x, y)
    self.vel = vel
    local colors = {{99 / 255, 199 / 255, 77 / 255}, {247 / 255, 118 / 255, 34 / 255}}
    self.color = colors[math.random(#colors)]
end

function DaveyShot:update()
    self.pos = self.pos + self.vel

    if not isOnScreen(self.pos) then
        Entities:removeEntity(self.id)
    end

    if
        self.pos.x > _player.pos.x and self.pos.x < _player.pos.x + _player.width and self.pos.y > _player.pos.y and
            self.pos.y < _player.pos.y + _player.height
     then
        _player:die()
    end
end

function DaveyShot:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", math.round(self.pos.x - 1), math.round(self.pos.y - 1), 2, 2)
    love.graphics.setColor(1, 1, 1)
end

return DaveyShot
