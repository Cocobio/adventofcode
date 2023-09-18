local function create_knot_counter()
    local knot_table = {pos = {0,0}, counter = 0}
    return knot_table
end

local knots_positions = {H = create_knot_counter()}
for _ = 0,9 do
    table.insert(knots_positions, create_knot_counter())
end

local delta = {U = {0,1}, D = {0,-1}, L = {-1,0}, R = {1,0}}

local function move_knot(head, tail)
    local head_x, head_y = table.unpack(knots_positions[head].pos)
    local tail_x, tail_y = table.unpack(knots_positions[tail].pos)
    local tail_delta_x, tail_delta_y = 0, 0

    if math.abs(head_x-tail_x) == 2 or math.abs(head_y-tail_y) == 2 then
        tail_delta_x = head_x-tail_x
        tail_delta_y = head_y-tail_y
        tail_delta_x = tail_delta_x>0 and 1 or tail_delta_x<0 and -1 or 0
        tail_delta_y = tail_delta_y>0 and 1 or tail_delta_y<0 and -1 or 0
    end

    tail_x = tail_x + tail_delta_x
    tail_y = tail_y + tail_delta_y
    local tail_pos = tostring(tail_x)..","..tostring(tail_y)

    if not knots_positions[tail][tail_pos] then
        knots_positions[tail]['counter'] = knots_positions[tail]['counter'] + 1
    end

    knots_positions[tail][tail_pos] = 1
    knots_positions[tail].pos[1] = tail_x
    knots_positions[tail].pos[2] = tail_y
end

for line in io.lines() do
    if #line == 0 then break end
    local vals = {}
    for word in line:gmatch('%S+') do
        table.insert(vals, word)
    end

    local dir, steps = table.unpack(vals)

    local delta_x, delta_y = table.unpack(delta[dir])
    steps = tonumber(steps)

    for _=1, steps do
        local head_x, head_y = table.unpack(knots_positions.H.pos)
        head_x = head_x + delta_x
        head_y = head_y + delta_y
        knots_positions.H.pos = {head_x, head_y}

        local head = 'H'
        move_knot(head, 1)
        for i=2,9 do
            move_knot(i-1, i)
        end
    end

end

print(knots_positions[1]['counter'])
print(knots_positions[9]['counter'])

