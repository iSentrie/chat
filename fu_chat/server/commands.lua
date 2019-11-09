
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end



-- Advertisements 
	RegisterCommand('ad', function(source, args, rawCommand)
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(4)
		local name = getIdentity(source)
		fal = name.firstname .. " " .. name.lastname
		TriggerEvent('fu_chat:server:Advert', fal, msg)
	end, false) 


	RegisterCommand('advert', function(source, args, rawCommand)
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(4)
		local name = getIdentity(source)
		fal = name.firstname .. " " .. name.lastname
		TriggerEvent('fu_chat:server:Advert', fal, msg)
	end, false)


-- Twitter 
 RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. "_" .. name.lastname
    TriggerEvent('fu_chat:server:Tweet', fal, msg)
	end, false)

 RegisterCommand('twat', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. "_" .. name.lastname
    TriggerEvent('fu_chat:server:Tweet', fal, msg)
	end, false)


-- OOC
 RegisterCommand('ooc', function(source, args, rawCommand)
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(4)
		local name = getIdentity(source)
		fal = name.firstname .. "" .. name.lastname
  		TriggerEvent('fu_chat:server:ooc', fal, msg)
	end, false)