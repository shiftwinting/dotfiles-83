local M = {}

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
