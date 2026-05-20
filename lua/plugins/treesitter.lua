return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then return end

        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang and not vim.tbl_contains(require("nvim-treesitter.config").get_installed(), lang) then
          require("nvim-treesitter").install({ lang }):await(function()
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                pcall(vim.treesitter.start, args.buf)
              end
            end)
          end)
        end

        pcall(vim.treesitter.start)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
