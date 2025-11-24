
-- Anti-Wanted System - Client Side
local antiWantedActive = true

-- Function to remove wanted level
local function removeWantedLevel()
    if GetPlayerWantedLevel(PlayerId()) > 0 then
        ClearPlayerWantedLevel(PlayerId())
    end
end

-- Function to disable wanted system HUD elements
local function disableWantedHUD()
    -- Disable the wanted level display
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentString('~s~')
    EndTextCommandDisplayHelp(0, false, true, -1)
    
    -- Hide the wanted star HUD
    SetMaxWantedLevel(0)
end

-- Main loop to continuously monitor and remove wanted levels
Citizen.CreateThread(function()
    while antiWantedActive do
        removeWantedLevel()
        SetMaxWantedLevel(0) -- Ensure max wanted level is 0
        Wait(100) -- Check every 100ms
    end
end)

-- Listen for wanted level changes
RegisterNetEvent('antiWanted:clearWantedLevel', function()
    removeWantedLevel()
end)

-- Optional command to toggle anti-wanted system
RegisterCommand('toggleantiwanted', function(source, args, rawCommand)
    antiWantedActive = not antiWantedActive
    if antiWantedActive then
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {'Anti-Wanted', 'System enabled'}
        })
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {'Anti-Wanted', 'System disabled'}
        })
    end
end, false)

print('^2Anti-Wanted System^7 - Client loaded successfully')
