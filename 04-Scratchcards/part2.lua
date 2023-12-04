local sum = 0
local copies = {}
for line in io.lines() do ---@cast line string
    local c = tonumber(line:match("(%d+)"))
    local count = 1 + (copies[c] == nil and 0 or copies[c])
    sum = sum + count

    local winning = {}
    for n in line:match("^.+:(.+)|"):gmatch("(%d+)") do winning[tonumber(n)] = true end

    local matches = 0
    for n in line:match("|(.+)$"):gmatch("(%d+)") do
        if winning[tonumber(n)] ~= nil then
            matches = matches + 1
            copies[c + matches] = (copies[c + matches] == nil and 0 or copies[c + matches]) + count
        end
    end
end

print(sum)
