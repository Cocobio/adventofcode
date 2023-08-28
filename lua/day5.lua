local stacks = {}
local input_text = {}

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function printstacks()
    for i in pairs(stacks) do
        local str = ""
        for j in pairs(stacks[i]) do str = str .. stacks[i][j] .. ' ' end

        print(i, str)
    end
    print()
end

-- Parser for line
local function parse_line(line)
    local parsed = {}
    for num in line:gmatch("%d+") do table.insert(parsed, tonumber(num)) end
    return table.unpack(parsed)
end

-- Read the cargo information
for line in io.lines() do
    if #line == 0 then break end
    table.insert(input_text, line)
end

-- Format the cargo information as a list of stacks
for i=1,#input_text[#input_text] do
    local c = input_text[#input_text]:sub(i,i)
    if c ~= " " then
        table.insert(stacks, {})
        for j = #input_text-1,1,-1 do
            if input_text[j]:sub(i,i) == " " then break end
            table.insert(stacks[#stacks], input_text[j]:sub(i,i))
        end
    end
end

-- Part2
local stacks2 = deepcopy(stacks)

-- Read an make all the movements
for line in io.lines() do
    if #line == 0 then break end
    local n, from, to = parse_line(line)
    for i=n,1,-1 do
        table.insert(stacks[to], table.remove(stacks[from]))
        table.insert(stacks2[to], table.remove(stacks2[from], #stacks2[from]-i+1))
    end
end

local output = ""
for _,cargo in ipairs(stacks) do output = output .. cargo[#cargo] end
local output2 = ""
for _,cargo in ipairs(stacks2) do output2 = output2 .. cargo[#cargo] end

print(output)
print(output2)
