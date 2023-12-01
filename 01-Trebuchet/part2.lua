local patterns = { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" }

local sum = 0
for line in io.lines() do
    for i, p in ipairs(patterns) do line = line:gsub(p, function(s) return s .. i .. s end) end
    local fst, lst = line:match("(%d)"), line:match("(%d)%D*$")
    sum = sum + fst * 10 + lst
end

print("Part 2: " .. sum)