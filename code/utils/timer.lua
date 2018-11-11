-- written by the illustrious Graham Mack!

local Timer = {
    elapsed = 0,
    seconds = 0,
    minutes = 0
}

function Timer:update()
    self.elapsed = self.elapsed + 1
    self:_minutes()
end

function Timer:_seconds()
    self.seconds = math.floor((self.elapsed / 60) * 100) / 100
end

function Timer:_minutes()
    Timer:_seconds()
    if self.seconds >= 60 then
        self.elapsed = 0
        self.minutes = self.minutes + 1
    end
end

function Timer:draw()
    if self.minutes < 10 and self.seconds < 10 then
        love.graphics.print("0" .. tostring(self.minutes) .. ":" .. "0" .. tostring(self.seconds), 2, 2)
    elseif self.minutes > 9 and self.seconds < 10 then
        love.graphics.print(tostring(self.minutes) .. ":" .. "0" .. tostring(self.seconds), 2, 2)
    elseif self.minutes < 10 then
        love.graphics.print("0" .. tostring(self.minutes) .. ":" .. tostring(self.seconds), 2, 2)
    else
        love.graphics.print(tostring(self.minutes) .. ":" .. tostring(self.seconds), 2, 2)
    end
end

return Timer
