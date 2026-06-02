return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "MCPHub" },
    build = "bundled_build.lua",
    config = function()
      require("mcphub").setup({
        use_bundled_binary = true,
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
      })
    end,
  },
}
