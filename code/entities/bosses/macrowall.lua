MacroWall = class("Macrowave Wall")

function MacroWall:initialize(data)
    print(data.targetBossId)
    if not _bossesBeaten[data.targetBossId] then
        self.id = Entities:addEntity(self)

        self.pos = Vector(data.x, data.y)
        _bumpWorld:add(self, self.pos.x, self.pos.y, 8, 80)

        self.image = love.graphics.newImage("assets/macrowall.png")
    else
        self = nil
    end
end

function MacroWall:onRemove()
    if _bumpWorld:hasItem(self) then
        _bumpWorld:remove(self)
    end
end

function MacroWall:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return MacroWall