Collectable = class("Collectable")

function Collectable:initialize(data, targetAbility)
    if not _player[targetAbility] then
        self.id = Entities:addEntity(self)

        self.targetAbility = targetAbility

        self.data = data
        assert(self.data.x)
        assert(self.data.y)

        self.image = EntityImages["Passthrough Powerup"]
        self.pos = Vector(self.data.x, self.data.y)

        self.particles = EntityIndex["Particles"](self.pos.x + 4, self.pos.y + 3)

        self.movementTimer = 80
    else
        self = nil
    end
end

function Collectable:checkForPlayer()
    if
        rectanglesOverlap(
            self.pos.x + 1,
            self.pos.y + 1,
            6,
            6,
            _player.pos.x,
            _player.pos.y,
            _player.width,
            _player.height
        )
     then
        _player[self.targetAbility] = true
        if self.onGot then
            Sounds["Powerup"]:play()
            self:onGot()
        end

        if self.particles then
            Entities:removeEntity(self.particles.id)
        end
        Entities:removeEntity(self.id)
    end
end

function Collectable:update()
    self.movementTimer = self.movementTimer - 1

    if self.movementTimer == 40 then
        self.pos.y = self.pos.y - 1
    end

    if self.movementTimer == 0 then
        self.pos.y = self.pos.y + 1
        self.movementTimer = 80
    end

    self:checkForPlayer()
end

return Collectable
