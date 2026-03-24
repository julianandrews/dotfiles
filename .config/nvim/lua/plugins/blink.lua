return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',
  dependencies = 'nvim-web-devicons',
  opts = {
    sources = {
      default = { 'lsp', 'buffer', 'path' },
    },
    keymap = {
      preset = 'super-tab',
    },
  },
}
