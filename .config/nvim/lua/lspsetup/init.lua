local lsp = require'lspconfig'
local handlers = require'lspsetup.handlers'
local dartls = require'lspsetup.dartls'

-- Init
lsp.tsserver.setup{}
lsp.gopls.setup{}
lsp.vuels.setup{}
lsp.vimls.setup{}
lsp.cssls.setup{}
lsp.rust_analyzer.setup{}
lsp.jedi_language_server.setup{}
lsp.bashls.setup{}

-- Custom handlers
vim.lsp.handlers['textDocument/codeAction'] = handlers.code_action_callback

-- Lua {{{
lsp.sumneko_lua.setup{
  cmd={vim.fn.expand('$HOME')..'/builds/lua-language-server/bin/macOS/lua-language-server'},
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
}
-- }}}

-- Dart + Flutter {{{
lsp.dartls.setup{
  init_options = dartls.init_options,
  capabilities = dartls.capabilities,
  handlers = {
    ['dart/textDocument/publishClosingLabels'] = dartls.on_closing_labels,
    -- ['dart/textDocument/publishOutline'] = dartls.on_outline,
    ['dart/textDocument/publishFlutterOutline'] = dartls.show_flutter_ui_guides,
  };
}
-- }}}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { "bash" }
  },
}

-- Completion
require'compe'.setup {
  enabled = true;
  debug = false;
  min_length = 2;
  preselect = 'enable';
  -- throttle_time = ... number ...;
  -- source_timeout = ... number ...;
  -- incomplete_delay = ... number ...;
  allow_prefix_unmatch = false;

  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}

-- Telescope
require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
  }
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

-- Treesitter objects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ib"] = "@call.inner",
        ["ab"] = "@call.outer",
      },
    },
  },
}
