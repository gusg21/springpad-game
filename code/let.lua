local gridSize = 8

return {
    ["-3.-4"] = {
        {"Enemy2", x = 3 * gridSize, y = 5 * gridSize}
    },
    ["-3.-1"] = {
        {"Enemy2", x = 3 * gridSize, y = 5 * gridSize}
    },
    ["-2.-4"] = {
        {"Reward", x = 3 * gridSize, y = 7 * gridSize}
    },
    ["-2.-1"] = {
        {"Reward", x = 3 * gridSize, y = 7 * gridSize}
    },
    ["-2.2"] = {
        {"Hammer Powerup", x = 5 * gridSize, y = 7 * gridSize}
    },
    ["-1.-2"] = {
        {"Reward", x = 2 * gridSize, y = 2 * gridSize}
    },
    ["-1.-1"] = {
        {"Passthrough Powerup", x = 6 * gridSize, y = 8 * gridSize}
    },
    ["-1.2"] = {
        {"Enemy1", x = 6 * gridSize, y = 4 * gridSize},
        {"Block", x = 5 * gridSize, y = 2 * gridSize},
        {"Block", x = 5 * gridSize, y = 3 * gridSize},
        {"Block", x = 5 * gridSize, y = 4 * gridSize}
    },
    ["0.1"] = {
        {"Reward", x = 3 * gridSize, y = 5 * gridSize}
    },
    ["1.-5"] = {
        {"Davey Cutscene 2"}
    },
    ["2.0"] = {
        {"Block", x = 8 * gridSize, y = 1 * gridSize},
        {"Block", x = 8 * gridSize, y = 2 * gridSize},
        {"Block", x = 8 * gridSize, y = 3 * gridSize},
        {"Block", x = 8 * gridSize, y = 4 * gridSize}
    },
    ["2.-1"] = {
        {"Block", x = 8 * gridSize, y = 0 * gridSize},
        {"Block", x = 8 * gridSize, y = 1 * gridSize},
        {"Block", x = 8 * gridSize, y = 2 * gridSize},
        {"Block", x = 8 * gridSize, y = 3 * gridSize},
        {"Block", x = 8 * gridSize, y = 4 * gridSize},
        {"Block", x = 8 * gridSize, y = 5 * gridSize},
        {"Block", x = 8 * gridSize, y = 6 * gridSize},
        {"Block", x = 8 * gridSize, y = 7 * gridSize},
        {"Block", x = 8 * gridSize, y = 8 * gridSize}
    },
    ["2.-2"] = {
        {
            "Door",
            x = 4 * gridSize,
            y = 7 * gridSize,
            targetX = 8 * gridSize,
            targetY = 8 * gridSize + 1,
            targetRoomX = 1,
            targetRoomY = -2
        }
    },
    ["2.-5"] = {
        {"Davey Bot"}
    },
    ["3.-2"] = {
        {"Davey Cutscene 1"}
    },
    ["3.-1"] = {
        {"Macrowave", x = 4, y = 4}
    },
    ["4.-1"] = {
        {"Enemy1 Spawner", x = 0 * gridSize, y = 1 * gridSize}
    },
    ["4.0"] = {
        {"Boost", x = 6 * gridSize, y = 7 * gridSize},
        {"Reward", x = 2 * gridSize, y = 2 * gridSize}
    },
    ["5.-4"] = {
        {"Breakable Painting", blah = "ek"}
    },
    ["5.-1"] = {
        {"Enemy2", x = 8 * gridSize, y = 6 * gridSize}
    },
    ["5.0"] = {
        {"Copier", _ = ""}
    }
}
