local M = {}
local utils = require'lspsetup.utils'

M.code_action_callback = function(_, _, result)
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
    utils.execute_action(items_by_name[item])
  end

  vim.fn['fzf#run'](opts)
end

return M
