Reward = class("Reward")

function Reward:initialize(data)
    self.rewardId = tostring(data.roomx) .. "." .. tostring(data.roomy)

    if not _rewardsCollected[self.rewardId] then
        self.id = Entities:addEntity(self)

        self.pos = Vector(data.x, data.y)

        self.image = EntityImages["Reward"]
    end
end

function Reward:update()
    if
        rectanglesOverlap(
            self.pos.x + 2,
            self.pos.y + 2,
            4,
            4,
            _player.pos.x,
            _player.pos.y,
            _player.width,
            _player.height
        )
     then
        _rewardsCollected[self.rewardId] = true
        _rewardCount = _rewardCount + 1
        RewardCounter:show("REWARDS: " .. tostring(_rewardCount))
        Sounds["Powerup"]:play()
        Entities:removeEntity(self.id)
    end
end

function Reward:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end

return Reward
