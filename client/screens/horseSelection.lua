function Utils:ShowHorseSelection()
    self.ChooseHorseVisible = true

    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()
end

function Utils.AddHorses(scaleform)
    for i = 1, 6 do
        local name = Utils.GetRandomHorseName()

        BeginScaleformMovieMethod(scaleform, 'SET_HORSE')
        ScaleformMovieMethodAddParamInt(i) -- Horse index

        -- Horse name
        BeginTextCommandScaleformString(name)
        EndTextCommandScaleformString()

        ScaleformMovieMethodAddParamPlayerNameString('EVENS')

        math.random(); math.random(); math.random()
        local r1 = math.random(1,99)
        local r2 = math.random(1,99)
        local r3 = math.random(1,99)
        local r4 = math.random(1,99)

        -- Horse style (TODO: Random preset, different one for each horse)
        ScaleformMovieMethodAddParamInt(Utils.HorseStyles[r1][1])
        ScaleformMovieMethodAddParamInt(Utils.HorseStyles[r2][2])
        ScaleformMovieMethodAddParamInt(Utils.HorseStyles[r3][3])
        ScaleformMovieMethodAddParamInt(Utils.HorseStyles[r4][4])
        EndScaleformMovieMethod()
    end
end