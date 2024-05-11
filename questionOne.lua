local   STORAGE_ID = 1000 --setting STORAGE_ID as a constant

--[[
        Altered code from question 4 to handle two different errors and ensure that the correct player type
        was being handled and later cleared.

        Error Handling:
            first one starts on line 11 and ensures the correct player type is being passed
            Second error hanlder starts on line 20 is just printing to console on failure to clear players storage

        Set STORAGE_ID as a constant, allows us to reuse the variable with consitancy in the future

        For onLogout function: 
            I adjsuted the delay parameter to 100 miliseconds rather than 1000, depending on the setup this should
            increase responsiveness but at the least it will decrease the delay between the player logging out and when the
            storage is released
--]]
local function releaseStorage(player)
        --Validate player Parameters
        if not player or not player.setStorageValue then
            print("Error: Invalid player object type")
            return
        end

        local success = player:setStorageValue(STORAGE_ID, -1)

        --write to console if local success fails
        if not success then 
            print("Error: Failed to set storage value" ..player:getName())
            return false
        end
end

function onLogout(player)
    if player:getStorageValue(STORAGE_ID) == 1 then
        addEvent(releaseStorage, 100, player) --delay set to 100 miliseconds
    end
    return true
end