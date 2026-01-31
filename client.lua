local authorizedVehicles = {}
local isRollingCoal = false


RegisterNetEvent('coal:showError', function()
    lib.notify({
        title = 'Access Denied',
        description = 'Insufficient Permissions.',
        type = 'error',
        position = 'top'
    })
end)


RegisterNetEvent('coal:openMenu', function()
    local vehicle = GetVehiclePedIsIn(cache.ped, false)
    if not vehicle or vehicle == 0 then return end

    lib.registerContext({
        id = 'coal_menu_final',
        title = 'Roll Coal Setup',
        options = {
            {
                title = 'Enable for this Truck',
                icon = 'check',
                onSelect = function()
                    authorizedVehicles[vehicle] = true
                    lib.notify({ title = 'Enabled', description = 'Press X to roll coal', type = 'success' })
                end
            },
            {
                title = 'Disable for this Truck',
                icon = 'xmark',
                onSelect = function()
                    authorizedVehicles[vehicle] = nil
                    lib.notify({ title = 'Disabled', type = 'inform' })
                end
            }
        }
    })
    lib.showContext('coal_menu_final')
end)


local function PlaySmokeEffect(vehicle, boneName)
    local boneIndex = GetEntityBoneIndexByName(vehicle, boneName)
    if boneIndex == -1 then return end

    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do Wait(0) end

    UseParticleFxAsset("core")
    local particle = StartParticleFxLoopedOnEntityBone(
        "veh_exhaust_truck", 
        vehicle, 
        0.0, 0.0, 0.0,      
        0.0, 0.0, 0.0,      
        boneIndex, 
        4.5, 
        false, false, false
    )
    
    SetParticleFxLoopedColour(particle, 0.0, 0.0, 0.0, 0)
    SetParticleFxLoopedAlpha(particle, 1.0)
    
    SetTimeout(3000, function()
        StopParticleFxLooped(particle, false)
    end)
end


RegisterCommand('rc_trigger', function()
    local ped = cache.ped
    local vehicle = GetVehiclePedIsIn(ped, false)
    
  
    if not vehicle or vehicle == 0 or not authorizedVehicles[vehicle] then return end
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then return end
    if isRollingCoal then return end

    isRollingCoal = true

    local exhaustBones = {"exhaust", "exhaust_2", "exhaust_3", "exhaust_4"}
    for _, bone in pairs(exhaustBones) do
        PlaySmokeEffect(vehicle, bone)
        PlaySmokeEffect(vehicle, bone)
    end

    SetTimeout(3000, function()
        isRollingCoal = false
    end)
end, false)


RegisterKeyMapping('rc_trigger', 'Vehicle Smoke Effect', 'keyboard', 'X')