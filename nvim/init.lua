-- START lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)
-- END lazy.nvim


-- START configs
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = "\\"
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.g.user_emmet_expandabbr_key = '<c-l>'

vim.opt.clipboard = 'unnamedplus'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("HOME") or "~") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.cmd("autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab")
vim.cmd("autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab")
vim.cmd("autocmd BufEnter * set formatoptions-=cro")                                                                                                      -- Stop automatic comment continuation on newline

vim.cmd("filetype on")
vim.cmd("filetype plugin on")
-- END confis



-- START remaps
vim.cmd("nnoremap <silent> <leader>gg :LazyGit<CR>")
-- END remaps



-- START plugins
require("lazy").setup({
    spec = {
        "neovim/nvim-lspconfig",
        "prisma/vim-prisma",
        "nvim-tree/nvim-web-devicons",
        "nvim-lualine/lualine.nvim",
        "nvim-lua/plenary.nvim",
        "kdheepak/lazygit.nvim",
        "nvim-tree/nvim-tree.lua",

        "beanworks/vim-phpfmt",
        "mbbill/undotree",
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                vim.cmd(":TSUpdate")
            end,
        },

        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "sharkdp/fd",
            }
        },
        "preservim/nerdcommenter",
        {
            "rose-pine/neovim",
            name = "rose-pine",
            config = function()
                vim.cmd("colorscheme rose-pine")
            end,
        },

        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
        },

        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'mfussenegger/nvim-dap',
    }
})
-- END plugins


-- START config-plugins
-- lualine
require('lualine').setup()

-- Telescope
require("telescope").setup {
    defaults = {
        preview = {
            filesize_limit = 0.1, -- MB
        },
    }
}


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files {
        hidden = true,
        -- Allow files in .gitignore
        no_ignore = true,
    }
end, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.cmd("filetype plugin on")

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

-- Treesitter
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    -- Needed because treesitter highlight turns off autoindent for php files
    indent = {
        enable = true,
    },
})

-- UndoTree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- NvimTree
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

-- nvim-dap
-- nvim-dap mappings
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<cr>', {})
vim.keymap.set('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<cr>', {})
vim.keymap.set('n', '<leader>dr', '<cmd>lua require"dap".repl.toggle()<cr>', {})
vim.keymap.set('n', '<leader>ds', '<cmd>lua require"dap".step_over()<cr>', {})
vim.keymap.set('n', '<leader>di', '<cmd>lua require"dap".step_into()<cr>', {})
vim.keymap.set('n', '<leader>do', '<cmd>lua require"dap".step_out()<cr>', {})
vim.keymap.set('n', '<leader>dl', '<cmd>lua require"dap".run_last()<cr>', {})

-- nvim-dap Adapters
require('dap').adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",

        args = { os.getenv("HOME") .. "/Apps/js-debug/src/dapDebugServer.js", "${port}" },
    }
}

require("dap").configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
}

-- END config-plugins

-- START LSP
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- These are example language servers.
require('lspconfig').ts_ls.setup({})
require('lspconfig').lua_ls.setup({})

require('lspconfig').intelephense.setup({
    init_options = {
        licenceKey = "/home/kaso/.config/nvim/intelephense.key",
    },
})

require('lspconfig').clangd.setup({})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- Map tab to confirm
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
})
-- END LSP
