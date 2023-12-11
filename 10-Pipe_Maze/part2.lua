local codes =  { -- BLTR
    ['|'] = 10, ['-'] = 5,
    ['L'] = 3, ['J'] = 6, ['7'] = 12, ['F'] = 9,
    ['.'] = 0
}

local map = {} ---@type string[]
local start = { x = 1, y = 1 }
for line in io.lines() do ---@cast line string
    table.insert(map, line)
    local x = line:find("S");
    if x ~= nil then start.x, start.y = x, #map end
end

local coords = { x = start.x, y = start.y }
for pipe, code in pairs(codes) do
    if code == 0 then goto continue end
    if code & 1 ~= 0 and (coords.x >= #map[coords.y] or codes[map[coords.y]:sub(coords.x + 1, coords.x + 1)] & 4 == 0) then goto continue end
    if code & 4 ~= 0 and (coords.x <= 1 or codes[map[coords.y]:sub(coords.x - 1, coords.x - 1)] & 1 == 0) then goto continue end
    if code & 2 ~= 0 and (coords.y <= 1 or codes[map[coords.y - 1]:sub(coords.x, coords.x)] & 8 == 0) then goto continue end
    if code & 8 ~= 0 and (coords.y >= #map or codes[map[coords.y + 1]:sub(coords.x, coords.x)] & 2 == 0) then goto continue end
    map[coords.y] = map[coords.y]:gsub("S", pipe)
    break
    ::continue::
end

local move = 5
local loop = { [coords.x*#map + coords.y] = true } ---@type type<integer, boolean>
repeat
    move = (move >> 2 | move << 2) & 15
    move = codes[map[coords.y]:sub(coords.x, coords.x)] & ~move
    if move == 1 then coords.x = coords.x + 1
    elseif move == 4 then coords.x = coords.x - 1
    elseif move == 2 then coords.y = coords.y - 1
    else coords.y = coords.y + 1 end
    loop[coords.x * #map + coords.y] = true
until coords.y == start.y and coords.x == start.x

local area = 0
for y, line in ipairs(map) do
    local inside = false
    local top = false
    for x, char in line:gmatch('()(.)') do
        if loop[x * #map + y] == true then
            if char == 'F' then top = false
            elseif char == 'L' then top = true end
            if char ~= '-' and not (char == 'J' and not top) and not (char == '7' and top) then inside = not inside end
        elseif inside then area = area + 1 end
    end
end

print(area)