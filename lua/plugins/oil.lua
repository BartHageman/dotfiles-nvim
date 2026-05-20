return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  lazy = false,
  opts = {
    default_file_explorer = true,
    view_options = { show_hidden = true },
    keymaps = {
      ["q"] = "actions.close",
    },
    float = {
      padding = 4,
      border = "rounded",
      win_options = { winblend = 0 },
    },
  },
  keys = {
    { "<leader>te", function() require("oil").toggle_float() end, desc = "Open File Manager (Oil)" },
  },
}
