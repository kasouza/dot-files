vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'php' },
  callback = function() vim.treesitter.start() end,
})
