local lsp = require'nvim_lsp'
local dart_config = require'dartls'

lsp.tsserver.setup{on_attach=require'diagnostic'.on_attach}
lsp.gopls.setup{on_attach=require'diagnostic'.on_attach}
lsp.vuels.setup{on_attach=require'diagnostic'.on_attach}
lsp.vimls.setup{}
-- lsp.cssls.setup{}
lsp.rust_analyzer.setup{}

-- Lua {{{
lsp.sumneko_lua.setup{
  settings={
    Lua={
      runtime={ version="LuaJIT", path=vim.split(package.path, ';') };
      completion={ keywordSnippet="Disable" };
      diagnostics={
        enable=true,
        globals= { 'vim', 'describe', 'it', 'before_each', 'after_each' }
      };
      workspace={
        library={
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('~/build/neovim/src/nvim/lua')] = true,
        }
      }
    }
  };
  on_attach=require'diagnostic'.on_attach
}
-- }}}

-- Dart + Flutter {{{
lsp.dartls.setup{
  on_attach = require'diagnostic'.on_attach,
  init_options = dart_config.init_options,
  capabilities = dart_config.capabilities,
  callbacks = {
    ['dart/textDocument/publishClosingLabels'] = dart_config.on_closing_labels,
  };
}
-- }}}

-- vim.lsp.set_log_level("debug")
