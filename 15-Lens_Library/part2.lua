---@class Lens
---@field ref string
---@field focal integer

local boxes = {} ---@type Lens[][]
for _ = 1, 256 do table.insert(boxes, {}) end

for ref, op, focal in string.gmatch(io.input():read("l"), "(%a+)([=-])(%d*)") do --[[@cast op string]]
    --[[@cast focal string]]
    local box = 0
    for i = 1, #ref do box = (box + ref:byte(i, i)) * 17 % 256 end

    local i = 1
    while i <= #boxes[box + 1] do
        local lens = boxes[box + 1][i]
        if lens.ref == ref then
            break
        end
        i = i + 1
    end
    if op == "=" then
        if boxes[box + 1][i] ~= nil then
            boxes[box + 1][i].focal = tonumber(focal) ---@diagnostic disable-line: assign-type-mismatch
        else
            table.insert(boxes[box + 1], { ref = ref, focal = focal })
        end
    else
        table.remove(boxes[box + 1], i)
    end
end

local sum = 0
for b, box in ipairs(boxes) do
    for l, lens in ipairs(box) do
        sum = sum + b * l * lens.focal
    end
end

print(sum)