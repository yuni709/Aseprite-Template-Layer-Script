local s = app.activeSprite

function getLayerColor(color)
    local nColor
    if color == null then
        nColor = Color{ r=0, g=0, b=0, a=0 }
    else
        nColor = color
    end

    return nColor
end

function getOrCreateLayer(searchLayers, layerName)

    -- return layer if exist.
    for i, foundLayer in ipairs(searchLayers) do
        if foundLayer.name == layerName then
            return true, foundLayer

        end
    end

    return false, nil
end

function constructGroup(searchLayers, groupTable)
    -- find group or ner
    local groupExist
    local nGroup
    groupExist, nGroup = getOrCreateLayer(searchLayers, groupTable.layerName)

    -- new group
    if groupExist == false then
        nGroup = s:newGroup()
    end
    
    nGroup.name = groupTable.layerName
    nGroup.color = getLayerColor(groupTable.layerColoer)

    -- add sublayers.
    for i, layer in ipairs(groupTable.layers) do
        local nLayer = constructLayer(nGroup.layers, groupTable.layers[i])
        nLayer.parent = nGroup
    end

    -- return group.
    return nGroup
end

function constructPureLayer(searchLayers, layerTable)

    -- find layer or new
    local layerExist
    local nLayer
    layerExist, nLayer = getOrCreateLayer(searchLayers, layerTable.layerName)

    -- new layer.
    if layerExist == false then
        nLayer = s:newLayer()
    end

    -- update settings
    nLayer.name = layerTable.layerName
    nLayer.color = getLayerColor(layerTable.layerColoer)

    -- update cell data

    -- return layer.
    return nLayer
end

function constructLayer(searchLayers, layerTable)

    local nLayer

    -- construct layer.
    if layerTable.isGroup == true then
        nLayer = constructGroup(searchLayers, layerTable)
    else
        nLayer = constructPureLayer(searchLayers, layerTable) -- or get layer
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
function getOrCreateTag(tagTable)
    local found
    local foundTag
    -- search tag that matche name.
    -- should dictingish same name tag in different direction
    for i, tag in ipairs(s.tags) do
        if tag.name == tagTable.tagName then
            found = true
            foundTag = tag
            break
        end
    end

    -- return found result or new tag.
    if found == true then
        return foundTag
    else
        return s:newTag(--[[tag.fromFrame, tag.toFrame]])
    end
end

---[[
for i, tag in ipairs(dict.tags) do
    local nTag = getOrCreateTag(tag)
    nTag.name = tag.tagName
    nTag.fromFrame = tag.fromFrame
    nTag.toFrame = tag.toFrame
end
--]]

-- create layers
for i, layer in ipairs(dict.layers) do
    constructLayer(s.layers, layer)
end