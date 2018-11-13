Game = {}

bump = require("libs.bump")

DialogText = require("utils.dialogtext")
MapControl = require("utils.mapcontrol")
MusicSystem = require("utils.musicsystem")
ScreenShake = require("utils.screenshake")
Solids = require("solids")
StatusBar = require("utils.statusbar")
StatusText = require("utils.statustext")
RewardCounter = require("utils.rewardcounter")
Timer = require("utils.timer")
World = require("utils.world")

EMS = require("utils.entities")
Entities = EMS()
require("entities.entityindex")
LevelEntityTable = require("let")

Player = require("entities.player")

_rewardsCollected = {}
_rewardCount = 0

_bossesBeaten = {}

_respawn = {
    pos = Vector(36, 10),
    roomPos = Vector()
}

_zoom = 5

_gameWidth = 80 * _zoom
_gameHeight = 80 * _zoom

Game.init = function()
    _map = World:makeMap()
    World:addEntities() -- technically not necesarry if no entities in first room

    _bumpWorld = bump.newWorld(32)
    _bumpWorld = _map:addCollisions(_bumpWorld)

    _gravity = 0.05

    _player = Player(_respawn.pos.x, _respawn.pos.y)

    StatusText:show(
        "WHERE AM I",
        function()
            StatusText:show("...")
        end
    )

    ScreenShake:shake(1, 9)

    local music1 = love.audio.newSource("assets/music/1.mp3", "stream")
    local music2 = love.audio.newSource("assets/music/2.mp3", "stream")
    local music3 = love.audio.newSource("assets/music/3.mp3", "stream")
    local music4 = love.audio.newSource("assets/music/4.mp3", "stream")
    local music5 = love.audio.newSource("assets/music/5.mp3", "stream")
    local music6 = love.audio.newSource("assets/music/6.mp3", "stream")
    local music7 = love.audio.newSource("assets/music/7.mp3", "stream")

    MusicSystem:load(
        {
            [0] = {
                -- musics 1 + 2
                music1,
                music7
            },
            [1] = {
                music2,
                music3,
                music7
            },
            [2] = {
                music3,
                music4,
                music2
            },
            [3] = {
                music4,
                music5,
                music8
            }
        }
    )

    -- D.cool()
end

Game.update = function(dt)
    if love.keyboard.isDown("escape") then
        love.event.push("quit")
    end

    -- if love.keyboard.wasPressed("f11") then
    --     love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
    -- end

    _player:update()

    Entities:forEach(
        function(e)
            if e.update then
                e:update(dt)
            end
        end
    )

    MusicSystem:update()
    -- some etc. music handling
    if World.roomy >= 0 then
        MusicSystem:setArea(0)
    elseif World.roomy == -1 then
        MusicSystem:setArea(1)
    elseif World.roomy <= -2 and World.roomy >= -3 then
        MusicSystem:setArea(2)
    elseif World.roomy <= -4 then
        MusicSystem:setArea(3)
    end
    RewardCounter:update()
    StatusText:update()
    ScreenShake:update()
    Timer:update()

    love.keyboard.updateKeys()
    lb.update(dt)
end

Game.draw = function()
    love.graphics.clear()
    -- Game

    love.graphics.push()
    love.graphics.scale(_zoom, _zoom)
    if love.window.getFullscreen() then
        love.graphics.translate(
            love.graphics.getWidth() / 10 - 80 / 2 + ScreenShake.offset.x,
            love.graphics.getHeight() / 10 - 80 / 2 + ScreenShake.offset.y
        )
    else
        love.graphics.translate(ScreenShake.offset.x, ScreenShake.offset.y)
    end

    if _backgroundImage then
        love.graphics.draw(_backgroundImage, 0, 0)
    end

    _map:draw()
    _player:draw()

    Entities:forEach(
        function(e)
            if e.draw then
                e:draw()
            end
        end
    )

    RewardCounter:draw()
    StatusText:draw()

    if _showDebug then
        for _, item in pairs(_bumpWorld:getItems()) do
            love.graphics.rectangle("fill", _bumpWorld:getRect(item))
        end
    end

    love.graphics.pop()

    -- UI
    love.graphics.push()
    love.graphics.scale(2, 2)

    love.graphics.setFont(_font)
    Timer:draw()

    love.graphics.setFont(_loveDefaultFont)
    if _showDebug then
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    end

    love.graphics.pop()

    Entities:forEach(
        function(e)
            if e.uiDraw then
                e:uiDraw()
            end
        end
    )
end

return Game
