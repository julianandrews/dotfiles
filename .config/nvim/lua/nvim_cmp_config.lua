local has_cmp,cmp = pcall(require, 'cmp')

if has_cmp then
    local has_luasnip,luasnip = pcall(require, 'luasnip')
    if not has_luasnip then
        print("Luasnip not installed")
        return
    end
    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<S-TAB>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        }),
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
        }, {
            { name = "buffer", keyword_length = 3 },
        }),
    })
end
