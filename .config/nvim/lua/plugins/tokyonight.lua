return {
    {
        "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("tokyonight").setup({
                    on_highlights = function(hl, c)
                        hl.DiffAdd    = { fg = c.git.add,    bg = "NONE" }
                        hl.DiffDelete = { fg = c.git.delete, bg = "NONE" }
                        hl.DiffChange = { fg = c.git.change, bg = "NONE" }
                    end,
                })
                vim.cmd.colorscheme("tokyonight-storm")
            end,
    },
}
