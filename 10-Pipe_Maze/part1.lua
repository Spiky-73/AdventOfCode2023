local codes =  { -- BLTR
    ['|'] = 10,
    ['-'] = 5,
    ['L'] = 3,
    ['J'] = 6,
    ['7'] = 12,
    ['F'] = 9,
    ['.'] = 0
}

---@type string[]
local map = {}
local startCoords = { x = 1, y = 1 }
for line in io.lines() do ---@cast line string
    table.insert(map, line)
    local x = line:find("S");
    if x ~= nil then startCoords.x, startCoords.y = x, #map end
end

local coords = { x = startCoords.x, y = startCoords.y }
for pipe, code in pairs(codes) do
    if code == 0 then goto continue end
    if code & 1 ~= 0 and (coords.x >= #map[coords.y] or codes[map[coords.y]:sub(coords.x + 1, coords.x + 1)] & 4 == 0) then goto continue end
    if code & 4 ~= 0 and (coords.x <= 1 or codes[map[coords.y]:sub(coords.x - 1, coords.x - 1)] & 1 == 0) then goto continue end
    if code & 2 ~= 0 and (coords.y <= 1 or codes[map[coords.y-1]:sub(coords.x, coords.x)] & 8 == 0) then goto continue end
    if code & 8 ~= 0 and (coords.y >= #map or codes[map[coords.y + 1]:sub(coords.x, coords.x)] & 2 == 0) then goto continue end
    map[coords.y] = map[coords.y]:gsub("S", pipe)
    break
    ::continue::
end
local steps = 0
local move = 5
repeat
    move = (move >> 2 | move << 2) & 15
    move = codes[map[coords.y]:sub(coords.x, coords.x)] & ~move
    if move == 1 then coords.x = coords.x + 1
    elseif move == 4 then coords.x = coords.x - 1
    elseif move == 2 then coords.y = coords.y - 1
    else coords.y = coords.y + 1 end
    steps = steps + 1
until coords.y == startCoords.y and coords.x == startCoords.x
print(steps//2)