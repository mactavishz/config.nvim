return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      config = function()
        local builtin = require 'statuscol.builtin'
        -- NOTE: https://github.com/neovim/neovim/pull/17446#issuecomment-1407651883
        require('statuscol').setup {
          relculright = true,
          segments = {
            { text = { '%s' }, click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
            {
              text = { ' ', builtin.foldfunc, ' ' },
              condition = { builtin.not_empty, true, builtin.not_empty },
              click = 'v:lua.ScFa',
            },
          },
        }
      end,
    },
  },
  config = function()
    local ufo = require 'ufo'
    ufo.setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'lsp', 'indent' }
      end,
    }
    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
    vim.keymap.set('n', 'zK', function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek Fold' })
  end,
}
