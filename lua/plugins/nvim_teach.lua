return {
  {
    dir = vim.fn.expand("~/Projects/neovim_teach"),
    name = "nvim-teach",
    lazy = false,
    priority = 100,
    config = function()
      require("nvim-teach").setup({})
      require("nvim-teach.mcp")
    end,
  },
}
