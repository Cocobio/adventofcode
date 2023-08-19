local hands = { A = 0, B = 1, C = 2, X = 0, Y = 1, Z = 2 }

-- Second part of the problem
local target_outcome = { X = 0, Y = 3, Z = 6 }

local function target_hand(oponent, target)
    target = target_outcome[target] // 3 - 1
    return (hands[oponent]+target)%3
end


local function separate_words(str)
    local words = {}
    for word in str:gmatch("%S+") do
        table.insert(words, word)
    end
    return words
end

local function score_hand(oponent, own)
    oponent = hands[oponent]
    own = hands[own]
    return 3*((own-oponent+1)%3)
end


local score = 0
local score2 = 0

for line in io.lines() do
    if #line == 0 then break end
    local oponent, own = table.unpack(separate_words(line))
    score = score + hands[own] + 1 + score_hand(oponent, own)
    score2 = score2 + target_hand(oponent, own) + 1 + target_outcome[own]
end

print(score)
print(score2)
