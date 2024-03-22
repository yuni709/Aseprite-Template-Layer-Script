local s = app.activeSprite


local exportPath = "C:/Users/RimsE/Documents/Aseprite/Assets/Character/Demo.json"
local f = io.open(exportPath, "r")

-- read
local data = f:read("a")
f:close()

local jsonObj = json.decode(data)
local dict = json.decode(data)
local text = json.encode(dict)
local jsonObj = json.decode(text)



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

for i, tag in ipairs(dict.tags) do
    local nTag = getOrCreateTag(tag)
    nTag.name = tag.tagName
    nTag.fromFrame = tag.fromFrame
    nTag.toFrame = tag.toFrame
end