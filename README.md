# AR-Guncrafting
A Qbus-Based Guncrafting Revamped from the Basic Qbus Crafting.

Add this to your Inventory Script config.lua file -

```Config.gunCrafting = {
    ["location"] = {x = 905.83, y = -3230.74, z = -98.29, h = 185.54, r = 1.0},
    ["list"] = {x = 908.61, y = -3207.35, z = -97.01, h = 203.63, r = 1.0},
    ["items"] = {
        [1] = {
            name = "weapon_appistol",
            amount = 1,
            info = {},
            costs = {
                ["copper"] = 300,
                ["steel"] = 100,
                ["iron"] = 250,
                ["rubber"] = 200,
                ["metalscrap"] = 200,
            },
            type = "weapon",
            slot = 1,
            threshold = 0,
            points = 1,
        },
        [2] = {
            name = "weapon_machinepistol",
            amount = 1,
            info = {},
            costs = {
                ["rubber"] = 150,
                ["metalscrap"] = 200,
                ["aluminum"] = 200,
                ["iron"] = 150,
                ["steel"] = 50,
                ["copper"] = 100,
            },
            type = "weapon",
            slot = 2,
            threshold = 0,
            points = 1,
        },
        [3] = {
            name = "weapon_heavypistol",
            amount = 1,
            info = {},
            costs = {
                ["rubber"] = 150,
                ["steel"] = 100,
                ["metalscrap"] = 150,
                ["aluminum"] = 150,
                ["copper"] = 100,
            },
            type = "weapon",
            slot = 3,
            threshold = 0,
            points = 1,
        },
    }
}```
