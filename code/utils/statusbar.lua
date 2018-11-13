StatusBar = class("StatusBar")

function StatusBar:initialize(maximum, width)
    self.maximum = maximum
    self.value = 0
    self.width = width or 10
end

function StatusBar:draw(x, y)
    love.graphics.setColor(247 / 255, 118 / 255, 34 / 255)
    love.graphics.rectangle("fill", x, y, self.width, 1)
    love.graphics.setColor(99 / 255, 199 / 255, 77 / 255)

    local computedWidth = self.width * (self.value / self.maximum)

    love.graphics.rectangle("fill", x, y, math.floor(computedWidth), 1)

    love.graphics.setColor(1,1,1,1)
end

return StatusBar