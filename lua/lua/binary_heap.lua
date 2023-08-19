local H = {}
if _REQUIREDNAME == nil then
    heap = H
else
    _G[_REQUIREDNAME] = H
end

local function bubble_up(tab, i)
    local parent = i // 2
    while i ~= 1 and tab.cmp(tab[i], tab[parent]) do
        tab[i], tab[parent] = tab[parent], tab[i]
        i = parent
        parent = parent // 2
    end
end

local function bubble_down(tab, i)
    while (i * 2 <= #tab and tab.cmp(tab[i * 2], tab[i])) or
          (i * 2 + 1 <= #tab and tab.cmp(tab[i * 2 + 1], tab[i])) do
        local child1 = i * 2 <= #tab and i * 2 or nil
        local child2 = i * 2 + 1 <= #tab and i * 2 + 1 or nil
        local new_i = child1

        if child2 and tab.cmp(tab[child2], tab[child1]) then new_i = child2 end
        tab[i], tab[new_i] = tab[new_i], tab[i]
        i = new_i
    end
end

function H:new(arr, cmp)
    cmp = cmp or function(a, b) return a < b end
    arr = arr or {}

    setmetatable(arr, self)
    self.__index = self
    arr.cmp = cmp

    return arr
end

-- Review the limit of the for, should end in 0?
function H:heapify(arr, cmp)
    cmp = cmp or function(a, b) return a < b end

    setmetatable(arr, self)
    self.__index = self
    arr.cmp = cmp

    for i = #arr // 2, 1, -1 do
        bubble_down(arr, i)
    end

    return arr
end

function H:top()
    return self[1]
end

function H:push(val)
    table.insert(self, val)
    bubble_up(self, #self)
end

function H:pop()
    self[1], self[#self] = self[#self], self[1]
    return table.remove(self), bubble_down(self, 1)
end

function H:isEmpty() return #self == 0 end

function H:size() return #self end

return H
