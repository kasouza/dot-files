vim.keymap.set('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>')
vim.keymap.set('n', '<leader>dr', '<cmd>lua require"dap".repl.open()<CR>')

vim.keymap.set('n', '<leader>ds', '<cmd>lua require"dap".step_over()<CR>')
vim.keymap.set('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>')

local dap = require('dap')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/kaso/Build/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000
  }
}
