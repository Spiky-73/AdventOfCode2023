local map = {} ---@type string[]
local expansion = 1000000

local nonEmptyLines = {} ---@type table<integer>
for line in io.lines() do
    local empty = true
    for x in line:gmatch('()#') do
        nonEmptyLines[x] = true
        empty = false
    end
    if empty then table.insert(map, string.rep('+', #line))
    else table.insert(map, line) end
end

for i = #map[1], 1, -1 do
    if nonEmptyLines[i] == nil then
        for y = 1, #map do map[y] = map[y]:sub(1, i - 1) .. '+' .. map[y]:sub(i + 1, #map[y]) end
    end
end

local galaxies = {} ---@type integer[][]
for y, line in ipairs(map) do
    for x in line:gmatch('()#') do table.insert(galaxies, { x, y }) end
end

local sum = 0
for g = 1, #galaxies do
    for i = (g + 1), #galaxies do
        local d = 0
        local dir = (galaxies[g][1] < galaxies[i][1] and 1 or -1)
        for x = galaxies[g][1] + dir, galaxies[i][1], dir do d = d + (map[galaxies[g][2]]:sub(x, x) == '+' and expansion or 1) end
        dir = (galaxies[g][2] < galaxies[i][2] and 1 or -1)
        for y = galaxies[g][2] + dir, galaxies[i][2], dir do d = d + (map[y]:sub(galaxies[g][1], galaxies[g][1]) == '+' and expansion or 1) end
        -- print(g .. " " .. i .. ":", d)
        sum = sum + d
    end
end

print(sum)