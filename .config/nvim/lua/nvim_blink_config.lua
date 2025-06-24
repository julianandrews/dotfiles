vim.opt.completeopt = { 'menuone', 'noselect' }

local has_blink, blink = pcall(require, 'blink.cmp')
if has_blink then
    vim.g.blink_icons_font_family = "DejaVuSansMono Nerd Font"
    blink.setup({
      sources = {
        default = { "lsp", "buffer", "path" },
      },
      keymap = {
        preset = "super-tab",
      },
    })
end
