local directions = io.read("l") ---@cast directions string
_ = io.read("l")

local positions = {} ---@type string[]
local nodes = {} ---@type table<string, string[]>
for line in io.lines() do
    local node, left, right = line:match("(%w+) = %((%w+), (%w+)%)")
    nodes[node] = { left, right }
    if (node:sub(-1, -1) == "A") then table.insert(positions, node) end
end

local function gcd(x, y) return x == 0 and y or gcd(y % x, x) end

local min = 1
for _, position in ipairs(positions) do
    local steps = 0
    while position:sub(-1, -1) ~= "Z" do
        position = nodes[position][directions:sub(steps % #directions + 1, steps % #directions + 1) == 'L' and 1 or 2]
        steps = steps + 1
    end
    min = steps * min / gcd(min, steps)
end

print(min)