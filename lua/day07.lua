NodeType = {DIR = 1, FILE = 2,}

local root = {  name = "/",
                children = {},
                size = false,
                type = NodeType.DIR
            }

local current = root

local function parse_line(line)
    local parsed = {}
    for token in line:gmatch("%S+") do
        table.insert(parsed, token)
    end
    return parsed
end

local function create_node(id, name)
    local node = {}

    node.parent = current == root and nil or current
    node.name = name
    node.type = id == "dir" and NodeType.DIR or NodeType.FILE
    node.size = id == "dir" and false or tonumber(id)
    node.children = id == "dir" and {} or nil

    return node
end

-- Create the tree
for line in io.lines() do
    if #line == 0 then break end
    line = parse_line(line)

    if line[1] ~= "$" then
        local node = create_node(table.unpack(line))
        current.children[node.name] = node
    elseif line[2] ~= "ls" then
        if line[3] == ".." then current = current.parent or current
        elseif line[3] == "/" then current = root
        else current = current.children[line[3]] or current end
    end
end

local function dfs(node, func)
    if node.children then
        for _, child in pairs(node.children) do
            dfs(child, func)
        end
    end
    func(node)
end

-- Update sizes of DIRs
dfs(root,
    function(node)
        if node.type == NodeType.DIR then
            node.size = 0
            for _, child in pairs(node.children) do
                node.size = node.size + child.size
            end
        end
    end
    )

local sum = 0
dfs(root,
    function(node)
        if node.type == NodeType.DIR and node.size <= 100000 then
            sum = sum + node.size
        end
    end
    )

print(sum)


-- Part 2
-- Total size - space needed
local space_to_delete = root.size - (70000000-30000000)
local min = root.size
dfs(root,
    function(node)
        if node.type == NodeType.DIR then
            if node.size >= space_to_delete and node.size < min then
                min = node.size
            end
        end
    end
    )
print(min)








