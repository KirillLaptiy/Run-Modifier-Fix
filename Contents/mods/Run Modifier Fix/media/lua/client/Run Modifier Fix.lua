
local playerVariables = {
    RunSpeedScale = "RunSpeed",
    RunBlendTime = "RunBlend",
    SneakRunSpeedScale = "SneakRunSpeed",
    SneakRunBlendTime = "SneakRunBlend",
    SprintSpeedScale = "SprintSpeed",
    SprintBlendTime = "SprintBlend",
}

local RunModiferFix = function ()

    local player = getPlayer()
    if not player:getWornItems() then return end
    
    local defaultModifiers = {
        RunSpeed = 1.04,
        RunBlend = 0.35,
        SneakRunSpeed = 0.92,
        SneakRunBlend = 0.50,
        SprintSpeed = 0.96,
        SprintBlend = 0.15,
    }

    local wornItems = player:getWornItems()
    
    for i = 1, wornItems:size() do
        
        local item = wornItems:get(i-1):getItem()

        if instanceof(item, "Clothing") and item:getBodyLocation() then

            local itemSM = item:getRunSpeedModifier() or 1

            for key, value in pairs(defaultModifiers) do
                defaultModifiers[key] = value * itemSM
            end

            for playerVariable, modifierKey in pairs(playerVariables) do
                player:setVariable(playerVariable, defaultModifiers[modifierKey])
            end
        
        end

    end
end

Events.OnCreatePlayer.Add(RunModiferFix)
Events.OnClothingUpdated.Add(RunModiferFix)