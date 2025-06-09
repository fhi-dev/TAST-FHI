--[[
    client/main.lua
    سكربت بوتين:
    - بوت عن طريق التارقت (qb-target)
    - بوت عن طريق الانركت (زر E)
    عند الضغط على أي بوت يعطيك هيل (انعاش) وبلبز (صوت)
]]

local QBCore = exports['qb-core']:GetCoreObject()

-- استدعاء دالة الهيل من ملف الفنكشن
RegisterNetEvent('fhi_bots:healAndBuzz', function()
    HealAndBuzz()
    -- صوت نبض أو تأثير (بلبز) إذا عندك InteractSound
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, Config.ReviveSound, 0.5)
end)

-- بوت التارقت (qb-target)
CreateThread(function()
    exports['qb-target']:AddBoxZone('healer_bot_target', Config.TargetBotCoords, 1.2, 1.2, {
        name = 'healer_bot_target',
        heading = 0,
        debugPoly = false,
        minZ = Config.TargetBotCoords.z - 0.6,
        maxZ = Config.TargetBotCoords.z + 1.0
    }, {
        options = {
            {
                icon = 'fas fa-heartbeat',
                label = Config.TargetLabel,
                action = function()
                    TriggerServerEvent('fhi_bots:serverHealMe')
                end
            }
        },
        distance = 2.0
    })
end)

-- بوت الانركت (زر E)
CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if #(playerCoords - Config.InteractBotCoords) < 2.0 then
            DrawText3D(Config.InteractBotCoords.x, Config.InteractBotCoords.y, Config.InteractBotCoords.z + 1.0, Config.InteractLabel)
            if IsControlJustReleased(0, 38) then -- زر E
                TriggerServerEvent('fhi_bots:serverHealMe')
                Wait(1000)
            end
        end
    end
end)

-- دالة رسم نص ثلاثي الأبعاد
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end