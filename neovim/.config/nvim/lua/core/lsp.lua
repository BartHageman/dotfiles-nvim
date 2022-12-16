local M = {}

local my_arduino_fqbn = {
    ["/home/bart/Arduino/OwlLight"] = "arduino:avr:nano:cpu=atmega328old",
    -- ["/home/h4ck3r/dev/arduino/sensor"] = "arduino:mbed:nanorp2040connect",
}

local DEFAULT_FQBN = "arduino:avr:uno"


M.setupErrorSigns = function()
    -- Show a pretty icon in the sidebar for LSP error, warning, information and hint messages.
    vim.cmd([[
        sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
        sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
        sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
        sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
    ]])

    -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    -- for type, icon in pairs(signs) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    -- end
end
M.setupLspVirtualText = function()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '◉', -- Could be '●', '▎', 'x', '■'
      }
    })
end

local setupKeymaps = function()
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = 0})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = 0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
    vim.keymap.set("n", "dn", vim.diagnostic.goto_prev, {buffer = 0})
    vim.keymap.set("n", "dp", vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = 0})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0})
    vim.keymap.set("n", "<leader>sd" ,vim.diagnostic.open_float, {buffer = 0})
end

M.setupLanguageServers = function()
    -- local servers = {"sumneko_lua", "vimls", "tsserver", "jsonls", "pyright"}

    local opts = {}
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    opts.capabilities = capabilities
    opts.on_attach = setupKeymaps

    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup(opts)
        end,
        ["sumneko_lua"] = function ()
            require("lspconfig")["sumneko_lua"].setup(LuaSetup(opts))
        end,
        ["rust_analyzer"] = function ()
            require("rust-tools").setup({server = opts})
        end
    }
    -- for _,server in pairs(servers) do
    --     local lsp = server;
    --     local opts = {}
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    --     opts.capabilities = capabilities
    --     opts.on_attach = setupKeymaps
    --     if lsp == "sumneko_lua" then
    --         opts = LuaSetup(opts)
    --     end
    --     if lsp == "arduino_language_server" then
    --         opts.on_new_config = function (config, root_dir)
    --             local partial_cmd = server.get_default_options().cmd
    --             local fqbn = my_arduino_fqbn[root_dir]
    --             if not fqbn then
    --                 vim.notify(("FQBN not set for directory. Using %q."):format(DEFAULT_FQBN))
    --                 fqbn = DEFAULT_FQBN
    --             end
    --             config.cmd = vim.list_extend(partial_cmd, { "-fqbn", fqbn })
    --         end
    --     end
    --     require('lspconfig')[lsp].setup(opts)
    --     vim.cmd [[ do User LspAttachBuffers ]]
    -- end
end

function PrettifyDiagnostics()
    local orig_diag_open_float = vim.diagnostic.open_float
    function vim.diagnostic.open_float(opts)
        opts = opts or {}
        opts.scope = opts.scope or "line"
        opts.header = opts.header or {"🩺 Diagnostics","Blue"}
        opts.border = opts.border or {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}
        opts.prefix = opts.prefix or {"›  ", "Grey"}
        return orig_diag_open_float(opts)
    end
end


function LuaSetup(opts)
   local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    opts.settings = {
        Lua = {
          runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = runtime_path,
          },
            diagnostics = {
            globals = { "vim" },
          },
          workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              maxPreload = 100000,
              preloadFileSize = 10000,
              checkThirdParty = false -- Disable the stupid LOVE message
          },
          completion = {
                keywordSnippet = "Disable", -- Don't do snippets stuff
                showWord = "Disable"    -- Document show buffer stuff, I can do this with builtin vim.
          },
          telemetry = {
              enable = false,
          },
      },
  }
  return opts
end

function AddLspBorders()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            -- Use a double border with `FloatBorder` highlights
            border = {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}
        }
    )
end

M.setup = function()
    AddLspBorders()
    PrettifyDiagnostics()
    -- M.setupErrorSigns()
    M.setupLanguageServers()
    M.setupLspVirtualText()
end

return M
