--[[
 Export data set
 - Layer and group
 - all frame
 - frame tag
 - Lyaer back ground color
 - cell z-order

 --]]

 -- File picker demo
 --[[
 local dlg = Dialog()
 dlg:file { 
    id = "picker",
    label="select preset aseprite file",
    title="preset importer",
    load=true,
    open=true,
    filename="",
    filetypes={ "aseprite" },
    onchange=function() 
        -- do something.
        dlg:close()
    end
}:show()
--]]


-- cell Order sample
--[[
local layers = app.activeSprite.layers
for i, layer in ipairs(layers) do
    -- app.alert (layer.name)

    local frames = app.activeSprite.frames
    for j, frame in ipairs(frames) do
        -- app.alert (frame.frameNumber)
        local cel = layer:cel(frame.frameNumber)
        cel.zIndex = 2
    end
end
--]]


-- Tag display demo
--[[
local s = app.activeSprite
for i, tag in ipairs(s.tags) do
    app.alert(tag.name)
end
--]]


-- encode test
--[[
local luaTable = {
    demoname = "popman",
    array = {
       {tag = "aAa", val = "2"},
       {tag = "bBb", val = "3"},
       {tag = "cCc", val = "4"}
    }
}

local text = json.encode(luaTable)
app.alert(text)
--]]

local dict = {
    tags = {
--[[
        { tagName = "Front", toFrame = 0, fromFrame = 2 }
        { tagName = "Pose", toFrame = 1, fromFrame = 2 }
--]]
    },
    -- subtree data of layer
    -- group include layers
    -- layer include coloer and cells
    -- cell include zOrder
    layers = {

    }
}

function layerSearch(layers)
    local Outlayers = {}
    
    for i, layer in ipairs(layers) do
        local index = #Outlayers

        if layer.isGroup == true then
            -- add group info and loop
            Outlayers[index+1] = groupGathering(layer)
        elseif layer.isReference == false then
            -- add layer info
            Outlayers[index+1] = layerGathering(layer)
        end
    end
    -- return layer data
    return Outlayers
end

function layerGathering(layer)
    return {
        isGroup = false,
        layerName = layer.name,
        layerColoer = layer.color
    }
end

function groupGathering(group)
    return {
        isGroup = true,
        layerName = group.name,
        layerColoer = group.color,
        layers = layerSearch(group.layers)
    }
end

local s = app.activeSprite

-- tags
for i, tag in ipairs(s.tags) do
    local tagNum = #dict.tags
    dict.tags[tagNum+1] = {
        -- add tag info
        tagName = tag.name,
        fromFrame = tag.fromFrame.frameNumber,
        toFrame = tag.toFrame.frameNumber
    }
end

-- layers
--[[
for j, layer in ipairs(s.layers) do
    local index = #dict.layers
    dict.layers[index+1] = layerSearch(layer)
end
--]]
dict.layers = layerSearch(s.layers)


---[[
local text = json.encode(dict)
app.alert(text)
--]]