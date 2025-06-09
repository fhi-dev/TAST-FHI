--[[
    server/main.lua
    سكربت السيرفر لاستقبال طلبات الهيل من الكلينت وتشغيل الفنكشن
]]

RegisterNetEvent('fhi_bots:serverHealMe', function()
    local src = source
    HealAndBuzz(src)
end)