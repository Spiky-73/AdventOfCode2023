
local sum = 0
for line in io.lines() do ---@cast line string
    ---@type table<integer>
    local winning = {}
    local count = 0
    for n in line:match("^.+:(.+)|"):gmatch("(%d+)") do winning[tonumber(n)] = true end
    for n in line:match("|(.+)$"):gmatch("(%d+)") do
        if winning[tonumber(n)] ~= nil then count = count + 1 end
    end
    if count > 0 then sum = sum + 2^(count-1) end
end


print(sum)