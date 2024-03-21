
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

