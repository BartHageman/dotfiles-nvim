return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      animate = { enabled = false },
      indent = { hl = "BlinkCmpDefault" },
      scope = { enabled = true },
    },
    notifier = { enabled = true },
    scratch = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true, ui_select = true },
    statuscolumn = {
      enabled = true,
      folds = { open = true, git_hl = false },
    },
  },
  keys = {
    { "<leader>.",  function() Snacks.scratch() end,         desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,  desc = "Select Scratch Buffer" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end,   desc = "Dismiss All Notifications" },
  },
}
