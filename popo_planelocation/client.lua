ESX = nil
local time = 3600-- 1 heure
local vehicle = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()

    for zoneKey, zoneValues in pairs(Config.plane) do
        local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
        SetBlipSprite(blip, 307)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Location d'avion")
        EndTextCommandSetBlipName(blip)
    end
  
end)

--Afficher le point s'il est loin ou non--

Citizen.CreateThread(function()
    while true do
        for i, v in pairs(Config.plane) do
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(pos, v.Pos.x, v.Pos.y, v.Pos.z, true)
    
            if distance > 30 then
                interval = 200
            else
                DrawMarker(25, v.Pos.x, v.Pos.y, (v.Pos.z - 0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, false, true, 2, false, false, false, false)
                interval = 1
                if distance < 3 then
                    AddTextEntry("LOCA", "Appuyez sur [~b~E~w~] pour louer un Avion ( Dodo ).")
                    DisplayHelpTextThisFrame("LOCA", false)
                    if IsControlJustPressed(1, 51) then
                        TriggerServerEvent('popo_loca:plane', 250)
                        spawnplane("dodo", v.SpawnPoint)
                        time_plane()
                    end
                end
            end            
        end
        Citizen.Wait(interval)
    end  
end)


Citizen.CreateThread(function()
    while true do
        for i, v in pairs(Config.plane) do
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(pos, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true)
    
            if distance > 30 then
                interval = 200
            else
                DrawMarker(33, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, (v.DeletePoint.Pos.z + 0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, false, true, 2, false, false, false, false)
                interval = 1
                if distance < 3 then
                    AddTextEntry("DEL", "Appuyez sur [~b~E~w~] pour rendre l'avion")
                    DisplayHelpTextThisFrame("DEL", false)
                    if IsControlJustPressed(1, 51) then
                        time = 0
                        ESX.ShowNotification("~g~ Vous avez rendu l'avion de Location")
                        DeleteVehicle(vehicle)
                    end
                end
            end            
        end
        Citizen.Wait(interval)
    end  
end)


function time_plane()
    time = 3600
    while (time ~= 0) do
        Wait( 1000 ) -- Wait a second
        time = time - 1
        -- 1 Second should have past by now
        if time == 500 then
            ESX.ShowNotification("~r~ Vous rendez l'avion de location dans 10 minutes ! Ne soyez pas en retard !")
        end
        if time == 1 then
            TriggerServerEvent('popo_planeloca:retard', 1000)
        end
    end
end


--Spawn le véhicule--

function spawnplane(car, spawn)
    local car = GetHashKey(car)
    

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    vehicle = CreateVehicle(car, spawn.Pos.x, spawn.Pos.y, spawn.Pos.z, spawn.Heading, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LOCA") 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end