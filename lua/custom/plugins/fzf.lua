return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function(_, opts)
    local FzfLua = require 'fzf-lua'
    local map = vim.keymap.set
    -- Smartly opens either git_files or find_files, depending on whether the working directory is
    -- contained in a Git repo.
    function find_project_files()
      local ok = pcall(FzfLua.git_files)

      if not ok then
        FzfLua.find_files { resume = true }
      end
    end
    FzfLua.setup(opts)
    map('n', '<leader>fh', FzfLua.helptags, { desc = '[F]ind [H]elp' })
    map('n', '<leader>fk', FzfLua.keymaps, { desc = '[F]ind [K]eymaps' })
    map('n', '<leader>ff', find_project_files, { desc = '[F]ind [F]iles' })
    map('n', '<leader>fw', FzfLua.grep_cword, { desc = '[F]ind current [W]ord' })
    map('n', '<leader>fg', FzfLua.live_grep, { desc = '[F]ind by [G]rep' })
    map('n', '<leader>fd', FzfLua.diagnostics_document, { desc = '[F]ind [D]iagnostics' })
    map('n', '<leader>fr', FzfLua.resume, { desc = '[F]ind [R]esume' })
    map('n', '<leader>f.', FzfLua.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    map('n', '<space><space>', FzfLua.buffers, { desc = '[F]ind existing buffers' })
    -- -- Slightly advanced example of overriding default behavior and theme
    map('n', '<leader>/', FzfLua.blines, { desc = '[/] Fuzzily search in current buffer' })
  end,
}
