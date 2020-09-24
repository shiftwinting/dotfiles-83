local lsp = require'nvim_lsp'
local dart_config = require'dartls'

local M = {}

lsp.tsserver.setup{on_attach=require'diagnostic'.on_attach}
lsp.gopls.setup{on_attach=require'diagnostic'.on_attach}
lsp.vuels.setup{on_attach=require'diagnostic'.on_attach}
lsp.vimls.setup{}
-- lsp.cssls.setup{}
lsp.rust_analyzer.setup{}

-- Custom callbacks
vim.lsp.callbacks['textDocument/codeAction'] = function(_, _, result)
  if vim.tbl_isempty(result) then
    print('[code_actions] No code actions available')
    return
  end

  local items_by_name = {}
  for _, item in ipairs(result) do
    items_by_name[item.title] = item
  end

  local opts = vim.fn['fzf#wrap']({
    source = vim.tbl_keys(items_by_name),
    sink = function() end
  })

  opts.sink = function(item)
    local selected = items_by_name[item]
    if selected.command ~= nil then
      vim.lsp.buf.execute_command(selected.command)
    elseif selected.edit ~= nil then
      vim.lsp.util.apply_workspace_edit(selected.edit)
    end
  end

  vim.fn['fzf#run'](opts)
end

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

M.reset_config = function()
  require('plenary.reload').reload_module('lspserver')
  require('lspserver')
  vim.cmd('e')
end

return M
