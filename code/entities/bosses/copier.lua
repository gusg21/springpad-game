local Copier = class("Copier")

function Copier:initialize(data)
    if not _bossesBeaten[2] then
        self.id = Entities:addEntity(self)

        self.image = EntityImages["Copier"]

        self.pos = Vector(-45, 5)

        self.moveAngle = 0.03
        self.velocity = Vector(1, 0)

        self.fireTimer = 10

        EntityIndex["Copier Weight"](self)

        self.wall = EntityIndex["Copier Wall"]({
            x = 0,
            y = 0,
            targetBossId = 2,
        })
        self.invisibleWall = {} 
        _bumpWorld:add(self.invisibleWall, 82, 0, 1, 80)
    else
        self = nil
    end
end

function Copier:update()
    self.velocity = self.velocity:rotated(self.moveAngle)

    self.pos = self.pos + self.velocity * 2

    if self.pos.x + (self.image:getWidth() / 2) > 0 and self.pos.y + (self.image:getHeight() / 2) < _gameHeight then
        print(self.fireTimer)
        if self.fireTimer <= 0 then
            EntityIndex["Copier Attack"](
                Vector(self.pos.x + (self.image:getWidth() / 2), self.pos.y + (self.image:getHeight() / 2))
            )
            self.fireTimer = 30
        end
    end

    self.fireTimer = self.fireTimer - 1
end

function Copier:onRemove()
    if _bumpWorld:hasItem(self.invisibleWall) then _bumpWorld:remove(self.invisibleWall) end
end

function Copier:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return Copier
