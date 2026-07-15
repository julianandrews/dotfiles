return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()

    require('nvim-treesitter').install({
      "lua", "rust", "typescript", "python", "bash", "yaml",
      "json", "toml", "cpp", "c", "dockerfile", "diff",
      "markdown", "markdown_inline",
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
