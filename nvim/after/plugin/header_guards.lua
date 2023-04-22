vim.cmd('command! HeaderGuards :lua require\'kaso.header_guards\'.header_guards("KASOUZA")')
vim.keymap.set('n', '<leader>h', ':HeaderGuards<CR>')
