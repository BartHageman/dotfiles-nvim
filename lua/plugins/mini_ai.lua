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
          around_last = 'al',
          inside_last = 'il'
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
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
          L = function(ai_type)
            local line_num = vim.fn.line('.')
            local line_content = vim.fn.getline(line_num)
            if ai_type == 'i' then
              -- il: content without leading/trailing whitespace, no newline
              local start_col = line_content:match('^%s*()') or 1
              local end_col = line_content:match('()%s*$') - 1
              if end_col < start_col then end_col = start_col end
              return {
                from = { line = line_num, col = start_col },
                to = { line = line_num, col = end_col }
              }
            else
              -- al: from start of line to end of content, no newline
              return {
                from = { line = line_num, col = 1 },
                to = { line = line_num, col = math.max(line_content:len(), 1) }
              }
            end
          end
        }
      }
      vim.keymap.set("n", "gxna", "<Cmd>normal gxiagxina<CR>")
      vim.keymap.set("n", "gxla", "<Cmd>normal gxiagxila<CR>")
    end
  },
}
