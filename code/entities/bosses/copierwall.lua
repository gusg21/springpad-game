CopierWall = class("Copierwave Wall")

function CopierWall:initialize(data)
    print(data.targetBossId)
    if not _bossesBeaten[data.targetBossId] then
        self.id = Entities:addEntity(self)

        self.pos = Vector(data.x, data.y)
        _bumpWorld:add(self, self.pos.x, self.pos.y, 8, 80)

        self.image = EntityImages["Copier Wall"]
    else
        self = nil
    end
end

function CopierWall:onRemove()
    _bumpWorld:remove(self)
end

function CopierWall:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return CopierWall