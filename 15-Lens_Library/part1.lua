local sum = 0

for code in string.gmatch(io.input():read("l"), "([^,]+)") do
    local current = 0
    for i = 1, #code do current = (current + code:byte(i, i)) * 17 % 256 end
    sum = sum + current
end

print(sum)