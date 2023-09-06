function format_php()
    vim.cmd("w")
    local handle = io.popen('phpcbf ' .. vim.fn.expand('%'))
    local result = handle:read("*a")
    handle:close()
    print(result)
    vim.cmd("e")
end

vim.keymap.set('n', '<leader>a', format_php)
