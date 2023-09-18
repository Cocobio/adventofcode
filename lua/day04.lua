local sum = 0
local sum2 = 0

local function decomposeArea(area)
    local num1, num2 = area:match("([^,]+)-([^,]+)")
    return tonumber(num1), tonumber(num2)
end

for line in io.lines() do
    if #line == 0 then break end
    local area1, area2 = line:match("([^,]+),([^,]+)")
    local min1, max1 = decomposeArea(area1)
    local min2, max2 = decomposeArea(area2)

    if (min1>=min2 and max1<=max2) or
        (min2>=min1 and max2<=max1) then
        sum = sum + 1
    end

    local overlap_min = min1<=min2 and min2 or min1
    local overlap_max = max1>=max2 and max2 or max1

    if overlap_max-overlap_min >= 0 then sum2 = sum2 + 1 end
end

print(sum)
print(sum2)
