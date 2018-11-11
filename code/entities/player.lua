local Player = class("Player")

function Player:initialize(startX, startY)
    self.isPlayer = true

    self.pos = Vector(startX, startY)
    self.width = 4
    self.height = 7
    self.velocity = Vector()
    self.movespeed = 0.5
    self.jumpspeed = 1.4
    self.onGround = false
    _bumpWorld:add(self, self.pos.x, self.pos.y, self.width, self.height)

    self.image = MapControl.Tileset("assets/player.png", 8)
    self.direction = 1
    self.imageIndex = 0
    self.animation = "idle"
    self.animationTimer = 0

    self.canPassthrough = false
    self.passthroughAbility = false

    self.hammerAbility = false
    self.hammerReloadTime = 15
    self.hammerTimer = self.hammerReloadTime
    self.hammerAnimationTimer = 0
    self.hammerPower = 0
    self.hammerPowerBar = StatusBar(60)

    self.boostAbility = false

    self.canMove_ = true
    self.invincible = false
end

function Player:to(_pos)
    self.pos = _pos:clone()
    _bumpWorld:update(self, _pos:unpack())
end

function Player:canMove(can)
    self.canMove_ = can

    if can == false then
        self.velocity.x = 0
    end
end

function Player:throwHammer()
    local xOffset = 0
    if self.direction == 0 then
        xOffset = -4
    elseif self.direction == 1 then
        xOffset = 2
    end
    EntityIndex["Hammer"](
        self.pos.x + xOffset,
        self.pos.y,
        Vector(((self.direction * 3) - 1.5) * self.hammerPower / 60, -1.5 - self.hammerPower / 120)
    )
    self.hammerTimer = self.hammerReloadTime
    self.hammerAnimationTimer = 9
    self.hammerPower = 0
end

function Player:doGravity()
    self.velocity.y = self.velocity.y + _gravity
end

function Player:doMovement()
    if self.onGround and love.keyboard.wasPressed("up") then
        self.velocity.y = -(self.jumpspeed - btoi(self.canPassthrough))
    end

    self.velocity.x =
        (btoi(love.keyboard.isDown("right")) - btoi(love.keyboard.isDown("left"))) *
        (self.movespeed - btoi(self.canPassthrough) * 0.25)

    if self.boostAbility and love.keyboard.wasPressed("c") and self.velocity.x ~= 0 then
        ScreenShake:shake(1, 4)
        EntityIndex["Explosion"](self.pos.x + 4, self.pos.y + 4)
        self.velocity.x = self.velocity.x * 25
        self.velocity.y = -0.2
    end
end

function Player:doPhysics()
    local target = self.pos:clone()
    target = (target + self.velocity)
    self.pos.x, self.pos.y, cols =
        _bumpWorld:move(
        self,
        target.x,
        target.y,
        function(item, other)
            if type(other.properties) == "table" then
                if other.properties.passthrough == true and self.canPassthrough then
                    return "cross"
                end
            end
            if other.isHammer then
                return "cross"
            end
            return "slide"
        end
    )
    self.onGround = false
    for _, col in pairs(cols) do
        local resetVelocity = true

        if col.normal.y ~= 0 then
            if col.normal.y == -1 then
                if type(col.other.properties) == "table" then
                    if col.other.properties.kill == true then
                        self:die()
                    end
                    if col.other.properties.passthrough == true and self.canPassthrough then
                        resetVelocity = false
                    end
                    if col.other.properties.bouncy == true then
                        self.velocity.y = -self.velocity.y
                        break
                    end
                -- other special properties
                end
            end
            if resetVelocity then
                self.velocity.y = 0
                self.onGround = true
            end
        end
    end
end

function Player:updateWorld()
    self.roomChange = false

    local rightBound = love.graphics.getWidth() / _zoom
    local bottomBound = love.graphics.getHeight() / _zoom

    if self.pos.x > rightBound - 1 then
        World:move(Vector(1, 0))
        self:to(Vector(-1, self.pos.y))
        self.roomChange = true
    elseif self.pos.x < -1 then
        World:move(Vector(-1, 0))
        self:to(Vector(rightBound - 4, self.pos.y))
        self.roomChange = true
    elseif self.pos.y > bottomBound then
        World:move(Vector(0, 1))
        self:to(Vector(self.pos.x, -1))
        self.roomChange = true
    elseif self.pos.y < -1 then
        World:move(Vector(0, -1))
        self:to(Vector(self.pos.x, bottomBound))
        self.roomChange = true
    end
end

function Player:die()
    if self.invincible then
        return
    end

    print(_respawn.pos)
    self:to(_respawn.pos)
    World:to(_respawn.roomPos)
    self.velocity = Vector()
    self.onGround = false
    StatusText("DIED")
    World:makeMap()
