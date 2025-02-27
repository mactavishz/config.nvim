return {
    'folke/trouble.nvim',
    cond = vim.g.vscode == nil,
    lazy = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = 'Trouble',
    opts = {},
    keys = {
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle focus=true<cr>',
            desc = 'Diagnostics (Trouble)',
        },
    },
}
