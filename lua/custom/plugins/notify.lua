return {
  {
    'rcarriga/nvim-notify',
    cond = vim.g.vscode == nil,
    config = function()
      vim.notify = require 'notify'
    end,
  },
}
