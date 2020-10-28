local lsp = require'nvim_lsp'
local callbacks = require'lspsetup.callbacks'
local dartls = require'lspsetup.dartls'

-- Init
lsp.tsserver.setup{on_attach=require'diagnostic'.on_attach}
lsp.gopls.setup{on_attach=require'diagnostic'.on_attach}
lsp.vuels.setup{on_attach=require'diagnostic'.on_attach}
lsp.vimls.setup{}
lsp.cssls.setup{}
lsp.rust_analyzer.setup{}

-- Custom callbacks
vim.lsp.callbacks['textDocument/codeAction'] = callbacks.code_action_callback

-- Lua {{{
lsp.sumneko_lua.setup{
  on_attach=require'diagnostic'.on_attach,
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
}
-- }}}

-- Dart + Flutter {{{
lsp.dartls.setup{
  on_attach = require'diagnostic'.on_attach,
  init_options = dartls.init_options,
  capabilities = dartls.capabilities,
  callbacks = {
    ['dart/textDocument/publishClosingLabels'] = dartls.on_closing_labels,
    -- ['dart/textDocument/publishOutline'] = dartls.on_outline,
    ['dart/textDocument/publishFlutterOutline'] = dartls.show_flutter_ui_guides,
  };
}
-- }}}

-- Treesitter
-- require'nvim-treesitter.configs'.setup {
--   indent = {
--     enable = true
--   },
--   highlight = {
--     enable = true,
--   },
-- }
