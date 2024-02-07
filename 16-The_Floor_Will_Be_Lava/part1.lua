local map = {} ---@type string[]

local energized = {} ---@type boolean[][]
for line in io.lines() do
    table.insert(map, line)
    table.insert(energized, {})
    for _ = 1, #line do table.insert(energized[#energized], false) end
end

---@class Beam
---@field pos integer[]
---@field spd integer[]

local total = 0
local beams = { { pos={0, 1}, spd={1, 0} } } ---@type Beam[]

while #beams ~= 0 do
    local beam = table.remove(beams)
    while true do ---@cast beam Beam
        beam.pos[1] = beam.pos[1] + beam.spd[1]
        beam.pos[2] = beam.pos[2] + beam.spd[2]
        if energized[beam.pos[2]] == nil or energized[beam.pos[2]][beam.pos[1]] == nil then break end

        if energized[beam.pos[2]][beam.pos[1]] then
            if map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '|' or map[beam.pos[2]]:sub(beam.pos[1], beam.pos[1]) == '-' then
                break
            end
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

print(total)