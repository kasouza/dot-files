vim.opt.nu = true
vim.opt.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("HOME") or "~") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = "\\"

vim.opt.clipboard = 'unnamedplus'

-- vim.cmd("autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab")
vim.cmd('set expandtab')

-- Set emmet vim keybinding
vim.g.user_emmet_expandabbr_key = '<c-l>'

-- Stop automatic comment continuation on newline
vim.cmd("autocmd BufEnter * set formatoptions-=cro")

vim.cmd.colorscheme("rose-pine")
