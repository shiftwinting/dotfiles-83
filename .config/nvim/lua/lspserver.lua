local lsp = require'nvim_lsp'
require'nvim_utils'

lsp.tsserver.setup{on_attach=require'diagnostic'.on_attach}
lsp.gopls.setup{on_attach=require'diagnostic'.on_attach}
lsp.vuels.setup{on_attach=require'diagnostic'.on_attach}
lsp.vimls.setup{}
lsp.cssls.setup{}

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
local dart_options = {
  onlyAnalyzeProjectsWithOpenFiles = false,
  suggestFromUnimportedLibraries = true,
  closingLabels = true,
  outline = true,
  flutterOutline = false
};

local closing_labels_namespace = vim.api.nvim_create_namespace('dart_closing_labels')

local on_closing_labels = function (...)
  local arg = {...}
  local labels = arg[3].labels

  vim.api.nvim_buf_clear_namespace(0, closing_labels_namespace, 0, -1)

  for i,l in ipairs(labels) do
    local name =  l.label
    local line = l.range['end'].line
    vim.api.nvim_buf_set_virtual_text(
      0,
      closing_labels_namespace,
      line,
      {{'// '..name, 'Comment'}},
      {}
    )
    print(i, name, line)
  end
end

local on_code_action = function (...)
  local arg = {...}
  print(vim.inspect(arg))
end

lsp.dartls.setup{
  on_attach=require'diagnostic'.on_attach;
  init_options=dart_options;
  callbacks = {
    ['dart/textDocument/publishClosingLabels'] = on_closing_labels;
    ['textDocument/codeAction'] = on_code_action;
  };
}
-- }}}

-- vim.lsp.set_log_level("debug")
