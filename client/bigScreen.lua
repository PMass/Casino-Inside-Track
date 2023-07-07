local screenTarget, bigScreenScaleform = -1, -1
local bigScreenCoords = vector3(1092.75, 264.56, -51.24)
local bigScreenRender, isBigScreenLoaded = false, false
local cooldown = 5
local tick = 0

local function registerTarget(name, objectModel)
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, false)
        LinkNamedRendertarget(objectModel)
    end

    return GetNamedRendertargetRenderId(name)
end

local function loadBigScreen()
    screenTarget = registerTarget("casinoscreen_02", 'vw_vwint01_betting_screen')
    bigScreenScaleform = RequestScaleformMovie('HORSE_RACING_WALL')

    while not HasScaleformMovieLoaded(bigScreenScaleform) do
        Wait(0)
    end

    BeginScaleformMovieMethod(bigScreenScaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    SetScaleformFitRendertarget(bigScreenScaleform, true)
    Utils.AddHorses(bigScreenScaleform)

    isBigScreenLoaded = true
end

function Utils:HandleBigScreen()
    CreateThread(function()
        while not self.InsideTrackActive do
            Wait(0)

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - bigScreenCoords)

            if (distance <= 30.0) then
                if not isBigScreenLoaded then
                    loadBigScreen()
                end

                if not bigScreenRender then
                    bigScreenRender = true
                end

                -- Fake cooldown
                tick = (tick + 10)
                if (tick == 1000) then
                    if (cooldown == 1) then
                        -- print("starting race")
                        -- bigScreenScaleform = RequestScaleformMovie('HORSE_RACING_WALL')
                        -- self.CurrentWinner = self.HorsesPositions[1]

                        -- print("current Winner", self.CurrentWinner)
                        -- print("Horse bet", self.HorsesPositions[1])
                    
                        -- BeginScaleformMovieMethod(bigScreenScaleform, 'START_RACE')
                        -- ScaleformMovieMethodAddParamFloat(60000.0) -- Race duration (in MS)
                        -- ScaleformMovieMethodAddParamInt(8)
                    
                        -- -- Add each horses by their index (win order)
                        -- ScaleformMovieMethodAddParamInt(self.HorsesPositions[1])
                        -- ScaleformMovieMethodAddParamInt(self.HorsesPositions[2])
                        -- ScaleformMovieMethodAddParamInt(self.HorsesPositions[3])
                        -- ScaleformMovieMethodAddParamInt(self.HorsesPositions[4])
                        -- ScaleformMovieMethodAddParamInt(self.HorsesPositions[5])
                        -- ScaleformMovieMethodAddParamInt(self.HorsesPositions[6])
                    
                        -- ScaleformMovieMethodAddParamFloat(0.0) -- Unk
                        -- ScaleformMovieMethodAddParamBool(false)
                        -- EndScaleformMovieMethod()
                    end                    
                    cooldown = (cooldown - 1)
                    tick = 0    
                    self:SetMainScreenCooldown2(cooldown)
                end

                SetTextRenderId(screenTarget)
                SetScriptGfxDrawOrder(4)
                SetScriptGfxDrawBehindPausemenu(true)
                DrawScaleformMovieFullscreen(bigScreenScaleform, 255, 255, 255, 255)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            elseif bigScreenRender then
                bigScreenRender = false
                isBigScreenLoaded = false

                ReleaseNamedRendertarget('casinoscreen_02')
                SetScaleformMovieAsNoLongerNeeded(bigScreenScaleform)
            end
        end
    end)
end

do
    if not Utils.EnableBigScreen then
        return
    end

    Utils:HandleBigScreen()
end