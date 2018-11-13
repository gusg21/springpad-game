io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")
_loveDefaultFont = love.graphics.getFont()

class = require("libs.middleclass")
lb = require("libs.lovebird")
lb.game_name = "Springpad"
lb.game_version = "0"
D = require("utils.debugkit")
Vector = require("libs.vector")
_font = love.graphics.newImageFont("assets/font.png", "DEABCFGHIJKLMNOPQRSTUVWXYZ .?:1234567890()',!abcdefghijklmnopqrstuvwxyz+", 1)

require("utils.functions")

Gamestate = require("libs.gamestate")

Game = require("states.game")
Menu = require("states.mainmenu")
Credits = require("states.credits")

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(Menu)
end