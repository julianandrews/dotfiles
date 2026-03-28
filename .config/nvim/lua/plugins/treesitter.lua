return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- Neccessary for neovim 0.11
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
    "lua",
    "rust",
    "typescript",
    "python",
    "bash",
    "yaml",
    "json",
    "toml",
    "cpp",
    "c",
    "dockerfile",
  },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
