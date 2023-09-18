local signal_strength = 0
local cycles = 0
local x = 1

local CRT = {}
local function crt_row()
    local s = {}
    for _ = 1,40 do table.insert(s,".") end
    return s
end
for _=1,6 do
    table.insert(CRT, crt_row())
end

local function process_op(op)
    -- Part 2
    local crt_pos = cycles%40 + 1
    if math.abs(crt_pos-(x+1)) <= 1 then
        CRT[cycles//40+1][crt_pos] = "#"
    end
    -----------

    cycles = cycles + 1
    if (cycles-20)%40 == 0 then
        signal_strength = signal_strength + x*cycles
    end

    if op ~= "noop" then
        -- Part 2
        crt_pos = cycles%40 + 1
        if math.abs(crt_pos-(x+1)) <= 1 then
            CRT[cycles//40+1][crt_pos] = "#"
        end
        -----------
        --
        local vals = {}
        for word in op:gmatch('%S+') do
            table.insert(vals,word)
        end
        local delta_x = tonumber(vals[2])

        cycles = cycles + 1
        if (cycles-20)%40 == 0 then
            signal_strength = signal_strength + x*cycles
        end
        x = x + delta_x
    end
end

for line in io.lines() do
    if #line == 0 then break end

    process_op(line)
end

print(signal_strength)
for i=1,6 do
    local s = ""
    for _, pixel in ipairs(CRT[i]) do
        s = s .. pixel
    end
    print(s)
end
