local sum = 0

for line in io.lines() do
    local cubes = { red = 0, blue = 0, green = 0 }

    for val, col in string.gmatch(line, "(%d+) (%w+)") do
        local count = tonumber(val)
        if count > cubes[col] then cubes[col] = count end
    end

    local pow = 1
    for _, min in pairs(cubes) do pow = pow * min end
    sum = sum + pow
end

print(sum)