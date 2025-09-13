return {
  {

    'mfussenegger/nvim-dap',
    dependencies = { 'mfussenegger/nvim-dap-python',
      'williamboman/mason.nvim',
      "jay-babu/mason-nvim-dap.nvim",
      "igorlfs/nvim-dap-view",
      'theHamsta/nvim-dap-virtual-text'
    },
    config = function()
      local dap = require('dap')
      local view = require('dap-view')
      require('dap').set_log_level('TRACE')
      -- Setup nvim-dap-python FIRST
      -- This handles the Python adapter configuration properly
      local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
      require('dap-python').setup(mason_path .. "packages/debugpy/venv/bin/python")

      -- Now add your custom attach configurations
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'attach',
        name = 'Attach to remote debugpy (port 5678)',
        connect = { -- Note: use 'connect' not direct host/port
          host = '127.0.0.1',
          port = 5678,
        },
      })

      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'attach',
        name = 'Attach to running Python process',
        processId = require('dap.utils').pick_process,
      })
      -- Setup Mason DAP for OTHER languages (not Python)
      require("mason-nvim-dap").setup {
        ensure_installed = {},
        automatic_installation = true,
        handlers = {
          function(config)
            -- Default handler for all except Python
            if config.name ~= 'python' then
              require('mason-nvim-dap').default_setup(config)
            end
          end,
          -- Skip Python since nvim-dap-python handles it
          python = function(config)
            -- Do nothing - nvim-dap-python handles this
          end,
        },
      }
      require("nvim-dap-virtual-text").setup {}
      -- DapBreakpoint for breakpoints (default: B)
      -- DapBreakpointCondition for conditional breakpoints (default: C)
      -- DapLogPoint for log points (default: L)
      -- DapStopped to indicate where the debugee is stopped (default: →)
      -- DapBreakpointRejected to indicate breakpoints rejected by the debug
      -- adapter (default: R)
      --
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignOk', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })


      vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>bc", function()
        vim.ui.input({ prompt = "Breakpoint Condition:" }, function(result)
          if result then
            dap.toggle_breakpoint(result)
          end
        end)
      end)
      vim.keymap.set('n', '<Leader>bl',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set("n", "<leader>dap", dap.continue)
      vim.keymap.set("n", "<leader>td", view.toggle)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
      -- @param view "breakpoints" | "exceptions" | "watches" | "repl" | "threads" | "console" | "scopes" | "sessions" | string
      vim.keymap.set("n", "<space>db", function() require("dap-view").jump_to_view("breakpoints") end)
      vim.keymap.set("n", "<space>de", function() require("dap-view").jump_to_view("exceptions") end)
      vim.keymap.set("n", "<space>dw", function() require("dap-view").jump_to_view("watches") end)
      vim.keymap.set("n", "<space>dr", function() require("dap-view").jump_to_view("repl") end)
      vim.keymap.set("n", "<space>dt", function() require("dap-view").jump_to_view("threads") end)
      vim.keymap.set("n", "<space>dc", function() require("dap-view").jump_to_view("console") end)
      vim.keymap.set("n", "<space>dsc", function() require("dap-view").jump_to_view("scopes") end)
      vim.keymap.set("n", "<space>dse", function() require("dap-view").jump_to_view("sessions") end)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F9>", dap.step_into)
      vim.keymap.set("n", "<F7>", dap.step_over)
      vim.keymap.set("n", "<F6>", dap.step_out)
      vim.keymap.set("n", "<F6>", dap.step_back)
      local function smart_continue()
        -- Don't run from DAP windows - could cause issues
        local ft = vim.bo.filetype
        if ft == 'dap-repl' or ft == 'dap-terminal' or ft == 'dap-view' then
          return
        end

        local session = require('dap').session()
        if session then
          require('dap').restart()
        else
          require('dap').run_last()
        end
      end
      vim.keymap.set("n", "<F12>", smart_continue) -- Restart, otherwise run last

      dap.listeners.before.attach.dapui_config = function()
        view.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        view.open()
      end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   view.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   view.close()
      -- end
    end,
  }
}
