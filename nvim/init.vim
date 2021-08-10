call plug#begin('~/.vim/plugged')

" LSP config
Plug 'neovim/nvim-lspconfig'

" NERD plugins
Plug 'scrooloose/nerdcommenter'

" Emmet
Plug 'mattn/emmet-vim'

" Vim arline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Rust
Plug 'rust-lang/rust.vim'

" C++
Plug 'octol/vim-cpp-enhanced-highlight'

" GLSL highlighting
Plug 'tikhomirov/vim-glsl'

" Tagbar
Plug 'preservim/tagbar'

" Toml
Plug 'cespare/vim-toml'

" Javascript
Plug 'pangloss/vim-javascript'

" Theme
Plug 'morhetz/gruvbox'

" LSP
Plug 'neovim/nvim-lspconfig'

call plug#end()

" Themes
set t_Co=256
set cursorline
autocmd vimenter * ++nested colorscheme gruvbox

let g:gruvbox_contrast_dark='hard'

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Airline
let g:airline#extensions#tabline#enabled = 1

" Emmet config
let g:user_emmet_mode='a'
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-L>'
autocmd FileType html,css EmmetInstall

" NERD Commenter Config 
let g:NERDSpaceDelims = 1       " Add spaces after comment delimiters by default
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines

" Tagbar
nmap <leader>t :TagbarToggle<CR>

" Search options
set incsearch

" Line numbers
set number
set relativenumber

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Other
syntax enable
filetype plugin on
filetype plugin indent on
set cinoptions+=L0

lua << EOF
local nvim_lsp = require('lspconfig')

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
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local servers = { 'clangd' }

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150
		}
	}
end
EOF

" Disable preview
set completeopt-=preview

set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

lua << EOF
nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = { 'clangd' }
for _, lang in ipairs(servers) do
	nvim_lsp[lang].setup{
		on_attach = on_attach,
	}
end
EOF
