QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("insidetrack:server:getPlayerChips", function(source, cb)
    print("getting chips")
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    if CitizenId then
		local balance = 0
		local whitechips = Player.Functions.GetItemByName("casino_whitechip")
		local redchips = Player.Functions.GetItemByName("casino_redchip")
		local bluechips = Player.Functions.GetItemByName("casino_bluechip")
		local yellowchips = Player.Functions.GetItemByName("casino_yellowchip")
		local greenchips = Player.Functions.GetItemByName("casino_greenchip")
		local blackchips = Player.Functions.GetItemByName("casino_blackchip")
		local purplechips = Player.Functions.GetItemByName("casino_purplechip")
		if whitechips ~= nil then
			balance = whitechips.amount
		end
		if redchips ~= nil then
			balance = balance + redchips.amount * 10
		end
		if bluechips ~= nil then
			balance = balance +  bluechips.amount * 50
		end
		if yellowchips ~= nil then
			balance = balance +  yellowchips.amount * 100
		end
		if greenchips ~= nil then
			balance = balance +  greenchips.amount * 200
		end
		if blackchips ~= nil then
			balance = balance +  blackchips.amount * 500
		end
		if purplechips ~= nil then
			balance = balance +  purplechips.amount * 1000
		end
		print(balance)
		cb(balance)
	else 
		cb(0)
	end
end)

QBCore.Functions.CreateCallback("casinon:server:getPlayerChips", function(source, cb)
    print("getting chips")
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    if CitizenId then
		local balance = 0
		local whitechips = Player.Functions.GetItemByName("casino_whitechip")
		local redchips = Player.Functions.GetItemByName("casino_redchip")
		local bluechips = Player.Functions.GetItemByName("casino_bluechip")
		local yellowchips = Player.Functions.GetItemByName("casino_yellowchip")
		local greenchips = Player.Functions.GetItemByName("casino_greenchip")
		local blackchips = Player.Functions.GetItemByName("casino_blackchip")
		local purplechips = Player.Functions.GetItemByName("casino_purplechip")
		if whitechips ~= nil then
			balance = whitechips.amount
		end
		if redchips ~= nil then
			balance = balance + redchips.amount * 10
		end
		if bluechips ~= nil then
			balance = balance +  bluechips.amount * 50
		end
		if yellowchips ~= nil then
			balance = balance +  yellowchips.amount * 100
		end
		if greenchips ~= nil then
			balance = balance +  greenchips.amount * 200
		end
		if blackchips ~= nil then
			balance = balance +  blackchips.amount * 500
		end
		if purplechips ~= nil then
			balance = balance +  purplechips.amount * 1000
		end
		print(balance)
		cb(balance)
	else 
		cb(0)
	end
end)



RegisterServerEvent("insidetrack:server:winnings")
AddEventHandler("insidetrack:server:winnings", function(amount)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("casino_token", amount)
end)

RegisterServerEvent("insidetrack:server:placebet")
AddEventHandler("insidetrack:server:placebet", function(bet)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
        if exports['qb-inventory']:HasItem() then
	return true
	end
end)

function print_table(t)
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end
