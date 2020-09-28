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

-- First, let's experiment with syntax () and highlight (hi)
-- Try to use https://github.com/Yggdroot/indentLine as example for the lines
M.on_outline = function(...)
  print('calling outline')
  -- print(vim.inspect({...}))
end

local get_node_name = function(node)
  if node.kind == 'NEW_INSTANCE' then
    return node.className
  end

  return node.dartElement.name
end

local traverse_children
traverse_children = function(root)
  for _, node in ipairs(root) do
    print('name: ', get_node_name(node))
    if node.children ~= nil and not vim.tbl_isempty(node.children) then
      traverse_children(node.children)
    end
  end
end

M.on_flutter_outline = function(_, _, result)
  -- For debug
  vim.cmd [[hi Green guibg=#33ff33]]
  -- Add to line -> syn region Green start=/\%12/ end=/\%12+1/
  -- Clear -> hi clear <group>
  -- TODO: Check how these symbols are applied in https://github.com/Yggdroot/indentLine
  -- check syntax sync
  -- Check about syntax groups
  -- Clear a syntax group -> :syntax clear {group-name} ..

  print('calling flutter outline')
  local outline = result.outline
  local children = outline.children

  traverse_children(children)

  -- Look for kind == 'NEW_INSTANCE' and highlight line

  -- dartElement
  -- dartElement.kind
  -- dartElement.range
  -- dartElement.start.line
  -- dartElement.end.line
  -- children

  -- for _, widget in ipairs(children) do
  --   print(vim.inspect(widget))
  -- end
end

return M
