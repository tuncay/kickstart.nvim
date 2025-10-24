local Job = require 'plenary.job'

-- Persist toggle state across sessions
local state_file = vim.fn.stdpath 'data' .. '/auto_cd_root_state'

local function load_state()
  local ok, content = pcall(vim.fn.readfile, state_file)
  if ok and #content > 0 then
    return content[1] == 'true'
  end
  return true -- Default to enabled if no state file exists
end

local function save_state(enabled)
  vim.fn.writefile({ enabled and 'true' or 'false' }, state_file)
end

-- Toggle auto-cd behavior with: :ToggleAutoCd or :lua vim.g.auto_cd_root = false
vim.g.auto_cd_root = load_state()

-- Store the directory to lock to
vim.g.lock_to_initial_cwd = false
vim.g.locked_cwd = nil

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
  save_state(vim.g.auto_cd_root)
  local status = vim.g.auto_cd_root and 'enabled' or 'disabled'
  print('Auto-cd to git root: ' .. status)
end, { desc = 'toggle auto-cd to git root on buffer enter' })

vim.api.nvim_create_user_command('LockCwd', function(opts)
  vim.g.lock_to_initial_cwd = not vim.g.lock_to_initial_cwd
  if vim.g.lock_to_initial_cwd then
    -- Lock to current cwd or provided directory
    local lock_dir = opts.args ~= '' and vim.fn.expand(opts.args) or vim.fn.getcwd()
    vim.g.locked_cwd = lock_dir
    vim.api.nvim_set_current_dir(lock_dir)
    print('Locked to directory: ' .. lock_dir)
  else
    vim.g.locked_cwd = nil
    print('Unlocked cwd')
  end
end, { nargs = '?', complete = 'dir', desc = 'lock cwd to current or specified directory' })

vim.api.nvim_create_user_command('LockHere', function()
  local dir = vim.fn.expand '%:p:h'
  vim.g.lock_to_initial_cwd = true
  vim.g.locked_cwd = dir
  vim.api.nvim_set_current_dir(dir)
  print('Locked to directory: ' .. dir)
end, { desc = "lock cwd to current file's directory" })

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('my-cd', { clear = true }),
  pattern = '*',
  callback = function()
    -- If cwd is locked, restore it and skip auto-cd
    if vim.g.lock_to_initial_cwd and vim.g.locked_cwd then
      local current = vim.fn.getcwd()
      if current ~= vim.g.locked_cwd then
        vim.api.nvim_set_current_dir(vim.g.locked_cwd)
      end
      return
    end

    -- Only run for normal buffers, (no terminal, quickfix ...)
    -- Check if auto-cd is enabled
    if vim.g.auto_cd_root and vim.bo.buftype == '' then
      cdroot_of { cwd = vim.fn.expand '%:p:h' }
    end
  end,
})

return {}
