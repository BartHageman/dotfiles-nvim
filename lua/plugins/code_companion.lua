return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion: toggle chat" },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "CodeCompanion: actions" },
      { "<leader>ai", ":CodeCompanion ",                    mode = { "n", "v" }, desc = "CodeCompanion: inline prompt" },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>",     mode = "v",          desc = "CodeCompanion: add selection to chat" },
    },
    opts = {
      strategies = {
        chat   = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "https://ollama.barthackerman.com",
              },
              schema = {
                model     = { default = "codegemma:latest" },
                num_ctx   = { default = 16384 },
              },
            })
          end,
        },
      },
      display = {
        chat = {
          window = { width = 0.4 },
        },
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
}
