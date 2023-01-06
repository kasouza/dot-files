local nvim_lsp = require('lspconfig')
local tiny_packager = require('tiny_packager');

function install_plugins() tiny_packager.install_plugins() end
vim.cmd('command! InstallPlugins :lua require\'tiny_packager\'.install_plugins()')

-- <plugins>
-- LSP config
tiny_packager.add_plugin('neovim/nvim-lspconfig')
tiny_packager.add_plugin('rust-lang/rust.vim')

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

-- Treesitter
tiny_packager.add_plugin('nvim-treesitter/nvim-treesitter')

-- Java
tiny_packager.add_plugin('mfussenegger/nvim-jdtls')

-- GLSL
tiny_packager.add_plugin('tikhomirov/vim-glsl')

-- Python Virtual Environments
tiny_packager.add_plugin('jmcantrell/vim-virtualenv')

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
vim.cmd('autocmd FileType typescriptreact,typescript,javascript setlocal shiftwidth=2 softtabstop=2 expandtab')
vim.cmd('autocmd FileType gdscript setlocal shiftwidth=4 softtabstop=4 expandtab')

-- NERD Commenter
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1

-- emmet vim
vim.g.user_emmet_leader_key='<C-l>'

-- treesitter
require('nvim-treesitter.configs').setup{
	highlight = {
		enabled = true
	}
}

-- Other
vim.cmd('syntax enable')
vim.cmd('filetype plugin on')
vim.cmd('filetype plugin indent on')
vim.o.wrap = false
vim.cmd('set omnifunc=syntaxcomplete#Complete')
vim.opt.completeopt:remove { 'preview' }
vim.opt.clipboard:append { 'unnamedplus' }
vim.cmd('inoremap <ECS> <C-\\><C-n>')
vim.cmd('inoremap jk <C-\\><C-n>')

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
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
end

require'lspconfig'.omnisharp.setup {
	cmd = { "dotnet", "/lib/omnisharp-roslyn/OmniSharp.dll" },

	-- Enables support for reading code style, naming convention and analyzer
	-- settings from .editorconfig.
	enable_editorconfig_support = true,

	-- If true, MSBuild project system will only load projects for files that
	-- were opened in the editor. This setting is useful for big C# codebases
	-- and allows for faster initialization of code navigation features only
	-- for projects that are relevant to code that is being edited. With this
	-- setting enabled OmniSharp may load fewer projects and may thus display
	-- incomplete reference lists for symbols.
	enable_ms_build_load_projects_on_demand = false,

	-- Enables support for roslyn analyzers, code fixes and rulesets.
	enable_roslyn_analyzers = false,

	-- Specifies whether 'using' directives should be grouped and sorted during
	-- document formatting.
	organize_imports_on_format = true,

	-- Enables support for showing unimported types and unimported extension
	-- methods in completion lists. When committed, the appropriate using
	-- directive will be added at the top of the current file. This option can
	-- have a negative impact on initial completion responsiveness,
	-- particularly for the first few completion sessions after opening a
	-- solution.
	enable_import_completion = false,

	-- Specifies whether to include preview versions of the .NET SDK when
	-- determining which version to use for project loading.
	sdk_include_prereleases = true,

	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
	-- true
	analyze_open_documents_only = false,
	on_attach = on_attach,
}

local servers = { 'anakin_language_server', 'rust_analyzer', 'clangd', 'tsserver', 'gdscript', 'tailwindcss' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150
		}
	}
end

-- Treesitter
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
}

vim.cmd('nnoremap <leader>t :wincmd v<bar> :Ex <bar> :vertical resize 20<CR>')
