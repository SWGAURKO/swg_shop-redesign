local QBCore = exports['qb-core']:GetCoreObject()


-- GET PLAYER DATA (for NUI)

QBCore.Functions.CreateCallback('swg_shop:getPlayerData', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb(nil) return end

    local vCoins = Player.PlayerData.metadata['vcoins'] or 0

    cb({
        money = Player.Functions.GetMoney('cash'),
        bank = Player.Functions.GetMoney('bank'),
        blackMoney = Player.Functions.GetMoney('crypto'),
        vCoins = vCoins
    })
end)


-- BUY ITEMS

QBCore.Functions.CreateCallback('swg_shop:buyItems', function(source, cb, marketType, items, paymentMethod)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb(false, "Player not found") return end

    local shop = Config.Markets[marketType]
    if not shop then cb(false, "Invalid shop") return end

    local totalMoney = 0
    local totalVip = 0
    local giveItems = {}


    -- CALCULATE COSTS

    for _, cartItem in pairs(items) do
        local foundItem

        for _, category in pairs(shop.categories) do
            for _, shopItem in pairs(category.items) do
                if shopItem.name == cartItem.item then
                    foundItem = shopItem
                    break
                end
            end
            if foundItem then break end
        end

        if not foundItem then
            cb(false, "Item not found")
            return
        end

        if foundItem.isVip then
            totalVip = totalVip + (foundItem.vipPrice * cartItem.quantity)
        else
            totalMoney = totalMoney + (foundItem.price * cartItem.quantity)
        end

        giveItems[#giveItems + 1] = {
            name = cartItem.item,
            amount = cartItem.quantity
        }
    end


    -- VIP COINS CHECK

    if totalVip > 0 then
        local vCoins = Player.PlayerData.metadata['vcoins'] or 0
        if vCoins < totalVip then
            cb(false, "Not enough VIP coins")
            return
        end
    end


    -- MONEY CHECK
 
    if totalMoney > 0 then
        if shop.type == "illegal" then
            if Player.Functions.GetMoney('crypto') < totalMoney then
                cb(false, "Not enough black money")
                return
            end
        else
            if Player.Functions.GetMoney(paymentMethod) < totalMoney then
                cb(false, "Not enough money")
                return
            end
        end
    end


    -- REMOVE MONEY

    if totalMoney > 0 then
        if shop.type == "illegal" then
            Player.Functions.RemoveMoney('crypto', totalMoney, 'illegal-market')
        else
            Player.Functions.RemoveMoney(paymentMethod, totalMoney, 'market-purchase')
        end
    end


    -- REMOVE VIP COINS (metadata)

    if totalVip > 0 then
        local vCoins = Player.PlayerData.metadata['vcoins'] or 0
        Player.Functions.SetMetaData('vcoins', vCoins - totalVip)
    end

  
    -- GIVE ITEMS

    for _, itemData in pairs(giveItems) do
        Player.Functions.AddItem(itemData.name, itemData.amount)
        TriggerClientEvent(
            'inventory:client:ItemBox',
            source,
            QBCore.Shared.Items[itemData.name],
            'add',
            itemData.amount
        )
    end

    cb(true, "Purchase successful")
end)


-- ADMIN COMMAND 

QBCore.Commands.Add(
    'givevcoins',
    'Give VIP coins to a player',
    {
        { name = 'id', help = 'Player ID' },
        { name = 'amount', help = 'Amount of VIP coins' }
    },
    true,
    function(source, args)
        local target = tonumber(args[1])
        local amount = tonumber(args[2])

        local Player = QBCore.Functions.GetPlayer(target)
        if not Player or not amount then return end

        local current = Player.PlayerData.metadata['vcoins'] or 0
        Player.Functions.SetMetaData('vcoins', current + amount)

        TriggerClientEvent(
            'QBCore:Notify',
            target,
            ('You received %s VIP coins'):format(amount),
            'success'
        )
    end,
    'admin'
)
