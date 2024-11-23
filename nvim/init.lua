vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')

require('kaso.packer')

require('kaso.set')
require('kaso.remap')

-- Make tailwind extension recognize we are in a project with tailwind
vim.cmd("au FileType html,javascriptreact,typescriptreact,php,blade let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']")

vim.cmd('command! HeaderGuards :lua require\'kaso.header_guards\'.header_guards("KASOUZA")')
vim.keymap.set('n', '<leader>h', ':HeaderGuards<CR>')

vim.cmd("filetype on")
vim.cmd("filetype plugin on")

vim.cmd("nnoremap <silent> <leader>gg :LazyGit<CR>")
vim.cmd("set clipboard+=unnamedplus")
