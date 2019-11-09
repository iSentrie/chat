# Mythic Chat
This is a chat script made for Mythic RP, it is a heavily modified version of the base FiveM chat aswell as using the base styling from KrizFrost's Font Awesome Chat resource.

This chat is fully integrated with Mythic Framework for using its permissions aswell as using jobs & job grades.

![Mythic Chat](https://i.imgur.com/Arun56F.png)

Dependencies :
- Mythic Base - NOT PUBLICLY RELEASED
- Mythic Pwnzor - NOT PUBLICLY RELEASED
- Mythic Jobs [For 311 & 911] - NOT PUBLICLY RELEASED

>NOTE: As with most MythicRP releases at this point, this has several calls to Mythic Framework resources that have not (and may not) released publicly. This is intended as a **dev resource** at most and not a simple drag & drop to use on public servers. **Do not make any issues asking for it to be made to work on a public framework or why it isn't plug n' play.**

# WARNING
This chat script shouldn't be used unless you know what you're doing to strip out the permission & job check from my framework stuff. These checks are done in 2 places, one when handling suggestions (in server/sv_chat.lua) and when actually using commands (in server/commands.lua)

## 311 & 911 Commands
There are a few messages that need extra implementation to function, those would be 911 & 311. Below are my direct AddChatCommand calls which you can see make calls to client-events because I am getting the users positional stuff to dispaly on the alert.

```lua
AddChatCommand('311', function(source, args, rawCommand)
    local mPlayer = exports['mythic_base']:GetComponent('Fetch'):Source(source)
    local name = mPlayer:GetVar('character'):getName()
    fal = name.first .. " " .. name.last
    local msg = rawCommand:sub(5)
    TriggerClientEvent('mythic_jobs:client:Do311Alert', source, fal, msg)
end, {
    help = "Non-Emergency Line",
    params = {{
            name = "Message",
            help = "The Message You Want To Send To 311 Channel"
        }
    }
}, -1)

AddChatCommand('911', function(source, args, rawCommand)
    local mPlayer = exports['mythic_base']:GetComponent('Fetch'):Source(source)
    local name = mPlayer:GetVar('character'):getName()
    fal = name.first .. " " .. name.last
    local msg = rawCommand:sub(5)
    TriggerClientEvent('mythic_jobs:client:Do911Alert', source, fal, msg)
end, {
    help = "Emergency Line",
    params = {{
            name = "Message",
            help = "The Message You Want To Send To 911 Channel"
        }
    }
}, -1)
```

And the client-side calls that're being made :

```lua
RegisterNetEvent("mythic_jobs:client:Do311Alert")
AddEventHandler("mythic_jobs:client:Do311Alert", function(name, message)
	local locale = ""
	
	local pos = GetEntityCoords(PlayerPedId())
	local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local current_zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))

	if GetStreetNameFromHashKey(var2) == "" then
		locale = GetStreetNameFromHashKey(var1) .. ' ' .. current_zone
	else
		locale = GetStreetNameFromHashKey(var1) .. ' ' ..GetStreetNameFromHashKey(var2) .. ' ' .. GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
	end

	TriggerServerEvent('mythic_chat:server:311Alert', name, locale, message)
end)

RegisterNetEvent("mythic_jobs:client:Do911Alert")
AddEventHandler("mythic_jobs:client:Do911Alert", function(name, message)
	local locale = ""
	
	local pos = GetEntityCoords(PlayerPedId())
	local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local current_zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))

	if GetStreetNameFromHashKey(var2) == "" then
		locale = GetStreetNameFromHashKey(var1) .. ' ' .. current_zone
	else
		locale = GetStreetNameFromHashKey(var1) .. ' ' ..GetStreetNameFromHashKey(var2) .. ' ' .. GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
	end

	TriggerServerEvent('mythic_chat:server:911Alert', name, locale, message)
end)
```

Can modify the calls as needed to work on your framework but there it is.