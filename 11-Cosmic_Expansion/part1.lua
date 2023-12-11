local map = {} ---@type string[]

local nonEmptyLines = {} ---@type table<integer>
for line in io.lines() do
    local empty = true
    for x in line:gmatch('()#') do
        nonEmptyLines[x] = true
        empty = false
    end
    table.insert(map, line)
    if empty then table.insert(map, line) end
end

for i = #map[1], 1, -1 do
    if nonEmptyLines[i] == nil then
        for y = 1, #map do map[y] = map[y]:sub(1, i) .. '.' .. map[y]:sub(i + 1, #map[y]) end
    end
end

local galaxies = {} ---@type integer[][]
for y, line in ipairs(map) do
    for x in line:gmatch('()#') do table.insert(galaxies, { x, y }) end
end

local sum = 0
for g = 1, #galaxies do
    for i = (g + 1), #galaxies do
        local d = math.abs(galaxies[g][1] - galaxies[i][1]) + math.abs(galaxies[g][2] - galaxies[i][2])
        -- print(g .. " " .. i .. ":", d)
        sum = sum + d
    end
end

print(sum)