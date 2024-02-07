local map = {} ---@type string[]
local starts = {} ---@type table<integer[], integer[]>

for line in io.lines() do
    table.insert(map, line)

    starts[{ 0, #map }] = {1, 0}
    starts[{ #line + 1, #map }] = {-1, 0}
end
for i = 1, #map[1] do
    starts[{ i, 0 }] = { 0, 1 }
    starts[{ i, #map + 1 }] = { 0, -1 }
end

local max = 0
local ignored = {} ---@type table<string>

for key, value in pairs(starts) do
    if (ignored[key[1] * #map + key[2]]) then goto continue end

    local energized = {} ---@type boolean[][]
    for i = 1, #map do
        table.insert(energized, {})
        for _ = 1, #map[i] do table.insert(energized[#energized], false) end
    end

    local total = 0
    local beams = { [1] = { pos = { key[1], key[2] }, spd = { value[1], value[2] } } } ---@type Beam[]
    while #beams ~= 0 do
        local beam = table.remove(beams)
        while true do ---@cast beam Beam
            beam.pos[1] = beam.pos[1] + beam.spd[1]
            beam.pos[2] = beam.pos[2] + beam.spd[2]
            if energized[beam.pos[2]] == nil or energized[beam.pos[2]][beam.pos[1]] == nil then
                ignored[beam.pos[1] * #map + beam.pos[2]] = true
                break
            end

            if energized[beam.pos[2]][beam.pos[1]] then
                if map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '|' or map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '-' then break end
            else
                energized[beam.pos[2]][beam.pos[1]] = true
                total = total + 1
            end
            local split = false
            local spd = nil ---@type integer[]|nil
            if map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '|' and beam.spd[2] == 0 then spd = { 0, 1 }; split = true
            elseif map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '-' and beam.spd[1] == 0 then spd = { 1, 0 }; split = true
            elseif map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '/' then spd = { -beam.spd[2], -beam.spd[1] }
            elseif map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '\\' then spd = { beam.spd[2], beam.spd[1] }
            end
            if spd ~= nil then
                if split then table.insert(beams, { pos = { beam.pos[1], beam.pos[2] }, spd = { -spd[1], -spd[2] } }) end
                beam.spd = spd
            end
        end
    end
    if total > max then max = total end
    ::continue::
end

print(max)