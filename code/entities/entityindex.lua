local Test = require("entities.test")
local Collectable = require("entities.collectable")
local Explosion = require("entities.explosion")
local Particles = require("entities.particles")

local Passthrough = require("entities.powerups.passthrough")
local HammerPowerup = require("entities.powerups.hammer")
local Boost = require("entities.powerups.boost")

local Hammer = require("entities.gameplay.hammer")
local Reward = require("entities.gameplay.reward")
local Block = require("entities.gameplay.block")
local BreakablePainting = require("entities.gameplay.breakablepainting")

local Enemy1 = require("entities.enemies.enemy1")
local Enemy1Spawner = require("entities.enemies.enemy1spawner")
local Enemy2 = require("entities.enemies.enemy2")

local Macrowave = require("entities.bosses.macrowave")
local MacroAttack = require("entities.bosses.macroattack")
local MacroWall = require("entities.bosses.macrowall")
local Copier = require("entities.bosses.copier")
local CopierAttack = require("entities.bosses.copierattack")
local CopierWeight = require("entities.bosses.copierweight")
local CopierWall = require("entities.bosses.copierwall")
local DaveyBot = require("entities.bosses.daveybot")
local DaveyFloor = require("entities.bosses.daveyfloor")
local DaveyShot = require("entities.bosses.daveyshot")
local BigDaveyShot = require("entities.bosses.bigdaveyshot")

local Cutscene1 = require("entities.cutscenes.cutscene1")
local Cutscene2 = require("entities.cutscenes.cutscene2")
local SecretDaveyCutscene = require("entities.cutscenes.secretcutscene")

local Door = require("entities.other.door")

EntityImages = {
    ["Passthrough Powerup"] = love.graphics.newImage("assets/passthrough.png"),
    ["Boost"] = love.graphics.newImage("assets/boost.png"),
    ["Reward"] = love.graphics.newImage("assets/reward.png"),
    ["Block"] = love.graphics.newImage("assets/block.png"),
    ["Macro Attack"] = love.graphics.newImage("assets/macroattack.png"),
    ["Davey"] = love.graphics.newImage("assets/davey.png"),
    ["Copier"] = love.graphics.newImage("assets/copier.png"),
    ["Copier Attack"] = MapControl.Tileset("assets/paperattack.png", 8),
    ["Copier Weight"] = love.graphics.newImage("assets/copierweight.png"),
    ["Copier Wall"] = love.graphics.newImage("assets/copierwall.png"),
    ["Davey Floor"] = love.graphics.newImage("assets/daveyfloor.png")
}

EntityIndex = {
    ["Test"] = Test,
    ["Collectable"] = Collectable,
    ["Explosion"] = Explosion,
    ["Particles"] = Particles,
    ["Passthrough Powerup"] = Passthrough,
    ["Hammer Powerup"] = HammerPowerup,
    ["Boost"] = Boost,
    ["Hammer"] = Hammer,
    ["Reward"] = Reward,
    ["Block"] = Block,
    ["Breakable Painting"] = BreakablePainting,
    ["Enemy1"] = Enemy1,
    ["Enemy1 Spawner"] = Enemy1Spawner,
    ["Enemy2"] = Enemy2,
    ["Macrowave"] = Macrowave,
    ["Macro Attack"] = MacroAttack,
    ["Macro Wall"] = MacroWall,
    ["Copier"] = Copier,
    ["Copier Attack"] = CopierAttack,
    ["Copier Weight"] = CopierWeight,
    ["Copier Wall"] = CopierWall,
    ["Davey Bot"] = DaveyBot,
    ["Davey Floor"] = DaveyFloor,
    ["Davey Cutscene 1"] = Cutscene1,
    ["Davey Cutscene 2"] = Cutscene2,
    ["Davey Secret Cutscene"] = SecretDaveyCutscene,
    ["Davey Shot"] = DaveyShot,
    ["Big Ol' Davey Shot"] = BigDaveyShot,
    ["Door"] = Door
}
