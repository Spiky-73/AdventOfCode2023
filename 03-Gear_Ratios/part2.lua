---@type string[]
local lines = {}
for line in io.lines() do table.insert(lines, line) end

---@type table<integer, integer>
local gears = {}

---@param p integer
---@param i integer
---@param j integer
local function addPart(p, i, j)
    if gears[j * #lines + i] == nil then gears[j * #lines + i] = 1
    elseif gears[j * #lines + i] > 0 then return end
    gears[j * #lines + i] = -gears[j * #lines + i] * p
end

for index, line in pairs(lines) do
    for is, val, ie in line:gmatch("()(%d+)()") do
        local is = math.max(tonumber(is) - 1, 1)
        local ie = math.min(tonumber(ie), #lines[index]) ---@diagnostic disable-line: param-type-mismatch
        if index > 1 then
            for x in lines[index - 1]:sub(is, ie):gmatch("()%*") do
                addPart(val, x + is - 1, index - 1)
            end
        end
        for x in lines[index]:sub(is, ie):gmatch("()%*") do
            addPart(val, x + is - 1, index)
        end
        if index < #lines then
            for x in lines[index + 1]:sub(is, ie):gmatch("()%*") do
                addPart(val, x + is - 1, index + 1)
            end
        end
    end
end

local sum = 0
for _, value in pairs(gears) do
    if value > 0 then sum = sum + value end
end

print(sum)