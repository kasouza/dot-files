require('kaso.packer')
require('kaso.lsp')
require('kaso.set')
require('kaso.remap')

vim.cmd('command! HeaderGuards :lua require\'kaso.header_guards\'.header_guards("KASOUZA")')
vim.keymap.set('n', '<leader>h', ':HeaderGuards<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.cmd("filetype plugin on")
