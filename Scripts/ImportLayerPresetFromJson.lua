local text = json.encode(dict)
local jsonObj = json.decode(text)
local exportPath = "C:/Users/RimsE/Documents/Aseprite/Assets/Character/Demo.json"
local f = io.open(exportPath, 'w')
-- read
f:colse()