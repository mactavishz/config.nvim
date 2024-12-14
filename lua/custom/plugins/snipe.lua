return {
  'leath-dub/snipe.nvim',
  config = function()
    local snipe = require 'snipe'
    snipe.setup {
      ui = {
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        position = 'center',
      },
      navigate = {
        close_buffer = '<C-d>',
        open_vsplit = '<C-v>',
        open_split = '<C-x>',
      },
    }
    vim.keymap.set('n', '<leader><leader>', snipe.open_buffer_menu, { noremap = true, silent = true, desc = 'Open Snipe buffer menu' })
  end,
}
