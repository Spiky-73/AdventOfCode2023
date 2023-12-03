---@type table<integer, string>
local lines = {}
for line in io.lines() do table.insert(lines, line) end

local sum = 0
for index, line in ipairs(lines) do
    for i, val, j in line:gmatch("()(%d+)()") do
        if i > 1 and line:sub(i - 1, i - 1):match("[^%d%.]") ~= nil
            or j <= #line and line:sub(j, j):match("[^%d%.]") ~= nil
            or index > 1 and lines[index - 1]:sub(math.max(i - 1, 1), math.min(j, #lines[index - 1])):match("[^%d%.]") ~= nil
            or index < #lines and lines[index + 1]:sub(math.max(i - 1, 1), math.min(j, #lines[index + 1])):match("[^%d%.]") ~= nil then
            sum = sum + tonumber(val)
        end
    end
end

print(sum)