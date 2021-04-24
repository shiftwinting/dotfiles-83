-- Telescope
require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
  },
  extensions = {
    fzf = {
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
  -- defaults = {
  --   vimgrep_arguments = {
  --     'rg',
  --     '--color=never',
  --     '--no-heading',
  --     '--with-filename',
  --     '--line-number',
  --     '--column',
  --     '--smart-case'
  --   },
  --   prompt_position = "bottom",
  --   prompt_prefix = ">",
  --   initial_mode = "insert",
  --   selection_strategy = "reset",
  --   sorting_strategy = "descending",
  --   layout_strategy = "horizontal",
  --   layout_defaults = {
  --     -- TODO add builtin options.
  --   },
  --   file_sorter =  require'telescope.sorters'.get_fuzzy_file,
  --   file_ignore_patterns = {},
  --   generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
  --   shorten_path = true,
  --   winblend = 0,
  --   width = 0.75,
  --   preview_cutoff = 120,
  --   results_height = 1,
  --   results_width = 0.8,
  --   border = {},
  --   borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
  --   color_devicons = true,
  --   use_less = true,
  --   set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
  --   file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
  --   grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
  --   qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

  --   -- Developer configurations: Not meant for general override
  --   buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  -- }
}

-- require('telescope').load_extension('fzy_native')
require('telescope').load_extension('ultisnips')
require('telescope').load_extension('fzf')

local M = {}

M.buffer_lines = function()
  require('telescope.builtin').current_buffer_fuzzy_find({
    prompt_title = "< buffer lines >",
    attach_mappings = function(prompt_bufnr, map)

      -- Paste line
      map('i', '<C-f>', function(bufnr)
        local content = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        vim.fn.append(vim.fn.line('.'), content.display)
        vim.fn.execute('norm j')
      end)

      return true
    end
  })
end

return M
