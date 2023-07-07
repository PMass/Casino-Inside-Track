local QBCore = exports['qb-core']:GetCoreObject()

Utils = {
    Scaleform = -1,
    ChooseHorseVisible = false,
    BetVisible = false,
    PlayerBalance = 500,
    CurrentHorse = -1,
    CurrentBet = 100,
    CurrentGain = 200,
    HorsesPositions = {},
    CurrentWiner = -1,
    EnableBigScreen = true, -- Set it to false if you don't need the big screen,
    CurrentSoundId = -1,
    InsideTrackActive = false
}

local AcitveZone = {}
local atTrack = false

-- Polyzone --
local function CreateZones()
	local insideTrack = CircleZone:Create(vector3(1097.72, 259.39, -51.24), 11.25, {
		name="casino_insidetrack",
		useZ=true,
		debugPoly = false
	})
	insideTrack:onPlayerInOut(function(isPointInside)
		if isPointInside then
			print("Insiede zone")
			atTrack = true
			Citizen.CreateThread(function() -- SPAWNY, CAN YOU MAKE THIS BASED ON POLY ZONE, and only run when they are inside the horse racing polyzone?
				while atTrack do
				    local sleep = 2000
				    QBCore.Functions.TriggerCallback("casino:server:getPlayerChips", function(data)
					    Utils.PlayerBalance = data
				    end)
				    Citizen.Wait(sleep)
				  end
			  end)
		else
			atTrack = false
			print("outside zone")
		end
	end)
	AcitveZone["casino_insidetrack"] = insideTrack
end

local function DeleteZones()
    for k, _ in pairs(AcitveZone) do
        AcitveZone[k]:destroy()
    end
    AcitveZone = {}
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateZones()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DeleteZones()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        CreateZones()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        DeleteZones()
    end
end)


function Utils:GetMouseClickedButton()
    local returnValue = -1

    CallScaleformMovieMethodWithNumber(self.Scaleform, 'SET_INPUT_EVENT', 237.0, -1082130432, -1082130432, -1082130432, -1082130432)
    BeginScaleformMovieMethod(self.Scaleform, 'GET_CURRENT_SELECTION')

    returnValue = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(returnValue) do
        Wait(0)
    end

    return GetScaleformMovieMethodReturnValueInt(returnValue)
end

function Utils.GetRandomHorseName()
    local random = math.random(0, 99)
    local randomName = (random < 10) and ('ITH_NAME_00'..random) or ('ITH_NAME_0'..random)

    return randomName
end

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
