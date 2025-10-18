-- Trouble: Beautiful diagnostic viewer
-- A better way to view and navigate diagnostics, quickfix, and location lists

return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {
    focus = true, -- Focus the trouble window when opened
    modes = {
      -- Customize how different modes are displayed
      diagnostics = {
        auto_close = false, -- Don't auto-close when there are no items
      },
    },
  },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '[x',
      function()
        require('trouble').prev { skip_groups = true, jump = true }
      end,
      desc = 'Previous Trouble item',
    },
    {
      ']x',
      function()
        require('trouble').next { skip_groups = true, jump = true }
      end,
      desc = 'Next Trouble item',
    },
  },
}
