return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>o", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  init = function()
    vim.api.nvim_create_autocmd("WinEnter", {
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "Outline" then
          vim.cmd("quit")
        end
      end,
    })
  end,
  opts = {
    outline_window = {
      position = "right",
      width = 30,
      relative_width = false,
      auto_close = false,
      auto_jump = false,
      jump_highlight_duration = 200,
    },
    outline_items = {
      show_symbol_details = false,
      show_symbol_lineno = false,
      highlight_hovered_item = true,
      auto_set_cursor = true,
    },
    symbol_folding = {
      autofold_depth = 1,
      auto_unfold = { hovered = true, only = true },
      markers = { "", "" },
    },
    preview_window = {
      auto_preview = false,
      border = "rounded",
    },
    guides = { enabled = true },
  },
}
