local times = {}
local records = {}

for s in io.read("l"):gmatch("%d+") do table.insert(times, tonumber(s)) end
for s in io.read("l"):gmatch("%d+") do table.insert(records, tonumber(s)) end

local res = 1
for index, time in ipairs(times) do
    local delta = time ^ 2 - 4 * records[index]
    local x1 = math.ceil((time - delta^0.5)/2+0.001)
    local x2 = math.floor((time + delta ^ 0.5) / 2 - 0.001)
    res = res * (x2-x1+1)
end

print(res)
