local Macrowave = class("Macrowave")

function Macrowave:initialize(data)
    if not _bossesBeaten[1] then
        self.offset = Vector(7, 26)
        self.pos = Vector(data.x + self.offset.x, data.y + self.offset.y)

        self.image = MapControl.Tileset("assets/macrowave.png", 40)
        self.imageIndex = 0

        self.invisibleWall = {}
        _bumpWorld:add(self.invisibleWall, -2, 0, 1, 80)

        self.macrowall = EntityIndex["Macro Wall"]({
            x = 9 * 8,
            y = 0,
            targetBossId = 1,
        })

        self.direction = 1

        self.width = 23
        self.height = 12

        self.attackTimer = 30
        self.dropTimer = 0

        self.healthBar = StatusBar(5, 76)
        self.healthBar.value = 5

        self.healthBarText = love.graphics.newImage("assets/healthtext.png")

        self.id = Entities:addEntity(self)
    else
        self = nil
    end
end

function Macrowave:update()
    self.imageIndex = self.imageIndex + 0.15
    self.imageIndex = self.imageIndex % 6

    self.pos.x = self.pos.x + self.direction

    if self.pos.x >= 72 then
        self.direction = -1
    elseif self.pos.x <= -12 then
        self.direction = 1
    end

    self.attackTimer = self.attackTimer - 1
    if self.attackTimer == 0 then
        self.attackTimer = 65

        EntityIndex["Macro Attack"](self)
    end
    self.dropTimer = self.dropTimer - 1

    if self.healthBar.value <= 0 then
        Entities:removeEntity(self.id)
        EntityIndex["Explosion"](self.pos.x + 12, self.pos.y + 7)
        _bossesBeaten[1] = true
    end
end

function Macrowave:onRemove()
    _bumpWorld:remove(self.invisibleWall)
    Entities:removeEntity(self.macrowall.id)
end

function Macrowave:onHammered()
    self.healthBar.value = self.healthBar.value - 1

    return true
end

function Macrowave:draw()
    if self.dropTimer > 0 then
        self.image:drawTile(6, math.floor(self.pos.x - self.offset.x), math.floor(self.pos.y - self.offset.y))
    else
        self.image:drawTile(math.floor(self.imageIndex), math.floor(self.pos.x - self.offset.x), math.floor(self.pos.y - self.offset.y))
    end

    self.healthBar:draw(2, 77)
    love.graphics.draw(self.healthBarText, 2, 73)
end

return Macrowave