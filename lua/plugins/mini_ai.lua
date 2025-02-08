return {
  {
    'echasnovski/mini.ai',
    version = '*',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      local ai = require('mini.ai')
      ai.setup {
        custom_textobjects = {
          s = { '%[%[().-()%]%]' },
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' })
        }
      }
    end
  },
}
