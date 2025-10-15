return { { 'nvim-mini/mini.sessions', version = '*', opts = {
  autoread = true,  -- This reads session when you open nvim
  autowrite = true, -- Already default, saves when you quit
  directory = vim.fn.stdpath('data') .. '/sessions', -- Global sessions
  file = 'Session.vim', -- Local session file per directory
},
config = function(_, opts)
  require('mini.sessions').setup(opts)
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup('loadsession', { clear = true }),
      callback = function()
      if vim.fn.argc() == 0 then
          local session_file = vim.fn.getcwd() .. '/Session.vim'
          if vim.fn.filereadable(session_file) == 0 and vim.fn.isdirectory('.git') == 1 then
            -- For local sessions, use empty string as name
            require('mini.sessions').write('Session.vim', {}) end
        end

      end
    })
end
}}
