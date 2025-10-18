-- Persistence: Session management
-- Automatically saves and restores your Neovim session per directory
-- Perfect for maintaining workspace state across multiple projects

return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- Load before reading files
  opts = {
    -- Directory where session files are saved
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    -- Options for saving the session
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' },
    -- Don't save session if no files are open
    pre_save = function()
      -- Close any floating windows before saving
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= '' then
          vim.api.nvim_win_close(win, false)
        end
      end
    end,
  },
  keys = {
    {
      '<leader>vr',
      function()
        require('persistence').load()
      end,
      desc = '[r]estore session for cwd',
    },
    {
      '<leader>vl',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[l]oad last session',
    },
    {
      '<leader>vd',
      function()
        require('persistence').stop()
      end,
      desc = "[d]on't save current session",
    },
  },
}
