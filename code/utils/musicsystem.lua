-- Delicious Area based music system!

local MusicSystem = {
    currentArea = 0,
    currentTrack = nil,
    data = {},
    isPaused = false
}

function MusicSystem:load(data)
    assert(type(data) == "table")
    self.data = data
end

function MusicSystem:setArea(area)
    self.currentArea = area
end

function MusicSystem:nextTrack()
    local availableTracks = self.data[self.currentArea]
    self.currentTrack = availableTracks[math.random(#availableTracks)]
    self.currentTrack:play()
end

function MusicSystem:pause()
    self.isPaused = true
    self.currentTrack:pause()
end

function MusicSystem:play()
    self.isPaused = false
    self.currentTrack:play()
end

function MusicSystem:update()
    if self.isPaused then
        return
    end

    if not self.currentTrack then
        self:nextTrack()
    end

    if not self.currentTrack:isPlaying() then
        self:nextTrack()
    end
end

return MusicSystem
