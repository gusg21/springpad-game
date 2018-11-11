local DialogText = class("Dialog Text")

function DialogText:initialize(x, y, width, maxTimer)
    if not maxTimer then
        maxTimer = 150
    end
    self.maxTimer = maxTimer
    self.text = ""
    self.texts = {}
    self.textIndex = 1
    self.timer = -1
    self.font = StatusText.font
    self.callback = function()
    end
    self.haveCalledback = false
    self.pos = Vector(x, y)
    self.width = width
    self.done = true
end

function DialogText:show(texts)
    self.texts = texts
    self.timer = self.maxTimer
    self.textIndex = 1
    self.done = false
end

function DialogText:update()
    self.timer = self.timer - 1

    if self.timer < 0 then
        self.text = self.texts[self.textIndex] or ""
        if self.text == "" then
            self.done = true
        end
        self.textIndex = self.textIndex + 1
        self.timer = self.maxTimer
    end
end

function DialogText:draw(x, y)
    love.graphics.setFont(self.font)
    love.graphics.setColor(192 / 255, 203 / 255, 220 / 255, self.timer / 25)
    love.graphics.printf(self.text, math.round(self.pos.x), math.round(self.pos.y), self.width, "center")
    love.graphics.setColor(1, 1, 1, 1)

    -- if self.timer > 0 then
    --     _player:canMove(false)
    -- else
    --     _player:canMove(true)
    -- end
end

return DialogText
