ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('oblackDc:pSoin')
AddEventHandler('oblackDc:pSoin', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(150)
end)

RegisterServerEvent('oblackDc:gSoin')
AddEventHandler('oblackDc:gSoin', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(700)
end)

RegisterNetEvent("myevent:soundStatus")
AddEventHandler("myevent:soundStatus", function(type, musicId, data)
    TriggerClientEvent("myevent:soundStatus", -1, type, musicId, data)
end)

---------------------------------
--- Copyright by OBlack#0001 ---
---------------------------------