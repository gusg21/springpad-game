local RewardCounter = {
    text = "",
    timer = 100,
    font = StatusText.font,
    callback = function () end,
    haveCalledback = false,
}

function RewardCounter:show(text, callback)
    self.text = text
    self.timer = 150
    self.callback = callback or function () end
    self.haveCalledback = false
end

function RewardCounter:update()
    self.timer = self.timer - 1
end

function RewardCounter:draw()
    if self.timer > 0 then
        local textWidth = 58

        love.graphics.setFont(self.font)
        love.graphics.setColor(158 / 255, 41 / 255, 129 / 255, self.timer / 25)
        love.graphics.print(self.text, 10, 10)
        love.graphics.setColor(1, 1, 1, 1)
    else
        if not self.haveCalledback then
            self.haveCalledback = true
            self.callback()
        end
    end

    -- if self.timer > 0 then
    --     _player:canMove(false)
    -- else
    --     _player:canMove(true)
    -- end
end

setmetatable(RewardCounter, {__call = RewardCounter.show})

return RewardCounter
