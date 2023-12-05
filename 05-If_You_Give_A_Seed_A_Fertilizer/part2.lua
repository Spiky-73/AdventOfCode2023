---@type integer[][]
local ranges = {}
for s, c in io.read("l"):gmatch("(%d+) (%d+)") do table.insert(ranges, { tonumber(s), tonumber(s) + tonumber(c) - 1 }) end
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

    ---@type integer[][]
    local newRanges = {}
    for _, range in pairs(ranges) do
        for map, offset in pairs(maps) do
            if map[2] < range[1] or map[1] > range[2] then goto continue end
            local overlap = { range[1], range[2] }
            if map[1] > range[1] then
                overlap[1] = map[1]
                table.insert(ranges, { range[1], map[1] - 1 })
            end
            if map[2] < range[2] then
                overlap[2] = map[2]
                table.insert(ranges, { map[2] + 1, range[2] })
            end
            table.insert(newRanges, { overlap[1] + offset, overlap[2] + offset })
            goto next
            ::continue::
        end
        table.insert(newRanges, range)
        ::next::
    end
    ranges = newRanges
end

local min = ranges[1][1]
for _, range in pairs(ranges) do
    if range[1] < min then min = range[1] end
end

print(min)