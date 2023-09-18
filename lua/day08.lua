local matrix = {}

for line in io.lines() do
    if #line == 0 then break end
    local tmp_row = {}
    line:gsub(".", function(c) table.insert(tmp_row,tonumber(c)) end)
    table.insert(matrix, tmp_row)
end

local counted = {}

-- Horizontal
for i, row in ipairs(matrix) do
    local max = -1
    for j, column in ipairs(row) do
        if column > max then
            max = column
            if not counted[i..","..j] then
                counted[i..","..j] = true
            end
        end
    end

    max = -1
    for j=#row,1,-1 do
        local column = row[j]
        if column > max then
            max = column
            if not counted[i..","..j] then
                counted[i..","..j] = true
            end
        end
    end
end

-- Vertical
for j=1,#matrix[1] do
    local max = -1
    for i=1,#matrix do
        local height = matrix[i][j]
        if height > max then
            max = height
            if not counted[i..","..j] then
                counted[i..","..j] = true
            end
        end
    end

    max = -1
    for i=#matrix,1,-1 do
        local height = matrix[i][j]
        if height > max then
            max = height
            if not counted[i..","..j] then
                counted[i..","..j] = true
            end
        end
    end
end

local sum = 0
for _ in pairs(counted) do sum = sum + 1 end
print(sum)

-- Part 2
local function calculate_view(row, column)
    local mul = 1
    local height = matrix[row][column]

    sum = 0
    for i=row-1,1,-1 do
        if matrix[i][column] >= height then
            sum = sum + 1
            break
        end
        sum = sum + 1
    end
    mul = mul * sum

    sum = 0
    for i=row+1,#matrix do
        if matrix[i][column] >= height then
            sum = sum + 1
            break
        end
        sum = sum + 1
    end
    mul = mul * sum

    sum = 0
    for j=column-1,1,-1 do
        if matrix[row][j] >= height then
            sum = sum + 1
            break
        end
        sum = sum + 1
    end
    mul = mul * sum

    sum = 0
    for j=column+1,#matrix[1] do
        if matrix[row][j] >= height then
            sum = sum + 1
            break
        end
        sum = sum + 1
    end
    mul = mul * sum

    return mul
end

local max_view = 0
for i=1,#matrix do
    for j=1,#matrix[1] do
        local local_view = calculate_view(i,j)
        if local_view > max_view then
            max_view = local_view
        end
    end
end
print(max_view)
