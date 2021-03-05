local lsp = require'lspconfig'
local handlers = require'lspsetup.handlers'
local dartls = require'lspsetup.dartls'

-- Init
lsp.tsserver.setup{}
lsp.gopls.setup{}
lsp.vuels.setup{}
lsp.vimls.setup{}
lsp.cssls.setup{}
lsp.rust_analyzer.setup{}
lsp.jedi_language_server.setup{}
lsp.bashls.setup{}

-- Custom handlers
vim.lsp.handlers['textDocument/codeAction'] = handlers.code_action_callback

-- Lua {{{
lsp.sumneko_lua.setup{
  cmd={vim.fn.expand('$HOME')..'/builds/lua-language-server/bin/macOS/lua-language-server'},
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
  init_options = dartls.init_options,
  capabilities = dartls.capabilities,
  handlers = {
    ['dart/textDocument/publishClosingLabels'] = dartls.on_closing_labels,
    -- ['dart/textDocument/publishOutline'] = dartls.on_outline,
    ['dart/textDocument/publishFlutterOutline'] = dartls.show_flutter_ui_guides,
  };
}
-- }}}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { "bash" }
  },
}

-- Completion
require'compe'.setup {
  enabled = true;
  debug = false;
  min_length = 2;
  preselect = 'disable';
  -- throttle_time = ... number ...;
  -- source_timeout = ... number ...;
  -- incomplete_delay = ... number ...;
  allow_prefix_unmatch = false;

  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}

-- Treesitter objects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ib"] = "@call.inner",
        ["ab"] = "@call.outer",
      },
    },
  },
}
