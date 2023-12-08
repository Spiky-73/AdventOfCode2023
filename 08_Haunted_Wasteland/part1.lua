local directions = io.read("l") ---@cast directions string
_ = io.read("l")

local nodes = {} ---@type table<string, string[]>
for line in io.lines() do
    local node, left, right = line:match("(%w+) = %((%w+), (%w+)%)")
    nodes[node] = { left, right }
end

local node = "AAA"
local steps = 0
while node ~= "ZZZ" do
    node = nodes[node][directions:sub(steps % #directions + 1, steps % #directions + 1) == 'L' and 1 or 2]
    steps = steps + 1
end
print(steps)
