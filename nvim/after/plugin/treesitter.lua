require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    -- Needed because treesitter highlight turns off autoindent for php files
    indent = {
        enable = true,
    },
})
