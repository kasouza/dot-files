return require('packer').startup(function(use)
    use 'mfussenegger/nvim-jdtls'

    -- use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    -- use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    -- use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    -- use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    -- use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'tikhomirov/vim-glsl'
    use 'github/copilot.vim'
    use 'prisma/vim-prisma'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    use 'fatih/vim-go'

    use 'elixir-editors/vim-elixir'
    use { 'neoclide/coc.nvim', branch = 'release' }
    use 'lervag/vimtex'
    use 'beanworks/vim-phpfmt'
    use 'jwalton512/vim-blade'
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    -- use { "ellisonleao/gruvbox.nvim" }

    use 'mattn/emmet-vim'

    use 'mbbill/undotree'

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'

    -- Simple plugins can be specified as strings
    use 'rstacruz/vim-closer'

    -- Load on an autocommand event
    use { 'andymass/vim-matchup', event = 'VimEnter' }

    -- Load on a combination of conditions: specific filetypes or commands
    -- Also run code after load (see the "config" key)
    use {
        'dense-analysis/ale',
        ft = { 'sh', 'zsh', 'bash', 'c', 'cpp', 'javascript', 'typescript', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex' },
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Use specific branch, dependency and run lua file after load
    use {
        'glepnir/galaxyline.nvim', branch = 'main', config = function() require 'statusline' end,
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- Use dependency and run lua function after load
    use {
        'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-tree/nvim-web-devicons' },
            { 'sharkdp/fd' },
        }
    }

    use { 'preservim/nerdcommenter' }
end)
