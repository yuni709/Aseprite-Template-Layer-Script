local s = app.activeSprite

for i, tag in ipairs(s.tags) do
    s:deleteTag(tag)
end