if vim.g.vscode then
    -- VSCode extension
    require('kaso.set')
else
    -- ordinary Neovim
    require('kaso.packer')
    require('kaso.lsp')
    require('kaso.set')
    require('kaso.remap')

    vim.cmd('command! HeaderGuards :lua require\'kaso.header_guards\'.header_guards("KASOUZA")')
    vim.keymap.set('n', '<leader>h', ':HeaderGuards<CR>')

    vim.cmd("filetype plugin on")
end
