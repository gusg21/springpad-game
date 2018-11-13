local Boost = class("Boost Entity")

function Boost:initialize(data)
    EntityIndex["Collectable"].initialize(self, data, "boostAbility")

    self.image = EntityImages["Boost"]
end

function Boost:checkForPlayer()
    EntityIndex["Collectable"].checkForPlayer(self)
end

function Boost:update()
    EntityIndex["Collectable"].update(self)
end

function Boost:onRemove()
    -- body
end

function Boost:onGot()
    StatusText:show("PRESS C")
end

function Boost:draw()
    love.graphics.setColor(1,1,1,1)

    love.graphics.draw(self.image, math.round(self.pos.x), math.round(self.pos.y))
end

return Boost
