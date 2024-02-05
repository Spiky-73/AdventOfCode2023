local patterns = { {} } ---@type string[][]
for line in io.lines() do ---@cast line string
    if #line == 0 then table.insert(patterns, {})
    else table.insert(patterns[#patterns], line) end
end

---@param pattern string[]
---@param row integer
---@param max? integer
---@return integer
local function getsymetrydiff(pattern, row, max)
    max = max or 1
    local diff = 0

    local i = 0
    while row-i > 0 and row+1+i <= #pattern do
        for c = 1, #pattern[row - i] do
            if pattern[row - i]:sub(c, c) ~= pattern[row + 1 + i]:sub(c, c) then
                diff = diff + 1
                if diff > max then return diff end
            end
        end
        i = i + 1
    end
    return diff
end

local sum = 0
for p, pattern in ipairs(patterns) do

    for i = 1, #pattern-1 do
        if getsymetrydiff(pattern, i, 2) == 1 then
            sum = sum + i * 100
            goto continue
        end
    end

    local hpattern = {} ---@type string[]
    for c = 1, #pattern[1] do
        hpattern[c] = ""
        for i = 1, #pattern do hpattern[c] = hpattern[c] .. pattern[i]:sub(c, c) end
    end

    for i = 1, #hpattern-1 do
        if getsymetrydiff(hpattern, i, 2) == 1 then
            sum = sum + i
            goto continue
        end
    end

    ::continue::
end

print(sum)