print("^3[Roll Coal] Initializing Command...^0")

lib.addCommand('coalmenu', {
    help = 'Open the Roll Coal menu',
}, function(source, args, raw)
    -- Check ACE permissions silently
    if IsPlayerAceAllowed(source, 'coal.use') then
        TriggerClientEvent('coal:openMenu', source)
    else
        -- Only show the error notification to the user
        TriggerClientEvent('coal:showError', source)
    end
end)

print("^2[Roll Coal] Command /coalmenu is now registered.^0")