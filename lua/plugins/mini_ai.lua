return {
  {
    'echasnovski/mini.ai',
    version = '*',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      local ai = require('mini.ai')

      ai.setup {
        mappings = {
          -- Around previous, not last!
          around_last = 'ap',
          inside_last = 'ip'
        },
        custom_textobjects = {
          s = { '%[%[().-()%]%]' },
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' })
        }
      }
      vim.keymap.set("n", "gxna", "<Cmd>normal gxiagxina<CR>")
      vim.keymap.set("n", "gxpa", "<Cmd>normal gxiagxipa<CR>")
    end
  },
}
