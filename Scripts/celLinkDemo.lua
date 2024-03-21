-- does not work. linking cal api doesn't exist.

local layerName = "DemoLinkingLayer"
local s = app.activeSprite
local trLayer

for i, layer in ipairs(s.layers) do
    if layer.name == layerName then
        trLayer = layer
        local cel1 = trLayer:cel(1)
        local cel2 = trLayer:cel(2)

        cel1:MakeLink(2, cel2)
    end
end