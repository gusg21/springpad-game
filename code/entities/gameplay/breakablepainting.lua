local BP = class("Breakable Painting")

function BP:initialize(data)
    print("OY")
    self.id = Entities:addEntity(self)

    self.pos = Vector(4 * 8, 4 * 8)

    self.image = love.graphics.newImage("assets/breakablepainting.png")

    self.health = 4

    self.width = 16
    self.height = 16
end

function BP:update()
end

function BP:onHammered()
    self.health = self.health - 1

    if self.health > 0 then
        return true
    end
end

function BP:draw()
    if self.health >= 0 then
        love.graphics.draw(self.image, self.pos.x, self.pos.y)
    else
        EntityIndex["Davey Secret Cutscene"]()
    end
end

return BP
