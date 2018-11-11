DaveyBot = class("Davey Bot")

function DaveyBot:initialize(data)
    EntityIndex["Davey Floor"]()
    self.id = Entities:addEntity(self)

    self.image = MapControl.Tileset("assets/daveybot.png", 47)
    self.imageIndex = 0
    self.backgroundImage = love.graphics.newImage("assets/daveybackground.png")

    self.pos = Vector(17, -47)
    self.velocity = Vector()

    self.stage = 0
    self.mode = 0
    self.elapsed = 0
    self.modeTimer = 360
    self.circleShotTimer = 0
    self.circleShotOffset = 0

    _player:canMove(false)

    self.leftWall = {wall = "left"}
    self.rightWall = {wall = "right"}
    _bumpWorld:add(self.leftWall, -2, 0, 1, 700 / _zoom)
    _bumpWorld:add(self.rightWall, 81, 0, 1, 700 / _zoom)

    self.dialog = DialogText(self.pos.x, self.pos.y + 130, 47)
end

function DaveyBot:circleShoot()
    for i = 0, 36 do
        local angle = Vector(0, -1):rotated(i * 10 * (math.pi / 180) + self.circleShotOffset) * 0.7
        EntityIndex["Davey Shot"](self.pos.x + 23, self.pos.y + 23, angle)
    end
end

function DaveyBot:beam()
    EntityIndex["Davey Shot"](self.pos.x - 10, 0, Vector(0, 1))
    EntityIndex["Davey Shot"](self.pos.x + 23, 0, Vector(0, 1))
    EntityIndex["Davey Shot"](self.pos.x + 57, 0, Vector(0, 1))
end

function DaveyBot:layerShoot()
    for i = 0, 20 do
        if math.random() < 0.3 then
            EntityIndex["Davey Shot"](i * 4, self.pos.y + 23, Vector(0, 0.8))
        end
    end
end

function DaveyBot:shootBigDown()
    local centralAngle = math.random(160, 200) -- 180 is down. 20deg discrepancy
    if math.abs(centralAngle - 170) > 8 and math.abs(centralAngle - 190) > 8 then
        local angleVector = Vector(0, -1):rotated(centralAngle * (math.pi / 180)) * 0.2
        EntityIndex["Davey Shot"](self.pos.x + 23 + math.random(-10, 10), self.pos.y + 23, angleVector)
    else
        print(centralAngle)
    end
end

function DaveyBot:diagonalBeam()
    EntityIndex["Big Ol' Davey Shot"](10, 34, Vector(0, 2))
    EntityIndex["Big Ol' Davey Shot"](40, 34, Vector(0, 2))
    EntityIndex["Big Ol' Davey Shot"](80 - 10, 34, Vector(0, 2))
end

function DaveyBot:update()
    self.imageIndex = self.imageIndex + 0.04
    if self.imageIndex > 7 then
        self.imageIndex = 0
    end
    if _player.pos.x < 40 and self.stage == 0 then
        _player.velocity.x = _player.movespeed
    elseif self.stage == 0 then
        _player.velocity.x = 0
        love.window.setMode(400, 700)
        self.stage = 1
        _player:canMove(true)
    elseif self.stage == 1 then
        print("stage 1")
        self.pos.y = self.pos.y + 0.1

        if self.pos.y > 4 then
            self.stage = 2
        end
    elseif self.stage == 2 then
        if self.mode < 7 then
            _backgroundImage = self.backgroundImage
        end

        if self.mode == 0 then
            if self.circleShotTimer == 0 then
                self:circleShoot()
                self.circleShotTimer = 30
            end
            self.circleShotTimer = self.circleShotTimer - 1
            self.circleShotOffset = self.circleShotOffset + 0.01
        end

        if self.mode == 1 then
            self:beam()
            self.velocity.x = math.cos(self.elapsed / 20)

            if self.elapsed > 260 and math.abs(self.pos.x - 17) < 0.3 then
                self.velocity.x = 0
                self.pos.x = 17
            end
        end

        if self.mode == 2 then
            if self.circleShotTimer == 0 then
                if self.elapsed < 330 then
                    self:circleShoot()
                end
                self.circleShotTimer = 30
            end
            self.circleShotTimer = self.circleShotTimer - 1
            self.circleShotOffset = self.circleShotOffset + 0.01
        end

        if self.mode == 3 then
            if self.circleShotTimer == 0 then
                self:layerShoot()
                self.circleShotTimer = 37
            end
            self.circleShotTimer = self.circleShotTimer - 1
            self.circleShotOffset = self.circleShotOffset + 0.01
        end

        if self.mode == 4 then
            if self.elapsed > 250 then
                self:shootBigDown()
            end
        end

        if self.mode == 5 then
            if self.circleShotTimer == 0 then
                self:diagonalBeam()
                self.circleShotTimer = 77
            end
            self.circleShotTimer = self.circleShotTimer - 1
            self.circleShotOffset = self.circleShotOffset + 0.01
        end

        if self.mode > 6 then
            self.velocity.y = -0.3
            self.velocity.x = -0.1
        end

        self.elapsed = self.elapsed + 1
        self.modeTimer = self.modeTimer - 1
        if self.modeTimer == 0 then
            self.mode = self.mode + 1
            if self.mode == 3 then
                print("EIWEUIWRUTWU")
                self.dialog:show({"DIE ALREADY"})
            end
            if self.mode == 7 then
                self.dialog:show({"NEVER MIND"})
                _backgroundImage = nil
            end
            if self.mode == 8 then
                love.window.setMode(400, 400)
                Credits.endGame = true
                Gamestate.switch(Credits)
            end
            self.elapsed = 0
            self.circleShotOffset = 70
            self.modeTimer = 360
        end

        self.pos = self.pos + self.velocity
    end

    self.dialog:update()
end

function DaveyBot:onRemove()
    _backgroundImage = nil
    love.window.setMode(400, 400)
    _bumpWorld:remove(self.leftWall)
    _bumpWorld:remove(self.rightWall)
    World:makeMap()
end

function DaveyBot:draw()
    self.image:drawTile(math.floor(self.imageIndex), math.round(self.pos.x), math.round(self.pos.y))
    self.dialog:draw()
end

return DaveyBot
