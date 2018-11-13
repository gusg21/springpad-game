local Hammer = class("Hammer Entity")

function Hammer:initialize(data)
    EntityIndex["Collectable"].initialize(self, data, "hammerAbility")

    self.image = MapControl.Tileset("assets/hammer.png", 8)
end

function Hammer:checkForPlayer()
    EntityIndex["Collectable"].checkForPlayer(self)
end

function Hammer:update()
    EntityIndex["Collectable"].update(self)
end

function Hammer:onRemove()
    -- body
end

function Hammer:onGot()
    StatusText:show("PRESS X")
end

function Hammer:draw()
    love.graphics.setColor(1,1,1,1)

    self.image:drawTile(0, math.round(self.pos.x), math.round(self.pos.y))
end

return Hammer
