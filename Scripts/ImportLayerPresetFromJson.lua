local s = app.activeSprite

function constructGroup(groupTable)
    -- new group.
    local nGroup = s:newGroup()
    nGroup.name = groupTable.layerName
    nGroup.color = groupTable.layerColoer

    -- add sublayers.
    for i, layer in ipairs(groupTable.layers) do
        local nLayer = constructLayer(groupTable.layers[i])
        nLayer.parent = nGroup
    end

    -- return group.
    return nGroup
end

function constructPureLayer(layerTable)
    -- new layer.
    local nLayer = s:newLayer()
    nLayer.name = layerTable.layerName
    nLayer.color = layerTable.layerColoer

    -- update cell data

    -- return layer.
    return nLayer
end

function constructLayer(layerTable)

    -- construct layer.
    local nLayer
    if layerTable.isGroup == true then
        nLayer = constructGroup(layerTable)
    else
        nLayer = constructPureLayer(layerTable)
    end

    -- return result.
    return nLayer
end

local exportPath = "C:/Users/RimsE/Documents/Aseprite/Assets/Character/Demo.json"
local f = io.open(exportPath, "r")

-- read
local data = f:read("a")
f:close()

local jsonObj = json.decode(data)
local dict = json.decode(data)
local text = json.encode(dict)
local jsonObj = json.decode(text)


-- create frames
---[[
for i, frame in ipairs(dict.frames) do

    local nFrame
    -- delete frame if there is already frame.
    if frame.frameNumber <= #s.frames then
        nFrame = s.frames[i]
    else 
    -- new frame to new place.
        nFrame = s:newEmptyFrame(frame.frameNumber)
    end
    nFrame.duration = frame.frameDuration
end
--]]

-- create tags
---[[
for i, tag in ipairs(dict.tags) do
    local nTag = s:newTag(tag.fromFrame, tag.toFrame)
    nTag.name = tag.tagName
end
--]]

-- create layers
for i, layer in ipairs(dict.layers) do
    constructLayer(layer)
end