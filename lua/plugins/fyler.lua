return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  config = function()
    require("fyler").setup({
      -- Replace netrw as default explorer
      default_explorer = true,

      -- Window configuration
      win = {
        -- Window border style
        border = "single",
        -- Default window kind
        kind = "float",
      },
    })
    vim.keymap.set("n", "<leader>te", ":Fyler<cr>", {desc="Open File Manager (Fyler)"})
  end
}
