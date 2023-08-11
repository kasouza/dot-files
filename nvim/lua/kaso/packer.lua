return require('packer').startup(function(use)
  use 'jwalton512/vim-blade'
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use 'mattn/emmet-vim'

  use 'mbbill/undotree'

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'

  -- Simple plugins can be specified as strings
  use 'rstacruz/vim-closer'

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'dense-analysis/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'javascript', 'typescript', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Use specific branch, dependency and run lua file after load
  use {
    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { 
      {'nvim-lua/plenary.nvim'},
      {'nvim-tree/nvim-web-devicons'},
      {'sharkdp/fd'},
    }
  }

  use { 'preservim/nerdcommenter' }
end)
