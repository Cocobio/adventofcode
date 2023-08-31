local function find_start(msg, package_size)
    local chr_counter = {}
    local repeated = 0

    -- Initialize the char table
    for i=1,package_size do
        local chr = msg:sub(i,i)
        if chr_counter[chr] then
            chr_counter[chr] = chr_counter[chr] +1
            repeated = repeated + 1
        else
            chr_counter[chr] = 1
        end
    end

    -- Evaluate the package and count repeated characters
    for i=1,#msg-package_size do
        local out_chr = msg:sub(i,i)
        local in_chr = msg:sub(i+package_size,i+package_size)

        if chr_counter[out_chr] == 1 then
            chr_counter[out_chr] = nil
        else
            chr_counter[out_chr] = chr_counter[out_chr] - 1
            repeated = repeated - 1
        end

        if chr_counter[in_chr] then
            chr_counter[in_chr] = chr_counter[in_chr] +1
            repeated = repeated + 1
        else
            chr_counter[in_chr] = 1
        end

        if repeated == 0 then
            return i+package_size
        end
    end
end

local msg = io.read()
print(find_start(msg,4))
print(find_start(msg,14))
