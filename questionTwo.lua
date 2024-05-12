--[[ 
    For the original question it would have gathered the guildName of just one guild that fit
    in the parameters, whereas now it should loop through until there are no more guildNames that satisfy 
    the selectGuildQuery. The loop should properly display the guild names but also give the correct messages to the terminal
    so there is no confusion for No guilds found and No more guilds to be found
    
    I also moved the string.format call to be outside the database call
--]]
function printSmallGuildNames(memberCount)
    --This method will print all the names of guilds with a memberCount less than memberCount max members
    local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
    local result = db.storageQuery(selectGuildQuery)

    if result then
        local guildName = result.getString("name")
        print(guildName)
        --iterate through the remaining results if there are any, if no more guilds found then the appropriate message will display
        if result.next() ~= nil
            guildName = result.getString("name")
            print(guildName)
        else
            print("All guilds found")
        end
    else
        print("Error: No guilds found")
    end
end