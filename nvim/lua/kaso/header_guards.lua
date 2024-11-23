local M = {}
M.config = {}

-- A pattern to which separators should be replaced by '_' in the final guard
M.config.separators = '[%.\\/-]'
M.config.user_name = 'USER_NAME'
M.config.root_files = { '.git' }

local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end

    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        local s = str:gsub('[\n\r]', '')
        table.insert(t, s)
    end

    return t
end

local function set_from(arr)
    local set = {}
    for _, item in ipairs(arr) do
        set[item] = true
    end

    return set
end

local function has_root_file(path)
    local handle = io.popen('ls -a ' .. path)
    if handle ~= nil then
        local files = set_from(split(handle:read("*a"), '\n'))
        handle:close()

        for _, root_file in ipairs(M.config.root_files) do
            if files[root_file] ~= nil then
                return true
            end
        end
    end

    return false
end

local function join(array, start, stop, sep)
    local result = ''

    for i = start, stop do
        result = result .. array[i] .. sep
    end

    return result
end

local function traverse(starting_path)
    local paths = split(starting_path, '/')

    local visited = {}

    for i = #paths, 1, -1 do
        local path = '/' .. join(paths, 1, i, '/')
        table.insert(visited, paths[i])

        if has_root_file(path) then
            return path, visited
        end
    end

    return nil, visited
end

local function get_header_guard(user_name, inptpath, file_name)
    local _, visited = traverse(inptpath)

    local str = ''
    for i = 1, #visited do
        local fname = visited[i]
        str = "_" .. fname .. str
    end

    str = user_name .. str .. '_' .. file_name
    str = str:gsub(M.config.separators, '_'):upper()
    return str
end


-- Generate the header guards and output then into the current buffer
function M.header_guards(user_name)
    local filename = vim.fn.expand('%:t')
    local guard = get_header_guard(user_name, vim.fn.expand('%:p:h'), filename)

    -- Create the actual header guards
    local ifndef = "#ifndef " .. guard
    local define = "#define " .. guard
    local endif = "#endif"

    -- Put then in the file (with a empty line between the #define and #endif
    vim.api.nvim_put({ ifndef, define, '', endif }, 'l', P, true)
end

return M
