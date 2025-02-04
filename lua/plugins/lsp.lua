local function setUpLSPKeybinds(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then return end
  local map = vim.keymap.set
  -- Diagnostic keymaps
  map('n', '<leader>e', function() vim.diagnostic.open_float { border = 'rounded' } end,
    { desc = 'Show diagnostic [E]rror messages' })
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
  map('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, { desc = 'Show next diagnostic message' })
  map('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, { desc = 'Show previous diagnostic message' })
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- LSP settings (for overriding per client)
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          local capabilities = require('blink.cmp').get_lsp_capabilities()
          require("lspconfig")[server_name].setup { capabilities = capabilities }
        end,
        -- TODO: Custom setups for servers.
        --
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --   require("rust-tools").setup {}
        -- end

        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then return end
            setUpLSPKeybinds(args)
            if client.supports_method('textDocument/formatting') then
              -- Format the current buffer on save
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
              })
            end
          end,
        })
      }
    end,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    }
  }
}
