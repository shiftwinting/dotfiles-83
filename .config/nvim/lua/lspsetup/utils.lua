local M = {}

M.reset_config = function()
  require('plenary.reload').reload_module('lspsetup')
  require('lspsetup')
  vim.cmd('e')
end

return M
