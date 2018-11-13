local Door = class("Door")

function Door:initialize(data)
    self.id = Entities:addEntity(self)

    self.pos = Vector(data.x, data.y)
    self.targetPos = Vector(data.targetX, data.targetY)
    self.targetRoom = Vector(data.targetRoomX, data.targetRoomY)

    self.f = data.f or function()
        end

    self.width = data.width or 8
    self.height = data.height or 16
end

function Door:update()
    print(self.pos)
    if
        rectanglesOverlap(
            self.pos.x - 1,
            self.pos.y - 1,
            self.width + 2,
            self.height + 2,
            _player.pos.x,
            _player.pos.y,
            _player.width,
            _player.height
        )
     then
        World:to(self.targetRoom)
        _player:to(self.targetPos)

        Sounds["Door"]:play()
        self.f()
    end
end

return Door
