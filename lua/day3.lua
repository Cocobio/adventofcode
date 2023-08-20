local function getPriority(char)
    local char_val = string.byte(char)
    return char_val - 38 - (char_val//97)*58
end


local function getRepeatedChar(str1, str2)
    local hashTable = {}
    for i=1,#str1 do
        hashTable[str1:sub(i,i)] = 1
    end
    for i=1,#str2 do
        if hashTable[str2:sub(i,i)] then
            return str2:sub(i,i)
        end
    end
end

local function intersection(table1, table2)
    local table3 = {}
    for key in pairs(table1) do
        if table2[key] then table3[key] = 1 end
    end

    return table3
end


local sum = 0
local sum2 = 0
local badge = {}

local i = 0

for line in io.lines() do
    local len = #line
    if len==0 then break end

    local fHalf = line:sub(1, len//2)
    local sHalf = line:sub(len//2+1)

    sum = sum + getPriority(getRepeatedChar(fHalf,sHalf))

    -- Part two of the puzzle
    i = (i+1)%3
    local possibleBadge = {}
    line:gsub(".", function(c) possibleBadge[c]=1 end)
    if i~=1 then badge = intersection(badge,possibleBadge)
    else badge = possibleBadge end

    if i == 0 then
        for key in pairs(badge) do
            sum2 = sum2 + getPriority(key)
        end
        badge = {}
    end

end

print(sum)
print(sum2)
