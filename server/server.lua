-- Anti-Wanted System - Server Side
local antiWantedActive = true

-- Broadcast wanted level removal to all players periodically
Citizen.CreateThread(function()
    while antiWantedActive do
        TriggerClientEvent('antiWanted:clearWantedLevel', -1)
        Wait(500)
    end
end)

-- Optional command to toggle system server-side
RegisterCommand('toggleantiwanted_admin', function(source, args, rawCommand)
    antiWantedActive = not antiWantedActive
    local status = antiWantedActive and 'enabled' or 'disabled'
    TriggerClientEvent('chat:addMessage', -1, {
        color = {0, 255, 0},
        multiline = true,
        args = {'Anti-Wanted [Admin]', 'System ' .. status}
    })
    print('^2Anti-Wanted System^7 - ' .. status .. ' by admin')
end, false)

print('^2Anti-Wanted System^7 - Server loaded successfully')
