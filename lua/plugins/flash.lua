return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false  
    },
    modes = {
      char = {
        highlight = { backdrop = false },
      },
      search = 
      {enabled = true}
    }
  },
  keys = {
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  }
}
