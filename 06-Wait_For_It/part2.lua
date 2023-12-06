local time, record = 0, 0

for s in io.read("l"):gmatch("%d") do time = 10 * time + tonumber(s) end
for s in io.read("l"):gmatch("%d") do record = 10 * record + tonumber(s) end

local delta = time ^ 2 - 4 * record
local x1 = math.ceil((time - delta^0.5)/2+0.001)
local x2 = math.floor((time + delta ^ 0.5) / 2 - 0.001)

print(x2 - x1 + 1)
