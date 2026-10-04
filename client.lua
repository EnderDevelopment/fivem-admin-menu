local RageUI = exports['RageUI']
local ESX = exports['es_extended']:getSharedObject()

local function OpenAdminMenu()
    local menu = RageUI.CreateMenu(Config.MenuTitle, Config.MenuSubtitle)
    menu:SetRectangleBanner(Config.MenuColor.r, Config.MenuColor.g, Config.MenuColor.b)

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button('Revive Player', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local playerId = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('ilovanAdmin:revive', playerId)
                end
            })

            RageUI.Button('Heal Player', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local playerId = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('ilovanAdmin:heal', playerId)
                end
            })

            RageUI.Button('Teleport to Player', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local playerId = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('ilovanAdmin:tp', playerId)
                end
            })

            RageUI.Button('Bring Player', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local playerId = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('ilovanAdmin:bring', playerId)
                end
            })

            RageUI.Button('Kick Player', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local playerId = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('ilovanAdmin:kick', playerId)
                end
            })

            RageUI.Button('Ban Player', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local playerId = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('ilovanAdmin:ban', playerId)
                end
            })
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('IlovanAdmin', true)
        end
    end
end

RegisterCommand('admin', function()
    local playerId = GetPlayerServerId(PlayerId())
    ESX.TriggerServerCallback('ilovanAdmin:checkAdmin', function(isAdmin)
        if isAdmin then
            OpenAdminMenu()
        else
            ESX.ShowNotification('You do not have permission to use this command.')
        end
    end, playerId)
end, false)