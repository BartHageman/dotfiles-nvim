return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "nvim-teach",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion: toggle chat" },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "CodeCompanion: actions" },
      { "<leader>ai", ":CodeCompanion ",                    mode = { "n", "v" }, desc = "CodeCompanion: inline prompt" },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>",     mode = "v",          desc = "CodeCompanion: add selection to chat" },
    },
    opts = function()
      return {
      extensions = {
        nvim_teach = {
          callback = "nvim-teach.codecompanion.extension",
          opts = {},
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true
          }
        }
      },
      strategies = {
        chat = {
          adapter = "ollama",
          tools = {
            teach_bubble        = { callback = require("nvim-teach.tools.teach_bubble"),     description = "Place an annotation bubble at a code location" },
            teach_highlight     = { callback = require("nvim-teach.tools.teach_highlight"),  description = "Highlight a range of code" },
            teach_tour          = { callback = require("nvim-teach.tools.teach_tour"),       description = "Run a multi-step teaching tour" },
            teach_ask           = { callback = require("nvim-teach.tools.teach_ask"),        description = "Ask the user a question via a bubble" },
            teach_wait_reply    = { callback = require("nvim-teach.tools.teach_wait_reply"), description = "Wait for the user to reply to a bubble" },
            teach_clear         = { callback = require("nvim-teach.tools.teach_clear"),      description = "Clear bubbles and highlights" },
            teach_get_selection = { callback = require("nvim-teach.tools.teach_get_selection"), description = "Get the user's current selection" },
          },
        },
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
                model     = { default = "gemma4:31b" },
                num_ctx   = { default = 16384 },
              },
            })
          end,
        },
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {})
          end,
        },
      },
      display = {
        chat = {
          window = { width = 0.4 },
        },
      },
      }
    end,
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
