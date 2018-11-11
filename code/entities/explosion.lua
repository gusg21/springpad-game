Explosion = class("Explosion")

function Explosion:initialize(x, y)
    self.id = Entities:addEntity(self)

    self.pos = Vector(x, y)

    self.image = MapControl.Tileset("assets/explosion.png", 8)
    self.imageIndex = 0
end

function Explosion:update()
    self.imageIndex = self.imageIndex + 0.3
    if self.imageIndex > 5 then
        Entities:removeEntity(self.id)
    end
end

function Explosion:draw()
    self.image:drawTile(math.floor(self.imageIndex), self.pos.x - 4, self.pos.y - 4)
end

return Explosion