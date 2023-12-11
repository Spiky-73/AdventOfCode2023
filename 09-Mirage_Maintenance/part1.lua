local sum = 0
for line in io.lines() do ---@cast line string
    local sequences = { {} } ---@type integer[][]
    for d in line:gmatch("-?%d+") do table.insert(sequences[1], tonumber(d)) end

    for s, sequence in ipairs(sequences) do
        table.insert(sequences, {})
        local stop = true
        for i = 2, #sequence do
            local d = sequence[i] - sequence[i - 1]
            stop = stop and d == 0
            table.insert(sequences[s + 1], d)
        end
        if stop then break end
    end
    local value = 0
    for i = #sequences - 1, 1, -1 do value = sequences[i][#sequences[i]] + value end
    sum = sum + value
end
print(sum)
