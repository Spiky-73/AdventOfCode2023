---@type integer[]
local toMap = {}
for s in io.read("l"):gmatch("%d+") do table.insert(toMap, tonumber(s)) end
_ = io.read("l")

for _ = 1, 7 do
    ---@type table<integer[], integer>
    local maps = {}
    _ = io.read("l")
    for line in io.lines() do ---@cast line string
        if #line == 0 then break end
        local d, s, c = line:match("(%d+) (%d+) (%d+)")
        local dest, source, count = tonumber(d), tonumber(s), tonumber(c)
        maps[{ source, source + count - 1 }] = dest - source
    end
    for index, value in ipairs(toMap) do
        for map, offset in pairs(maps) do
            if map[1] <= value and value <= map[2] then
                toMap[index] =  value + offset
                break
            end
        end
    end
end

print(math.min(table.unpack(toMap)))