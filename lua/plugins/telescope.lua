-- plugins/telescope.lua:
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules' },
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '   ',
        color_devicons = false,
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
      },
      extension = {
        fzy_native = {}
      }
    }
    require('telescope').load_extension('fzy_native')


    vim.keymap.set("n", "<space>sk", require('telescope.builtin').keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<space>sf", require('telescope.builtin').find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<space>sd", require('telescope.builtin').diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<space>sb", require('telescope.builtin').builtin, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<space>sc", require('telescope.builtin').colorscheme, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<space>sh", require('telescope.builtin').help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<space>s.", require('telescope.builtin').oldfiles, { desc = "[S]earch Oldfiles [.]" })
    vim.keymap.set("n", "<space>ss", require('telescope.builtin').lsp_document_symbols,
      { desc = "[S]earch Document [S]ymbols" })
    vim.keymap.set("n", "<space>sw", require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { desc = "[S]earch [W]orkspace Symbols" })
    vim.keymap.set("n", "<space>s/", require('telescope.builtin').current_buffer_fuzzy_find,
      { desc = "[S]earch Current Buffer Fuzzily" })
    vim.keymap.set("n", "<space>sn", function()
      require('telescope.builtin').find_files(
        {
          cwd = vim.fn.stdpath("config")
        }
      )
    end, { desc = "[S]earch [N]eovim Config" })

    -- Search My Plugins
    vim.keymap.set("n", "<space>smp", function()
        require('telescope.builtin').find_files(
          {
            ---@diagnostic disable-next-line: param-type-mismatch
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
          }
        )
      end,
      { desc = "[S]earch [P]lugin [F]iles" }
    )
    require("config.telescope.multigrep").setup()
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-tree/nvim-web-devicons",             opts = {} },
    { 'nvim-telescope/telescope-fzy-native.nvim' }
  }
}
