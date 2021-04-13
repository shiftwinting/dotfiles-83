local lsp = require'lspconfig'
local handlers = require'lspsetup.handlers'
local dartls = require'lspsetup.dartls'

-- Init
lsp.vuels.setup{}
lsp.vimls.setup{}
lsp.cssls.setup{}
lsp.rust_analyzer.setup{}
lsp.jedi_language_server.setup{}
lsp.bashls.setup{}

-- Custom handlers
vim.lsp.handlers['textDocument/codeAction'] = handlers.code_action_callback

-- gopls
lsp.gopls.setup{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
}

-- tsserver
lsp.tsserver.setup{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
}

-- Lua {{
local system_name

if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.expand('$HOME')..'/builds/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'

lsp.sumneko_lua.setup{
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
  settings={
    Lua={
      runtime={ version="LuaJIT", path=vim.split(package.path, ';') },
      completion={ keywordSnippet="Disable" },
      diagnostics={
        enable=true,
        globals= { 'vim', 'describe', 'it', 'before_each', 'after_each' }
      },
      workspace={
        library={
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        }
      },
      telemetry = {
        enable = false,
      },
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
    ultisnips = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}

-- Diagnostics with ALE
require'nvim-ale-diagnostic'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- lspsaga
local saga = require 'lspsaga'
saga.init_lsp_saga()

