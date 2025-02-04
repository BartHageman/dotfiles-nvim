return {
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup()
      vim.keymap.set('n', '<leader>te', MiniFiles.open)
    end
  },
}
