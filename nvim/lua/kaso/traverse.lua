local root_files = {
    '.git'
}

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

        for _, root_file in ipairs(root_files) do
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

local function cwd()
    local handle = io.popen('pwd')
    if handle ~= nil then
        local current_dir = handle:read('*a')
        handle:close()

        return current_dir
    end

    return nil
end

function get_header_guard(inptpath)
    local path, visited = traverse(inptpath)
    print(path)
    for i, p in ipairs(visited) do
        print(i .. ': ' .. p)
    end

    local str = ''
    for i = 1, #visited do
        local fname = visited[i]
        str = "_" .. fname .. str
    end

    str = str:gsub('-', '_'):upper()
    print('KASOUZA' .. str)
end

