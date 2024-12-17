return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require 'toggleterm'
    toggleterm.setup {
      open_mapping = [[<c-\>]],
    }
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
    }

    function G_set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd 'autocmd! TermOpen term://*toggleterm#* lua G_set_terminal_keymaps()'

    function G_lazygit_toggle()
      lazygit:toggle()
    end
    vim.keymap.set('n', '<leader>lg', G_lazygit_toggle, { noremap = true, silent = true, desc = 'Toggle Lazygit Terminal' })
  end,
}
