
-- Table

-- Define layer group and cell's order index.
local LayerList = {

    --[[
    Hair_Front = {
        "HairAcs_Front"
        "HairOption_Front",
        "HairBaseShape_Front"
    },
    Arm_Front = {
        "ArmFront"
    },

    SholderHair = {
        "Hair_Sholder"
    }
    Body = {
        "Body",
        "RightArm_OnSide",
        "LeftArm_OnSide"
    },
    Arm_Rear = {
        "ArmRear"
    }
    Hair_Rear = {
        "HairBaseShape_Rear"
        "HairOption_Rear",
        "HairAcs_Rear"
    }
--]]

    Front = {
        "RightArm",
        "Body",
        "LeftArm"
    },
    Right = {

    },
    Rear = {

    },
    Left = {

    }

}


for group, layerNames in pairs(LayerList) do
    -- Create layer group
    local newGroup = app.activeSprite:newGroup()
    newGroup.name = group

    -- for i = 1, #layerNames do
    for idx, layerName in pairs(layerNames) do
        -- Create layer
        local newLayer = app.activeSprite:newLayer()
        newLayer.name = layerName
        newLayer.parent = newGroup
        newLayer.stackIndex = 3
    end
end

-- in lua language, array index starts fron "1".
--[[

for i = 1,  #LayersList do
    local newLayer = app.activeSprite:newLayer()
    newLayer.name = LayersList[i]

    -- Create layer group
    local newGroup = app.activeSprite:newGroup()
    newLayer.parent = newGroup
end
--]]

