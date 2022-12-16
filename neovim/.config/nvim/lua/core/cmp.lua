local M = {}



M.config = function()
  local status_cmp_ok, cmp = pcall(require, "cmp")
  if not status_cmp_ok then
    return
  end
  local status_luasnip_ok, luasnip = pcall(require, "luasnip")
  if not status_luasnip_ok then
    return
  end
  customsettings.cmp = {
        enabled = function()
            local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
            if in_prompt then
                return false
            end
            local context = require "cmp.config.context"
            return not (context.in_treesitter_capture "comment" == true or context.in_syntax_group "Comment")
        end,
        window = {
            -- completion = {
            --     border = {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}
            -- },
            documentation = {
                -- border = "rounded"
                border = {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}
            }
        },
        experimental = {
            ghost_text = true,
        },
        confirmation = {
            get_commit_characters = function()
                return {}
            end,
        },
        view = {
            entries = "custom",
        },
        completion = {
            completeopt = "menuone,noinsert,noselect",
            keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
            keyword_length = 1,
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            kind_icons = {
                Class = " ",
                Color = " ",
                Constant = " ",
                Constructor = " ",
                Enum = "練",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = "",
                Folder = " ",
                Function = " ",
                Interface = "ﰮ ",
                Keyword = " ",
                Method = " ",
                Module = " ",
                Operator = "",
                Property = " ",
                Reference = " ",
                Snippet = " ",
                Struct = " ",
                Text = " ",
                TypeParameter = " ",
                Unit = "塞",
                Value = " ",
                Variable = " ",
            },
            source_names = {
                nvim_lsp = "LSP",
                emoji = "Emoji",
                path = "Path",
                calc = "Calc",
                vsnip = "Snippet",
                luasnip = "Snippet",
                buffer = "Buffer",
                nvim_lua = "Lua",
                treesitter = "Treesitter",
                crates = "Crates",
            },
            format = function(entry, vim_item)
                vim_item.kind = customsettings.cmp.formatting.kind_icons[vim_item.kind]
                vim_item.menu = customsettings.cmp.formatting.source_names[entry.source.name]
                return vim_item
            end,
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "luasnip"},
            { name = "nvim_lua" },
            { name = "buffer", keyword_length = 5},
            { name = "calc" },
            { name = "emoji" },
            { name = "treesitter" },
            { name = "crates" },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-y>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
        })
  }
end

M.setup = function()
    require("luasnip/loaders/from_vscode").lazy_load()
    require("cmp").setup(customsettings.cmp)
end

return M
