local M = {}

M.init_options = {
  onlyAnalyzeProjectsWithOpenFiles = false,
  suggestFromUnimportedLibraries = true,
  closingLabels = true,
  outline = true,
  flutterOutline = true
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

M.on_closing_labels = require'lspsetup.dartls.closing_labels'.on_closing_labels
M.show_flutter_ui_guides = require'lspsetup.dartls.flutter_guides'.show_flutter_ui_guides

return M
