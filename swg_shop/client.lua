local QBCore = exports['qb-core']:GetCoreObject()

local currentShop = nil
local shopPeds = {}


-- SPAWN SHOP PEDS + QB-TARGET

CreateThread(function()
    for marketType, locations in pairs(Config.Locations) do
        for _, coords in ipairs(locations) do
            local model = joaat(Config.PedModels[marketType])

            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end

            local ped = CreatePed(
                0,
                model,
                coords.x, coords.y, coords.z - 1.0,
                coords.w,
                false,
                true
            )

            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)

            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        label = "Open " .. Config.Markets[marketType].name,
                        icon = "fas fa-shopping-cart",
                        action = function()
                            OpenShop(marketType)
                        end
                    }
                },
                distance = 2.0
            })

            shopPeds[#shopPeds + 1] = ped
            SetModelAsNoLongerNeeded(model)
        end
    end
end)


-- CREATE BLIPS

CreateThread(function()
    Wait(1000) -- wait for map load

    for marketType, locations in pairs(Config.Locations) do
        local blipData = Config.Blips[marketType]

        if blipData and blipData.enabled then
            for _, coords in pairs(locations) do
                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

                SetBlipSprite(blip, blipData.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, blipData.scale)
                SetBlipColour(blip, blipData.color)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(blipData.name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)


-- OPEN SHOP

function OpenShop(marketType)
    currentShop = marketType

    QBCore.Functions.TriggerCallback('swg_shop:getPlayerData', function(playerData)
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openShop",
            shopData = Config.Markets[marketType],
            playerData = playerData
        })
    end)
end


-- CLOSE SHOP (NUI)

RegisterNUICallback('closeShop', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "closeShop" })
    currentShop = nil
    cb('ok')
end)


-- BUY ITEMS (NUI)

RegisterNUICallback('buyItems', function(data, cb)
    if not currentShop then
        cb(false)
        return
    end

    QBCore.Functions.TriggerCallback(
        'swg_shop:buyItems',
        function(success, message)
            if success then
                QBCore.Functions.Notify(message, 'success')
            else
                QBCore.Functions.Notify(message, 'error')
            end

            QBCore.Functions.TriggerCallback(
                'swg_shop:getPlayerData',
                function(playerData)
                    SendNUIMessage({
                        type = "updatePlayerData",
                        playerData = playerData
                    })
                end
            )

            cb(success)
        end,
        currentShop,
        data.items,
        data.paymentMethod
    )
end)


-- CLEANUP ON RESOURCE STOP

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    for _, ped in pairs(shopPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end

    shopPeds = {}
    SetNuiFocus(false, false)
end)
