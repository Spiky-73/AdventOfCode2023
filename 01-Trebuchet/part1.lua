local sum = 0
for line in io.lines() do
    local fst, lst = line:match("(%d)"), line:match("(%d)%D*$")
    sum = sum + fst * 10 + lst
end

print(sum)