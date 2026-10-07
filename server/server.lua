local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

RSGCore.Functions.CreateUseableItem(Config.Item, function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    if not Player.Functions.GetItemByName(Config.Item) then return end
    TriggerClientEvent('rex-mininghat:client:toggleHat', source)
end)
