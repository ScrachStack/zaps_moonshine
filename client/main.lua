CreateThread(function()
    while true do
        Citizen.Wait(0)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        
        local isNearStill = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, joaat(Config.brewProp), true)
        local isNearBarrel = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, joaat(Config.mashProp), true)
        if isNearStill  then
            DrawTxt(Config.Translation.createAlcohol, 0.50, 0.75, 1.9, 0.5, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0xCEFD9220) then
                TriggerEvent('moonshine:brewAlcohol')
            end
            DrawTxt(Config.Translation.destroyStill, 0.50, 0.85, 0.7, 0.5, true, 255, 0, 0, 255, true)
            if IsControlJustReleased(0, 0x3B24C470) then  
                TriggerEvent('moonshine:destroyStill')
            end        
        elseif isNearBarrel then
            DrawTxt(Config.Translation.createMash, 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then
                TriggerEvent('moonshine:createMash')
            end
        end
    end
end)
RegisterNetEvent('moonshine:brewAlcohol')
AddEventHandler('moonshine:brewAlcohol', function()
    Citizen.CreateThread(function()
while not HasAnimDictLoaded('script_re@moonshine_camp@player_put_in_herbs') do
    RequestAnimDict('script_re@moonshine_camp@player_put_in_herbs')
    Citizen.Wait(100)
end

local animDict = "script_re@moonshine_camp@player_put_in_herbs"
local animName = "put_in_still" 
TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
Citizen.Wait(Config.brewTime)

TriggerServerEvent('moonshine:server:brew')
    end)
end)
RegisterNetEvent('moonshine:createMash')
AddEventHandler('moonshine:createMash', function()
    Citizen.CreateThread(function()
        Citizen.Wait(Config.mashTime)
    end)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

RegisterNetEvent('moonshine:destroyStill')
AddEventHandler('moonshine:destroyStill', function()
    while not HasAnimDictLoaded('mini_games@story@beechers@build_floor@john') do
        RequestAnimDict('mini_games@story@beechers@build_floor@john')
        Citizen.Wait(100)
    end

    local animDict = "mini_games@story@beechers@build_floor@john"
local animName = "intro_pickup" 
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local stillObj = GetClosestObjectOfType(x, y, z, 1.5, joaat(Config.brewProp), false, false, false)
    if stillObj and stillObj ~= 0 then
       TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
Wait(2000)
        SetEntityAsMissionEntity(stillObj, true, true)
        DeleteEntity(stillObj)
    end
end)

RegisterNetEvent('moonshine:client:placeStill')
AddEventHandler('moonshine:client:placeStill', function()
 
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local forward = GetEntityForwardVector(playerPed)
    local x, y, z = table.unpack(pos + forward * 2) 

    local object = CreateObject(joaat(Config.brewProp), x, y, z, true, false, true)  
    SetEntityHeading(object, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(object)
end)

RegisterCommand('placestill', function()
TriggerEvent('moonshine:client:placeStill')

end, false)
