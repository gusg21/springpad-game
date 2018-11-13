parseCsv = require("libs.csv")

local MapControl = {}

------------------------------
-- TILESET
------------------------------
local Tileset = class("Tileset")

cachedSets = {}

function Tileset:initialize(image, tilesize)
    if not cachedSets[image .. "--" .. tostring(tilesize)] then
        self.image = love.graphics.newImage(image)
        self.tilesize = tilesize

        cachedSets[image .. "--" .. tostring(tilesize)] = self
    else
        print("loading cache")
        self.image = cachedSets[image .. "--" .. tostring(tilesize)].image
        self.tilesize = cachedSets[image .. "--" .. tostring(tilesize)].tilesize
    end
end

function Tileset:getQuadById(id)
    local x = (id * self.tilesize) % self.image:getWidth()
    local y = math.floor((id * self.tilesize) / self.image:getWidth()) * self.tilesize

    return love.graphics.newQuad(x, y, self.tilesize, self.tilesize, self.image:getDimensions())
end

function Tileset:drawTile(id, x, y)
    love.graphics.draw(self.image, self:getQuadById(id), x, y)
end

------------------------------
-- MAP
------------------------------
local Map = class("Map")

function Map:initialize(target, tileset, solids)
    self.solids = solids or {["0"] = 0}
    self.data = parseCsv(target)
    self.tileset = tileset

    self:render()
end

function Map:addCollisions(world)
    for tx = 0, #self.data[1] do
        for ty = 0, #self.data do
            local currentChar = self.data[ty + 1]
            if currentChar ~= nil then
                currentChar = currentChar[tx + 1]
                if self.solids[tonumber(currentChar)] ~= nil then
                    local tile = {isTile = true, properties = table.copy(self.solids[tonumber(currentChar)])}
                    world:add(
                        tile,
                        tx * self.tileset.tilesize,
                        ty * self.tileset.tilesize,
                        self.tileset.tilesize,
                        self.tileset.tilesize
                    )
                end
            end
        end
    end

    return world
end

function Map:removeTile(x, y)
    self.data[y + 1][x + 1] = -1
    self:render()
end

function Map:clearCollisions(world)
    for _, item in pairs(world:getItems()) do
        if item.isTile == true then
            world:remove(item)
        end
    end
end

function Map:render()
    local tx = 0
    local ty = 0
    for _, row in pairs(self.data) do
        for _, char in pairs(row) do
            if tonumber(char) ~= nil and tonumber(char) >= 0 then
                self.tileset:drawTile(tonumber(char), tx * self.tileset.tilesize, ty * self.tileset.tilesize)
            end
            tx = tx + 1
        end
        tx = 0
        ty = ty + 1
    end
end

function Map:draw(x, y)
    x = x or 0
    y = y or 0

    self:render()
end

MapControl.Tileset = Tileset
MapControl.Map = Map

return MapControl
