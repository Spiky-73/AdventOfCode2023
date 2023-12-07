local games = {}

local cards = "J23456789TQKA"
local hands = "12T3F45"

for line in io.lines() do
    local hand, s = line:match("(%S+) (%d+)")
    local score = tonumber(s)
    local counts = {} ---@type table<string, integer>

    local max, twos = 0, 0;
    hand = string.gsub(hand, '.', function(c)
        counts[c] = (counts[c] == nil and 0 or counts[c]) + 1
        if c ~= 'J' then
            if counts[c] == 2 then twos = twos + 1 end
            if counts[c] > max then max = counts[c] end
        end
        return string.char(cards:find(c) + ("A"):byte()-1)
    end)
    max = max + (counts['J'] == nil and 0 or counts['J'])
    local type = hands:find(tostring(max))
    if max == 3 and twos == 2 or max == 2 and twos == 2 then type = type + 1 end
    hand = string.char(type + ("A"):byte() - 1) .. hand

    for i = 1, #games do
        if games[i][1] > hand then
            table.insert(games, i, { hand, score, hand })
            goto next
        end
    end
    table.insert(games, #games + 1, { hand, score, hand })
    ::next::
end

local sum = 0
for i, game in ipairs(games) do sum = sum + i * game[2] end

print(sum)
