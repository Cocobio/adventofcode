Heap = require "lua/binary_heap"

local max, current = 0, 0
local maxs = Heap:new({0,0,0})

for line in io.lines() do
    if #line == 0 then
        if maxs:top() < current then
            maxs:pop()
            maxs:push(current)
        end
        current = 0
    else
        current = current + tonumber(line)
    end

    if current > max then max = current end
end

print(max)

local total = 0
for _, cal in ipairs(maxs) do total = total + cal end
print(total)
