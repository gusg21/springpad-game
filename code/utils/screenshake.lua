local ScreenShake = {
    amplitude = 0,
    timer = 0,
    offset = Vector()
}

function ScreenShake:update()
    self.timer = self.timer - 1

    if self.timer > 0 then
        self.offset.x = math.random(-self.amplitude, self.amplitude)
        self.offset.y = math.random(-self.amplitude, self.amplitude)
    else
        self.offset = Vector()
    end
end

function ScreenShake:shake(amp, length)
    self.amplitude = amp
    self.timer = length
end

return ScreenShake
