local D = {}

function D.gotoMacro()
    World:to(Vector(3, -1))
end

function D.killPlayer()
    _player:die()
end

function D.boost(amt)
    local amt = amt or 1 
    _player.velocity.y = -2.5 * amt
end

function D.cool()
    _player.invincible = true
    _player.passthroughAbility = true
    _player.hammerAbility = true
    _player.boostAbility = true
end

function D.enableClick()
    love.mousepressed = function (x, y)
        _player.pos = Vector(
            x / 5,
            y / 5
        )
        _bumpWorld:move(_player, _player.pos.x, _player.pos.y)
    end
end

function D.getPassthrough()
    _player.passthroughAbility = true
end

return D