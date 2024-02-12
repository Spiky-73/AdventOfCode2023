local deltas = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}}

local map = {} ---@type integer[][]
local losses = {} ---@type integer[][][][][]
for line in io.lines() do ---@cast line string
    table.insert(map, {})
    table.insert(losses, {})
    for i = 1, #line do
        table.insert(map[#map], tostring(line:sub(i, i)))
        table.insert(losses[#losses], {})
        for d = 1, #deltas do
            table.insert(losses[#losses][i], {})
            for s = 1, 3 do
                table.insert(losses[#losses][i][d], {})
            end
        end
    end
end


-- x y dir straits | loss
local states = { {1,1, 0,0} } ---@type integer[][]
losses[states[1][2]][states[1][1]][states[1][3]] = {[0]={0}, {}, {}, {}}

while #states ~= 0 do
    local posX, posY, dir, straits = table.unpack(table.remove(states, 1))
    -- print(posX, posY, dir, straits)
    local loss = losses[posY][posX][dir][straits][1]
    if posX == #map[1] and posY == #map then
        print(loss)
        local x, y, d, s = posX, posY, dir, straits
        while x ~= nil do
            local l = losses[y][x][d][s][1]
            print(x, y, d, l, s)
            _, x, y, d, s = table.unpack(losses[y][x][d][s])
        end
        print()
        break
    end
    for i, dp in ipairs(deltas) do
        local x, y = posX + dp[1], posY + dp[2]
        local d, s
        if i ~= dir then
            if math.abs(dir-i) == 2 then goto skip end
            d, s = i, 1
        else
            if straits == 3 then goto skip end
            d, s = dir, straits + 1
        end

        if map[y] ~= nil and map[y][x] ~= nil and not (x == 1 and y == 1) then
            for j = s, 1,-1 do
                if losses[y][x][d][j][1] ~= nil then goto skip end
            end
            losses[y][x][d][s] = {loss + map[y][x], posX, posY, dir, straits}
            for j, state in ipairs(states) do
                if losses[state[2]][state[1]][state[3]][state[4]][1] > losses[y][x][d][s][1] then
                    table.insert(states, j, {x, y, d, s})
                    goto skip
                end
            end
            table.insert(states, {x, y, d, s})
        end
        ::skip::
    end
end