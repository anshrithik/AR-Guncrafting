# AR-Guncrafting
A Qbus-Based Guncrafting Revamped from the Basic Qbus Crafting.
_Plug and Play Script !!_

**You can configure all the location and customise all the items as per your needs. Everthing you need to edit is in the Config.lua**
**Just Start the resource in Server.cfg -- start AR-Guncrafting**

**Add this to your Inventory Script config.lua file -**

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
}
```
**Add this to your Inventory Script client side file (around line 500) -**
```
RegisterNetEvent('inventory:client:Craftgun')
AddEventHandler('inventory:client:Craftgun', function(itemName, itemCosts, amount, toSlot, points)
    SendNUIMessage({
        action = "close",
    })
    isCrafting = true
    QBCore.Functions.Progressbar("repair_vehicle", "Crafting..", (math.random(20000, 50000) * amount), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("inventory:server:Craftgun", itemName, itemCosts, amount, toSlot, points)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[itemName], 'add')
      
        isCrafting = false
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Canceled!", "error")
        isCrafting = false
    end)
end)
```
**Add this to your Inventory Script server side file -**
(around line 65)
```
RegisterServerEvent('inventory:server:Craftgun')
AddEventHandler('inventory:server:Craftgun', function(itemName, itemCosts, amount, toSlot, points)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    if itemName ~= nil and itemCosts ~= nil then
        for k, v in pairs(itemCosts) do
            Player.Functions.RemoveItem(k, (v*amount))
        end
        Player.Functions.AddItem(itemName, amount, toSlot)
        Player.Functions.SetMetaData("guncraftingrep", Player.PlayerData.metadata["guncraftingrep"]+(points*amount))
        TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
    end
end)
```
(around line 273)
```
elseif name == "gun_crafting" then
                secondInv.name = "gun_crafting"
                secondInv.label = other.label
                secondInv.maxweight = 900000
                secondInv.inventory = other.items
                secondInv.slots = #other.items
```
(around line 899)
```
elseif fromInventory == "gun_crafting" then
        local itemData = Config.gunCrafting["items"][fromSlot]
        if hasCraftItems(src, itemData.costs, fromAmount) then
            TriggerClientEvent("inventory:client:Craftgun", src, itemData.name, itemData.costs, fromAmount, toSlot, itemData.points)
        else
            TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
            TriggerClientEvent('QBCore:Notify', src, "You don't have the right items..", "error")
        end	
	else
```

**Note -** Whatever you change/update in the config.lua file, make sure to change/update it on the Inventory's config,lua file.

