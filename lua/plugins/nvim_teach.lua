local path = "~/Projects/neovim_teach"
return {
  {
    dir = vim.fn.expand(path),
    cond = function()
      return vim.fn.isdirectory(vim.fn.expand(path)) == 1
    end,
    name = "nvim-teach",
    lazy = false,
    priority = 100,
    config = function()
      require("nvim-teach").setup({})
      require("nvim-teach.mcp")
    end,
  },
}
