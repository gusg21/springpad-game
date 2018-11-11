local Test = class("Test Entity")

function Test:initialize(data)
    self.id = Entities:addEntity(self)

    self.data = data
    assert(self.data.x)
    assert(self.data.y)
end

function Test:update()
    
end

function Test:draw()
    love.graphics.setColor(1,1,1,1)

    love.graphics.rectangle("fill", self.data.x, self.data.y, 8, 8)
end

return Test
