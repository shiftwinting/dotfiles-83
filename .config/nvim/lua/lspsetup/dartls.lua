local M = {}

M.init_options = {
  onlyAnalyzeProjectsWithOpenFiles = false,
  suggestFromUnimportedLibraries = true,
  closingLabels = true,
  outline = true,
  flutterOutline = false
};

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        '',
        'quickfix',
        'refactor',
        'refactor.extract',
        'refactor.inline',
        'refactor.rewrite',
        'source',
        'source.organizeImports',
      }
    }
  }
}


local closing_labels_ns = vim.api.nvim_create_namespace('dart.closing_labels')

M.on_closing_labels = function(_, _, result)
  local prefix = '// '
  local highlight = 'Comment'

  vim.api.nvim_buf_clear_namespace(0, closing_labels_ns, 0, -1)

  for _,l in ipairs(result.labels) do
    local name =  l.label
    local line = l.range['end'].line
    vim.api.nvim_buf_set_virtual_text(0, closing_labels_ns, line, { { prefix .. name, highlight } }, {})
  end
end

return M
