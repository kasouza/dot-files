local nvim_lsp = require('lspconfig')
local tiny_packager = require('tiny_packager');

function install_plugins() tiny_packager.install_plugins() end
vim.cmd('command! InstallPlugins :lua require\'tiny_packager\'.install_plugins()')

-- <plugins>
-- LSP config
tiny_packager.add_plugin('neovim/nvim-lspconfig')

-- Nerd Commenter
tiny_packager.add_plugin('preservim/nerdcommenter')

-- Vim arline
tiny_packager.add_plugin('vim-airline/vim-airline')
tiny_packager.add_plugin('vim-airline/vim-airline-themes')

-- C++
tiny_packager.add_plugin('octol/vim-cpp-enhanced-highlight')
-- Theme
tiny_packager.add_plugin('morhetz/gruvbox')

-- fzf
tiny_packager.add_plugin('junegunn/fzf')

-- emmet vim
tiny_packager.add_plugin('mattn/emmet-vim')

-- js
tiny_packager.add_plugin('pangloss/vim-javascript')
tiny_packager.add_plugin('maxmellon/vim-jsx-pretty')


-- </plugins>


-- FZF
vim.cmd("nnoremap <leader>f :FZF<CR>")

-- Theme
vim.o.cursorline = true
vim.o.termguicolors = true
vim.cmd('autocmd vimenter * ++nested colorscheme gruvbox')
vim.cmd('let g:airline#extensions#tabline#enabled = 1')
vim.g.gruvbox_contrast_dark='hard'

-- Search
vim.o.incsearch = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.cinoptions:append {'L0'}
vim.cmd('autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab')

-- NERD Commenter
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1

-- emmet vim
vim.g.user_emmet_leader_key='<C-l>'

-- Other
vim.cmd('syntax enable')
vim.cmd('filetype plugin on')
vim.cmd('filetype plugin indent on')
vim.o.wrap = false
vim.cmd('set omnifunc=syntaxcomplete#Complete')
vim.opt.completeopt:remove { 'preview' }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = { 'clangd', 'tsserver' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150
		}
	}
end

