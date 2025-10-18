local Job = require 'plenary.job'

-- Toggle auto-cd behavior with: :ToggleAutoCd or :lua vim.g.auto_cd_root = false
vim.g.auto_cd_root = true

local function cdroot_of(opts)
  ---@diagnostic disable-next-line: missing-fields
  Job:new({
    command = 'git',
    args = { 'rev-parse', '--show-toplevel' },
    cwd = opts.cwd,
    on_exit = function(j, _)
      local path = j:result()[1]
      vim.schedule(function()
        if path == nil then
          return
        end
        print('cwd: ' .. path)
        vim.api.nvim_set_current_dir(path)
      end)
    end,
  }):start()
end

vim.api.nvim_create_user_command('CdParent', function()
  local path = vim.fn.expand '%:p:h'
  vim.api.nvim_set_current_dir(path)
  -- vim.fn.chdir() maybe?
end, { desc = 'changes directory to files parent dir' })

vim.api.nvim_create_user_command('CdRoot', function()
  cdroot_of { cwd = vim.fn.expand '%:p:h' }
end, { desc = "changes dir to git's root (toplevel)" })

vim.api.nvim_create_user_command('ToggleAutoCd', function()
  vim.g.auto_cd_root = not vim.g.auto_cd_root
  local status = vim.g.auto_cd_root and 'enabled' or 'disabled'
  print('Auto-cd to git root: ' .. status)
end, { desc = 'toggle auto-cd to git root on buffer enter' })

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('my-cd', { clear = true }),
  pattern = '*',
  callback = function()
    -- Only run for normal buffers, (no terminal, quickfix ...)
    -- Check if auto-cd is enabled
    if vim.g.auto_cd_root and vim.bo.buftype == '' then
      cdroot_of { cwd = vim.fn.expand '%:p:h' }
    end
  end,
})

return {}
