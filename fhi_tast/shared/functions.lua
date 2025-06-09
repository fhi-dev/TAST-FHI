--[[
    shared/functions.lua
    دوال مشتركة للسيرفر والكلينت
]]

function HealAndBuzz(source)
    local QBCore = exports['qb-core']:GetCoreObject()
    if source == nil or source == 0 then
        -- كلينت سايد
        local playerPed = PlayerPedId()
        SetEntityHealth(playerPed, math.min(Config.ReviveAmount, GetEntityMaxHealth(playerPed)))
        QBCore.Functions.Notify(Config.NotifyText, "success")
    else
        -- سيرفر سايد, ارسل للكلينت ينفذ الهيل
        TriggerClientEvent('fhi_bots:healAndBuzz', source)
    end
end