end

function Player:inPassthroughBlock()
    local ax, ay, cols = _bumpWorld:check(self, self.pos.x, self.pos.y)
    for _, col in pairs(cols) do
        if type(col.other.properties) == "table" then
            if col.other.properties.passthrough == true then
                return true
            end
        end
    end

    return false
end

function Player:togglePassthrough()
    self.canPassthrough = not self.canPassthrough

    if not self.canPassthrough and self:inPassthroughBlock() then
        self:die()
    end
end

function Player:doStatusText()
    if self.roomChange then
        if World.roomx == 2 and World.roomy == -2 then
            StatusText:show("...AN OFFICE?")
        end
    end
end

function Player:doGameplay()
    self:updateWorld()

    -- Passthrough
    if love.keyboard.wasPressed("z") and self.passthroughAbility then
        self:togglePassthrough()
    end

    -- Hammer
    if self.hammerAbility and self.hammerTimer < 0 then
        if love.keyboard.isDown("x") and self.hammerPower < 60 then
            self.hammerPower = self.hammerPower + 1
            self.hammerPowerBar.value = self.hammerPower
        end

        if love.keyboard.wasReleased("x") then
            self:throwHammer()
        end
    end

    self.hammerTimer = self.hammerTimer - 1

    -- NOTE: Boosting is in the physics. Can't be here b/c of update order :P

    -- Checkpointing
    if self.roomChange then
        -- Office
        if World.roomx == 1 and World.roomy == -2 then
            _respawn.roomPos = Vector(1, -2)
            _respawn.pos = Vector(36, 10)
        end

        -- Post Macro
        if World.roomx == 4 and World.roomy == -1 then
            _respawn.roomPos = Vector(3, -1)
            _respawn.pos = Vector(36, 10)
        end

        -- Pre Copier
        if World.roomx == 6 and World.roomy == 0 then
            _respawn.roomPos = Vector(6, 0)
            _respawn.pos = Vector(8 * 8, 5 * 8)
        end

        -- Post Boost
        if World.roomx == -3 and World.roomy == -1 then
            _respawn.roomPos = Vector(-3, -1)
            _respawn.pos = Vector(8 * 8, 2 * 8)
        end

        -- Pre Davey
        if World.roomx == 1 and World.roomy == -5 then
            _respawn.roomPos = Vector(1, -5)
            _respawn.pos = Vector(8 * 8, 2 * 8)
        end
    end

    self:doStatusText()
end

function Player:doAnimation()
    if self.velocity.x ~= 0 then
        self.animation = "walk"
    else
        self.animation = "idle"
    end

    if self.velocity.y < 0 then
        self.animation = "jumping"
    elseif self.velocity.y > 0 then
        self.animation = "falling"
    end

    if math.sign(self.velocity.x) == -1 then
        self.direction = 0
    elseif math.sign(self.velocity.x) == 1 then
        self.direction = 1
    end

    self.hammerAnimationTimer = self.hammerAnimationTimer - 1
    self.animationTimer = self.animationTimer + 1
    self.animationTimer = self.animationTimer % 30
    if self.animation == "walk" then
        self.imageIndex = math.floor(self.animationTimer / 15) + 1
    end

    if self.animation == "idle" then
        self.imageIndex = 0
    end

    if self.animation == "jumping" then
        self.imageIndex = 3
    end

    if self.animation == "falling" then
        self.imageIndex = 4
    end

    if self.hammerAnimationTimer > 0 then
        self.imageIndex = 5
    end
end

function Player:update(dt)
    self:doGravity()
    if self.canMove_ then
        self:doMovement()
    end
    self:doPhysics(dt)
    if self.canMove_ then
        self:doGameplay()
    end
    self:doAnimation()
    -- haha u sed dodo
end

function Player:draw()
    if self.canPassthrough then
        love.graphics.setColor(247 / 255, 118 / 255, 34 / 255, 0.8)
    end

    self.image:drawTile(self.imageIndex + (self.direction * 6), math.round(self.pos.x - 2), math.round(self.pos.y - 1))

    if self.canPassthrough then
        love.graphics.setColor(99 / 255, 199 / 255, 77 / 255, 0.8)

        love.graphics.rectangle("line", math.round(self.pos.x - 2), math.round(self.pos.y - 1), 8, 8)
    end

    if self.hammerPower > 0 then
        self.hammerPowerBar:draw(math.round(self.pos.x - 3), math.round(self.pos.y - 3))
    end

    love.graphics.setColor(1, 1, 1, 1)
end

return Player
