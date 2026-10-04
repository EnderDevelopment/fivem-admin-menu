local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('ilovanAdmin:checkAdmin', function(source, cb, playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        for _, group in ipairs(Config.AdminGroups) do
            if xPlayer.getGroup() == group then
                cb(true)
                return
            end
        end
    end
    cb(false)
end)

RegisterServerEvent('ilovanAdmin:revive')
AddEventHandler('ilovanAdmin:revive', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        TriggerClientEvent('esx_ambulancejob:revive', playerId)
    end
end)

RegisterServerEvent('ilovanAdmin:heal')
AddEventHandler('ilovanAdmin:heal', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.triggerEvent('esx_basicneeds:healPlayer')
    end
end)

RegisterServerEvent('ilovanAdmin:tp')
AddEventHandler('ilovanAdmin:tp', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local coords = xPlayer.getCoords(true)
        TriggerClientEvent('esx:teleport', playerId, coords.x, coords.y, coords.z)
    end
end)

RegisterServerEvent('ilovanAdmin:bring')
AddEventHandler('ilovanAdmin:bring', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local adminId = source
        local adminCoords = GetEntityCoords(GetPlayerPed(adminId))
        TriggerClientEvent('esx:teleport', playerId, adminCoords.x, adminCoords.y, adminCoords.z)
    end
end)

RegisterServerEvent('ilovanAdmin:kick')
AddEventHandler('ilovanAdmin:kick', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        DropPlayer(playerId, 'You have been kicked by an administrator.')
    end
end)

RegisterServerEvent('ilovanAdmin:ban')
AddEventHandler('ilovanAdmin:ban', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        MySQL.Async.execute('INSERT INTO banned (identifier, reason) VALUES (@identifier, @reason)', {
            ['@identifier'] = xPlayer.identifier,
            ['@reason'] = 'Banned by an administrator.'
        }, function(rowsChanged)
            DropPlayer(playerId, 'You have been banned by an administrator.')
        end)
    end
end)