ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('bob_craft_drugs:coke')
AddEventHandler('bob_craft_drugs:coke', function()
local player = ESX.GetPlayerFromId(source)
		player.addInventoryItem('coke', 1)
        TriggerClientEvent("esx:showNotification", source, "~g~You packaged ~w~Coke.")
end)

RegisterServerEvent('bob_craft_drugs:meth')
AddEventHandler('bob_craft_drugs:meth', function()
local player = ESX.GetPlayerFromId(source)
		player.addInventoryItem('meth', 1)
        TriggerClientEvent("esx:showNotification", source, "~g~You packaged ~b~Meth.")
end)

RegisterServerEvent('bob_craft_drugs:checkSupplies')
AddEventHandler('bob_craft_drugs:checkSupplies', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local chemicalsQuantity = xPlayer.getInventoryItem('chemicals').count
	
	if chemicalsQuantity >= 1 then
		local methQuantity = xPlayer.getInventoryItem('meth').count
			if methQuantity < 100 then
				xPlayer.removeInventoryItem("chemicals", 1)
				TriggerClientEvent('bob_craft_drugs:success', source)
			else
				TriggerClientEvent('esx:showNotification', source, '~r~You cant carry more meth.')
			end
	else
		TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough Supplies.')	
	end	

end)

RegisterServerEvent('bob_craft_drugs:getMeth')
AddEventHandler('bob_craft_drugs:getMeth', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local randomMeth = math.random(5, 10)
	TriggerClientEvent('esx:showNotification', source, 'You cooked Meth x '.. randomMeth)
	xPlayer.addInventoryItem('meth', randomMeth)
	
end)

RegisterServerEvent('bob_craft_drugs:getMethlab')
AddEventHandler('bob_craft_drugs:getMethlab', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	TriggerClientEvent('esx:showNotification', source, 'You picked up the Methlab')
	xPlayer.addInventoryItem('methlab', 1)
	
end)

ESX.RegisterUsableItem('methlab', function(source)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem('methlab', 1)
TriggerClientEvent("bob_craft_drugs:spawnMethlab", source)
end)
