local function zen_mode()
  require('zen-mode').setup { window = { width = 100, options = {} } }
  require('zen-mode').toggle()
  vim.wo.wrap = true
  vim.wo.number = true
  vim.wo.rnu = true
end

return {
  'folke/zen-mode.nvim',
  keys = {
    { '<leader>vz', zen_mode, desc = '[z]enmode' },
  },
}
