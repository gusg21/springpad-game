local StatusText = {
    text = "",
    timer = 0,
    font = _font,
    callback = function () end,
    haveCalledback = false,
}

function StatusText:show(text, callback)
    self.text = text
    self.timer = 150
    self.callback = callback or function () end
    self.haveCalledback = false
    self.offsetX = -4
end

function StatusText:update()
    self.timer = self.timer - 1
    self.offsetX = self.offsetX + 0.1
end

function StatusText:draw()
    if self.timer > 0 then
        local textWidth = 58

        love.graphics.setFont(self.font)
        love.graphics.setColor(192 / 255, 203 / 255, 220 / 255, self.timer / 25)
        love.graphics.printf(self.text, math.round(_player.pos.x - textWidth / 2 + self.offsetX), math.round(_player.pos.y + 10), textWidth, "center")
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

setmetatable(StatusText, {__call = StatusText.show})

return StatusText
