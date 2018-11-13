Enemy1Spawner = class("Enemy 1 Spawner")

function Enemy1Spawner:initialize(data)
    self.id = Entities:addEntity(self)

    self.pos = Vector(data.x, data.y)

    self.spawnTimer = 90
end

function Enemy1Spawner:update()
    self.spawnTimer = self.spawnTimer - 1

    if self.spawnTimer == 0 then
        EntityIndex["Enemy1"]({x = self.pos.x, y = self.pos.y})
        self.spawnTimer = 90
    end
end

return Enemy1Spawner