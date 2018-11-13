local DaveyFloor = class("Davey Floor")

function DaveyFloor:calculatePosition()
    self.pos = Vector(0, (love.graphics.getHeight() / _zoom) - 8)
end

function DaveyFloor:initialize()
    self.id = Entities:addEntity(self)

    self:calculatePosition()
    self.image = EntityImages["Davey Floor"]

    _bumpWorld:add(self, self.pos.x, self.pos.y, 80, 8)
end

function DaveyFloor:update()
    self:calculatePosition()
    _bumpWorld:update(self, self.pos.x, self.pos.y)
end

function DaveyFloor:onRemove()
    _bumpWorld:remove(self)
end

function DaveyFloor:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return DaveyFloor
