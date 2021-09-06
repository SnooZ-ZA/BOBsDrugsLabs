ESX        = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
percent    = false
searching  = false

closestCoke = {
	"bkr_prop_coke_tablepowder",
}
closestMeth = {
	"v_ret_ml_tableb",
	"v_ret_ml_tablec"
}
closestMethlab = {
	"v_ret_ml_tablea"
}

Citizen.CreateThread(function()

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestCoke do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestCoke[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                Coke   = GetEntityCoords(entity)
				drawText3D(Coke.x, Coke.y, Coke.z + 1.1, '⚙️')		
                while IsControlPressed(0, 38) do
                drawText3D(Coke.x, Coke.y, Coke.z + 1.0, 'Press [~g~H~s~] to package ~b~ Coke ~s~')
				break
				end	
                if IsControlJustReleased(0, 74) then
					searching  = true
                    exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 17000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "PACKAGING COKE",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								--scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "anim@amb@business@coc@coc_unpack_cut_left@", -- https://alexguirre.github.io/animations-list/
								animationName = "coke_cut_v5_coccutter",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
				Citizen.Wait(17000)
				searching  = false
				TriggerServerEvent('bob_craft_drugs:coke')
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestMeth do
            local y = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestMeth[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(y) then
                sleep  = 5
                entity = y
                Meth   = GetEntityCoords(entity)
				drawText3D(Meth.x, Meth.y, Meth.z + 1.1, '⚙️')		
                while IsControlPressed(0, 38) do
                drawText3D(Meth.x, Meth.y, Meth.z + 1.0, 'Press [~g~H~s~] to package ~b~Meth~s~')
				break
				end	
                if IsControlJustReleased(0, 74) then
					searching  = true
                    exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 15000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "PACKAGING METH",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								--scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "anim@amb@business@meth@meth_smash_weight_check@", -- https://alexguirre.github.io/animations-list/
								animationName = "break_weigh_v3_char01",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
				Citizen.Wait(15000)
				searching  = false
				TriggerServerEvent('bob_craft_drugs:meth')
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestMethlab do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestMethlab[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                Methlab   = GetEntityCoords(entity)
				drawText3D(Methlab.x, Methlab.y, Methlab.z + 0.4, '⚙️')
                while IsControlPressed(0, 38) do
                drawText3D(Methlab.x, Methlab.y, Methlab.z + 0.2, '[~g~H~s~] to cook. [~b~F~s~] to pickup.')
				break
				end
                if IsControlJustReleased(0, 74) then
				TriggerServerEvent('bob_craft_drugs:checkSupplies')
				elseif IsControlJustReleased(0, 23) and DoesEntityExist(entity) then
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				Citizen.Wait(3000)
				DeleteObject(entity)
				TriggerServerEvent('bob_craft_drugs:getMethlab')
				ClearPedTasks(PlayerPedId())
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('bob_craft_drugs:success')
AddEventHandler('bob_craft_drugs:success', function (source)	
		searching  = true
		local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
		for i = 1, #closestMethlab do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestMethlab[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                Methlab   = GetEntityCoords(entity)
		--smoke
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", Methlab.x, Methlab.y, Methlab.z + 0.1, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		--Citizen.Wait(15000)
		
		--smoke-end
		
		exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 15000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "COOKING METH",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								--scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								animationDictionary = "anim@amb@business@meth@meth_smash_weight_check@", -- https://alexguirre.github.io/animations-list/
								animationName = "break_weigh_v3_char01",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
				Citizen.Wait(15000)
				StopParticleFxLooped(smoke, 0)
					end
				end
				searching  = false
				TriggerServerEvent('bob_craft_drugs:getMeth')	
		
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if searching then
            DisableControlAction(0, 38) 
			DisableControlAction(0, 47)
			DisableControlAction(0, 74)
        end
    end
end)

RegisterNetEvent('bob_craft_drugs:spawnMethlab')
AddEventHandler('bob_craft_drugs:spawnMethlab', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	Citizen.Wait(3000)
	ClearPedTasks(PlayerPedId())
    AddMethlab()
end)


function AddMethlab()
	local ped= PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.2, 0.0)
    local heading = GetEntityHeading(ped)
	local pedcoords = GetEntityCoords(ped)

		local methlabinfo = {
            x= coords.x,
            y= coords.y,
            z= coords.z,
            h= heading,
            propid=0,
            }

            local ModelHash = GetHashKey('v_ret_ml_tablea')
            local Prop = CreateObject(ModelHash, 0, 0, 0, true, true, true)
            methlabinfo.propid = Prop
                SetEntityCoords(Prop, methlabinfo.x, methlabinfo.y, methlabinfo.z-0.25, 0, 0, 0, false)
                SetEntityHeading(Prop, methlabinfo.h)
                FreezeEntityPosition(methlabinfo.propid, true)
    check = true
end
