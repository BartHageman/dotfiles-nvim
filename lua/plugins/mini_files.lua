return {
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup {
        windows = {
          -- Maximum number of windows to show side by side
          max_number = 1,
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 80,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 25,
        },
        options = {
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = true,
          -- Whether to use for editing directories
          use_as_default_explorer = false,
        },
      }
      --vim.keymap.set('n', '<leader>te', MiniFiles.open)
    end
  },
}
