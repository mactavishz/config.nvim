return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Highlight the word under the cursor, for better 'iw' text object selection
    require('mini.cursorword').setup()

    -- Pair completion, like `(`, `{`, `[` and quotes etc.
    require('mini.pairs').setup()
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim

    -- Visualize and work with indent scope
    -- Checkout: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
    require('mini.indentscope').setup({
      symbol = '┊',
    })
  end,
}
