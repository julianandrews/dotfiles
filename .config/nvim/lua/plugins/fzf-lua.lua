return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      local map = vim.keymap.set

      map("n", "<leader>f", "<Cmd>FzfLua files<CR>", { desc = "Find Files" })
      map("n", "<leader>b", "<Cmd>FzfLua buffers<CR>", { desc = "Find Buffers" })
      map("n", "<leader>g", "<Cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
    end,
  },
}
