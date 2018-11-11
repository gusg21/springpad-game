local Hammer = class("Hammer")

function Hammer:initialize(x, y, velocity)
    self.id = Entities:addEntity(self)
    self.isHammer = true

    self.pos = Vector(x, y)
    self.velocity = velocity

    self.image = MapControl.Tileset("assets/hammer.png", 8)
    self.imageIndex = 0
end

function Hammer:update()
    self.velocity.y = self.velocity.y + 0.05
    self.pos = self.pos + self.velocity
    self.imageIndex = self.imageIndex % 3
    self.imageIndex = self.imageIndex + 0.1

    if not isOnScreen(self.pos) then
        print("Hammer removed")
        Entities:removeEntity(self.id)
    end

    Entities:forEach(
        function(e)
            local otherWidth = e.width or 8
            local otherHeight = e.height or 8

            if not e.pos then
                return
            end

            if
                rectanglesOverlap(self.pos.x, self.pos.y, 8, 8, e.pos.x, e.pos.y, otherWidth, otherHeight) and
                    e.onHammered
             then
                if e:onHammered() == true then
                    EntityIndex["Explosion"](self.pos.x + 4, self.pos.y + 4)
                    Entities:removeEntity(self.id)
                    ScreenShake:shake(1, 5)
                end
            end
        end
    )
end

function Hammer:onRemove()
end

function Hammer:draw()
    self.image:drawTile(math.floor(self.imageIndex), math.round(self.pos.x), math.round(self.pos.y))
end

return Hammer
