local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

local helmet, projector = nil, nil
local hatOn = false

local function loadModel(model)
    local hash = joaat(model)
    if not IsModelValid(hash) then return nil end
    RequestModel(hash, false)
    local timeout = GetGameTimer() + 5000
    while not HasModelLoaded(hash) do
        if GetGameTimer() > timeout then return nil end
        Wait(10)
    end
    return hash
end

local function spawnAndAttach(model, ped, bone, o)
    local hash = loadModel(model)
    if not hash then return nil end
    local obj = CreateObject(hash, GetEntityCoords(ped), true, true, true)
    SetEntityCollision(obj, false, false)
    AttachEntityToEntity(obj, ped, bone, o[1], o[2], o[3], o[4], o[5], o[6], true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(hash)
    return obj
end

local function removeHat()
    for _, obj in ipairs({ helmet, projector }) do
        if obj and DoesEntityExist(obj) then
            DetachEntity(obj, true, true)
            DeleteObject(obj)
        end
    end
    helmet, projector = nil, nil
    hatOn = false
end

local function wearHat()
    local ped = cache.ped
    local bone = GetEntityBoneIndexByName(ped, Config.Bone)
    helmet = spawnAndAttach(Config.HatModel, ped, bone, Config.HatOffset)
    if Config.UseProjector then
        projector = spawnAndAttach(Config.ProjectorModel, ped, bone, Config.ProjectorOffset)
    end
    hatOn = helmet ~= nil
end

RegisterNetEvent('rex-mininghat:client:toggleHat', function()
    if hatOn then
        removeHat()
        lib.notify({ title = locale('cl_hat_title'), description = locale('cl_hat_off'), type = 'inform' })
    else
        wearHat()
        if hatOn then
            lib.notify({ title = locale('cl_hat_title'), description = locale('cl_hat_on'), type = 'success' })
        end
    end
end)

-- remove hat if the item leaves the inventory, the player dies, or logs out
RegisterNetEvent('RSGCore:Client:OnPlayerUnload', removeHat)

CreateThread(function()
    while true do
        Wait(1000)
        if hatOn then
            local ped = cache.ped
            if IsEntityDead(ped) or not RSGCore.Functions.HasItem(Config.Item, 1) then
                removeHat()
            elseif helmet and not IsEntityAttachedToEntity(helmet, ped) then
                -- ped changed (e.g. clothing/model reload): reattach
                removeHat()
                wearHat()
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then removeHat() end
end)
