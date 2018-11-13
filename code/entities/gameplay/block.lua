Block = class("Block")

function Block:initialize(data)
    self.id = Entities:addEntity(self)

    self.pos = Vector(data.x, data.y)
    _bumpWorld:add(self, self.pos.x, self.pos.y, 8, 8)

    self.image = EntityImages["Block"]
end

function Block:onRemove()
    if _bumpWorld:hasItem(self) then
        _bumpWorld:remove(self)
    end
end

function Block:onHammered()
    _bumpWorld:remove(self)
    Entities:removeEntity(self.id)

    return true -- destroy the hammer
end

function Block:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return Block