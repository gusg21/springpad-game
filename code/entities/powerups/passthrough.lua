local Passthrough = class("Passthrough Entity")

function Passthrough:initialize(data)
    EntityIndex["Collectable"].initialize(self, data, "passthroughAbility")
end

function Passthrough:checkForPlayer()
    EntityIndex["Collectable"].checkForPlayer(self)
end

function Passthrough:update()
    EntityIndex["Collectable"].update(self)
end

function Passthrough:onRemove()
    -- body
end

function Passthrough:onGot()
    StatusText:show("PRESS Z")
end

function Passthrough:draw()
    love.graphics.setColor(1,1,1,1)

    love.graphics.draw(self.image, math.round(self.pos.x), math.round(self.pos.y))
end

return Passthrough
