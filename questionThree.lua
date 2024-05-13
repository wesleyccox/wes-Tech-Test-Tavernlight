--[[
    From the original question I changed more than a few things. The function name
    has been changed to reflect what process the code is doing

    First we will check if the player exists and display the appropriate message

    Declared party and partymembers outside loop for easier calling and referencing

    checking if the player is in the party and displaying appropriate messages

    Lastly displaying the appropriate messages if the player was removed or not 


--]]
function removePlayerFromParty(playerId, membername)
    player = Player(playerId)

--checking if player exists
    if not player then
        print("Invalid Player")
        return
    end

    party = player:getParty()

    --check if the player currently has a party
    if party then
        print("Player is in party")
    else
        print("PLayer is not in party")
        return
    end

    partyMembers = party:getMembers()
    removed = false
    
    for _,member in pairs(partyMembers) do
        if member:getName() == playerName then
            party:removeMember(Player(member))
            removed = true
            break
        end
    end

    if removed then
        print("Player " .. playerName.. "removed from the Party.")
    else
        print("Error: Player" playerName.. "Not found in current Party")
    end
end