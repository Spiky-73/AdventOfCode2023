local cubes = { red = 12, green = 13, blue = 14 }
local sum = 0

for line in io.lines() do
    for val, col in string.gmatch(line, "(%d+) (%w+)") do
        if tonumber(val) > cubes[col] then goto next end
    end

    sum = sum + tonumber(string.match(line, "%d+"))
    ::next::
end

print(sum)