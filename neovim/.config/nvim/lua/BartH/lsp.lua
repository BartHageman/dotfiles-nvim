-- local lsp = require('lsp-zero')
local mason = require('mason')
mason.setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
  }
})
-- lsp.preset('lsp-compe')
require('BartH.setups.cmp')
-- lsp.set_preferences({
--     cmp_capabilities = true,
--     set_lsp_keymaps = false,
--     sign_icons = {
--         error = '',
--         warn = '',
--         hint = '',
--         info = ''
--       }
-- })
--

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local lsp_attach = function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}
  local bind = function(lhs, rhs)
        vim.keymap.set("n", lhs, rhs, opts)
  end
    bind("gd", vim.lsp.buf.definition)
    bind("gD", vim.lsp.buf.declaration)
    bind("gr", vim.lsp.buf.references)
    bind("gi", vim.lsp.buf.implementation)
    bind("dn", vim.diagnostic.goto_prev)
    bind("dp", vim.diagnostic.goto_next)
    bind("dqf", vim.diagnostic.setqflist)
    bind("K", vim.lsp.buf.hover)
    bind("<leader>rn", vim.lsp.buf.rename)
    bind("<leader>ca", vim.lsp.buf.code_action)
    bind("<leader>sd" ,vim.diagnostic.open_float)
end
-- lsp.on_attach(lspOnAttach)

local lsp_settings = {
    lua_ls = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                maxPreload = 100000,
                preloadFileSize = 10000,
                checkThirdParty = false
            },
            completion = {
                keywordSnippet = "Disable", -- Don't do snippets stuff
                showWord = "Disable"    -- Document show buffer stuff, I can do this with builtin vim.
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    pylsp = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'E501'},
                    maxLineLength = 100
                }
            }
        }
    }
}

local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.papyrus then
 configs.papyrus = {
   default_config = {
     cmd = {'DarkId.Papyrus.Host.Fallout4.exe', '--compilerAssemblyPath', "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Fallout 4\\Papyrus Compiler", "--flagsFileName", "Institute_Papyrus_Flags", "--ambientProjectName", "SPF", "--creationKitInstallPath", "C:\\Program Files\\ (x86)\\Steam\\steamapps\\common\\Fallout 4", "--relativeIniPaths", "."},
     filetypes = {'papyrus'},
     root_dir = require('lspconfig').util.root_pattern('.git', '.papyrusroot'),
     settings = {},
   },
 }
end

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = lsp_settings[server_name] or {}
        })
    end,
})


require('lspconfig').papyrus.setup{on_attach = lsp_attach}
-- lsp.setup()

-- Borders around the outside of the hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = {"🭽", "▔", "🭾", " ", "🭿", "▁", "🭼", " "}
    }
)

vim.api.nvim_set_hl(0, "DiagnosticTitle", {italic = false, bold=true, fg="#d4be98"})
local opts = {
scope = "line",
header =  {"律DIAGNOSTICS ","DiagnosticTitle"},
border = {"🭽", "▔", "🭾", " ", "🭿", "▁", "🭼", " "},
-- opts.prefix = opts.prefix or {"›  ", "Grey"}
prefix = function(diagnostic, i, total)
    if (i ~= total) then
        return "├ ", "Grey"
    else
        return "└ ", "Grey"
    end
end
}
vim.diagnostic.config{float = opts}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = '◉', -- Could be '●', '▎', 'x', '■'
  }
})
