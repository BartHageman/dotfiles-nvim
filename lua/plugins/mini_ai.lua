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
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to, vis_mode = 'V' }
          end,

          s = { '%[%[().-()%]%]' },
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' })
        }
      }
      vim.keymap.set("n", "gxna", "<Cmd>normal gxiagxina<CR>")
      vim.keymap.set("n", "gxpa", "<Cmd>normal gxiagxipa<CR>")
    end
  },
}
