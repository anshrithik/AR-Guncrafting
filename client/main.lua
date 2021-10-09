QBCore = exports['qb-core']:GetCoreObject()
local itemInfos = {}

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local maxDistance = 1.25

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local inRange = false
		local distance = GetDistanceBetweenCoords(pos, Config.gunCrafting["list"].x, Config.gunCrafting["list"].y, Config.gunCrafting["list"].z, true)

	if distance < 10 then
		inRange = true
		if distance < 1.5 then
			--if PlayerJob.name == "mechanic" then 
			    DrawText3D(Config.gunCrafting["list"].x, Config.gunCrafting["list"].y, Config.gunCrafting["list"].z, "~g~E~w~ - Request Items List")
				if IsControlJustPressed(0, 38) then
					QBCore.Functions.Progressbar("darkweb", "Fetching Data Through Dark Web...", 10000, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function() -- Done
						TriggerServerEvent('qb-phone:server:sendNewMail', {
						sender = "Syndicate",
						subject = "Items list",
						message = "<strong>AP Pistol</strong></br>Copper:300</br>Steel:100</br>Iron:250</br>Rubber:200</br>Metalscrap:200</br><strong>Heavy Pistol</strong></br>Copper:100</br>Steel:100</br>Rubber:150</br>Metalscrap:150</br>Aluminum:150</br><strong>Machine Pistol</strong></br>Copper:100</br>Steel:50</br>Iron:150</br>Rubber:150</br>Metalscrap:200</br>Aluminum:200",
						button = {}
					})
				end, function() -- Cancel
					ClearPedTasksImmediately(ped)
				end)
				end
			--end
		end
	end

		if not inRange then
			Citizen.Wait(1000)
		end

		Citizen.Wait(3)
	end
end)


Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local inRange = false
		local distance = GetDistanceBetweenCoords(pos, Config.gunCrafting["location"].x, Config.gunCrafting["location"].y, Config.gunCrafting["location"].z, true)

	if distance < 10 then
		inRange = true
		if distance < 1.5 then
			    DrawText3D(Config.gunCrafting["location"].x, Config.gunCrafting["location"].y, Config.gunCrafting["location"].z, "~g~E~w~ - Gun Crafting")
				if IsControlJustPressed(0, 38) then
					local crafting = {}
					crafting.label = "Gun Crafting"
					crafting.items = GetgunThresholdItems()
					TriggerServerEvent("inventory:server:OpenInventory", "gun_crafting", math.random(1, 99), crafting)
				end
		end
	end

		if not inRange then
			Citizen.Wait(1000)
		end

		Citizen.Wait(3)
	end
end)



function SetupgunItemsInfo()
	itemInfos = {
		[1] = {costs = QBCore.Shared.Items["copper"]["label"] .. ": 300x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 100x, "..QBCore.Shared.Items["iron"]["label"] .. ": 250x." ..QBCore.Shared.Items["rubber"]["label"] .. ": 200x." ..QBCore.Shared.Items["metalscrap"]["label"] .. ": 200x, "},
		[2] = {costs = QBCore.Shared.Items["rubber"]["label"] .. ": 150x, " ..QBCore.Shared.Items["metalscrap"]["label"] .. ": 200x, " ..QBCore.Shared.Items["aluminum"]["label"] .. ": 200x" ..QBCore.Shared.Items["steel"]["label"] .. ": 50x." ..QBCore.Shared.Items["copper"]["label"] .. ": 100x, "},
		[3] = {costs = QBCore.Shared.Items["rubber"]["label"] .. ": 150x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 50x, " ..QBCore.Shared.Items["metalscrap"]["label"] .. ": 150x" ..QBCore.Shared.Items["aluminum"]["label"] .. ": 100x."..QBCore.Shared.Items["copper"]["label"] ..":100x, "},
	}

	local items = {}
	for k, item in pairs(Config.gunCrafting["items"]) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.gunCrafting["items"] = items
end

function GetgunThresholdItems()
	SetupgunItemsInfo()
	local items = {}
	for k, item in pairs(Config.gunCrafting["items"]) do
		if QBCore.Functions.GetPlayerData().metadata["attachmentcraftingrep"] >= Config.gunCrafting["items"][k].threshold then
			items[k] = Config.gunCrafting["items"][k]
			
		end
	end
	return items
end
