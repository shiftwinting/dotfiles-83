local M = {}

local get_node_name = function(node)
  if node.kind == 'NEW_INSTANCE' then
    return node.className
  end

  return node.dartElement.name
end

local traverse_children
traverse_children = function(root, level, filter_fn)
  level = level or 0
  filter_fn = filter_fn or function() return true end

  for _, node in ipairs(root) do
    local pass_filter = filter_fn(node)

    -- For debugging
    -- if get_node_name(node) == 'build' then
    --   print(vim.inspect(node))
    -- end

    -- TODO: This is just for debugging
    if pass_filter then
      if level == 0 then print(get_node_name(node))
      else print(('-'):rep(level), get_node_name(node)) end
    end

    if node.children ~= nil and not vim.tbl_isempty(node.children) then
      if pass_filter then
        level = level + 1
      end
      traverse_children(node.children, level, filter_fn)
    end
  end
end

M.show_flutter_ui_guides = function(_, _, result)
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
  local filter_fn = function(node)
    return node.kind == 'NEW_INSTANCE'
  end

  traverse_children(children, 0, filter_fn)

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
