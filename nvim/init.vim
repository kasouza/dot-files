call plug#begin('~/.vim/plugged')

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

" Binds <C-f> to opens nerdtree
nnoremap <leader>f :NERDTree<CR>

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
