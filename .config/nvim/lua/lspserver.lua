local lsp = require'nvim_lsp'

lsp.tsserver.setup{on_attach=require'diagnostic'.on_attach}
lsp.gopls.setup{on_attach=require'diagnostic'.on_attach}
lsp.vuels.setup{on_attach=require'diagnostic'.on_attach}
lsp.sumneko_lua.setup{on_attach=require'diagnostic'.on_attach}
lsp.vimls.setup{}
lsp.cssls.setup{}
lsp.dartls.setup{on_attach=require'diagnostic'.on_attach}

-- vim.lsp.set_log_level("debug")
