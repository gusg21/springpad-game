local CopierWeight = class("Copier Weight")

function CopierWeight:initialize(boss)
    self.id = Entities:addEntity(self)

    self.image = EntityImages["Copier Weight"]

    self.pos = Vector(2 * 8, 0 * 8)
    self.velocity = Vector()
    self.gravity = 0.2

    self.falling = false

    self.flashTimer = 5
    self.overallFlashTimer = 60
    self.flashing = true

    self.height = 24

    self.boss = boss
    self.killedBoss = false
end

function CopierWeight:update()
    if self.falling then
        self.velocity.y = self.velocity.y + self.gravity

        if self.pos.y > _gameHeight + 50 then
            self.pos = Vector(2 * 8, 0 * 8)
            self.falling = false
            self.overallFlashTimer = 60
            self.velocity = Vector()
            self.flashing = true
        end
    end

    if self.flashTimer == -5 then
        self.flashTimer = 5
    end

    self.pos = self.pos + self.velocity
    self.overallFlashTimer = self.overallFlashTimer - 1
    self.flashTimer = self.flashTimer - 1

    if self.overallFlashTimer < 0 then
        self.flashing = false
    end

    if
        rectanglesOverlap(
            self.pos.x,
            self.pos.y,
            8,
            24,
            self.boss.pos.x + 8,
            self.boss.pos.y + 8,
            self.boss.image:getWidth() - 16,
            self.boss.image:getHeight() - 16
        ) and not self.killedBoss
     then
        Entities:removeEntity(self.boss.id)
        EntityIndex["Explosion"](
            self.boss.pos.x + (self.boss.image:getWidth() / 2) - 4,
            self.boss.pos.y + (self.boss.image:getHeight() / 2) - 4
        )
        EntityIndex["Explosion"](
            self.boss.pos.x + (self.boss.image:getWidth() / 2) + 4,
            self.boss.pos.y + (self.boss.image:getHeight() / 2) + 4
        )
        ScreenShake:shake(2, 12)

        self.killedBoss = true
        _bossesBeaten[2] = true
        Entities:removeEntity(self.boss.wall.id)
        if _bumpWorld:hasItem(self.boss.invisibleWall) then _bumpWorld:remove(self.boss.invisibleWall) end
    end
end

function CopierWeight:onHammered()
    if not self.flashing then
        self.falling = true
        return true
    end
end

function CopierWeight:draw()
    if self.flashTimer > 0 or not self.flashing then
        love.graphics.draw(self.image, self.pos.x, self.pos.y)
    end
end

return CopierWeight
