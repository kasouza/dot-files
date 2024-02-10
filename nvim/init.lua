if vim.g.vscode then
    -- VSCode extension
    require('kaso.set')
else
    -- ordinary Neovim
    require('kaso.packer')
    -- require('kaso.lsp')
    require('kaso.set')
    require('kaso.remap')

    -- Make tailwind extension recognize we are in a project with tailwind
    vim.cmd("au FileType html,javascriptreact,typescriptreact,php,blade let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']")

    vim.cmd('command! HeaderGuards :lua require\'kaso.header_guards\'.header_guards("KASOUZA")')
    vim.keymap.set('n', '<leader>h', ':HeaderGuards<CR>')

    vim.cmd("filetype plugin on")
end
