local map = {} ---@type string[]
for line in io.lines() do table.insert(map, line) end

local weights = {} ---@type integer[]
for _ = 1, #map[1] do table.insert(weights, #map) end

local totalWeight = 0

for l, line in ipairs(map) do
    for i, rock in line:gmatch("()(.)") do
        if rock == '#' then
            weights[i] = #map - l
        elseif rock == 'O' then
            totalWeight = totalWeight + weights[i]
            weights[i] = weights[i] - 1
        end
    end
end

print(totalWeight)