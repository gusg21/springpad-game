local World = {
    roomx = 0,
    roomy = 0,
    preloaded = {}

    -- backgrounds = {
    --     default = love.graphics.newImage("assets/bg.png")
    -- }
}

-- function World:getBackground()
--     return self.backgrounds.default
-- end

function World:calculateFilename()
    return "assets/maps/room." .. tostring(self.roomx) .. "." .. tostring(self.roomy) .. ".csv"
end

function World:makeMap()
    local map = MapControl.Map(self:calculateFilename(), MapControl.Tileset("assets/maps/tileset.png", 8), Solids)
    return map
end

function World:addEntities()
    Entities:flush()

    local levelString = tostring(self.roomx) .. "." .. tostring(self.roomy)
    if LevelEntityTable[levelString] == nil then
        return
    end

    for _, data in pairs(LevelEntityTable[levelString]) do
        if EntityIndex[data[1]] then
            data.roomx = self.roomx
            data.roomy = self.roomy
            print("adding a " .. data[1])
            EntityIndex[data[1]](data)
        end
    end
end

function World:move(direction)
    self.roomx = self.roomx + direction.x
    self.roomy = self.roomy + direction.y

    _map = self:makeMap()
    _map:clearCollisions(_bumpWorld)
    _map:addCollisions(_bumpWorld)
    self:addEntities()
end

function World:to(pos)
    self.roomx = pos.x
    self.roomy = pos.y

    _map = self:makeMap()
    _map:clearCollisions(_bumpWorld)
    _map:addCollisions(_bumpWorld)
    self:addEntities()
end

return World
