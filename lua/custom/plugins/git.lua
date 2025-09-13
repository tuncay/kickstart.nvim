local tele = require 'telescope.builtin'

-- vimdiff
-- vim.keymap.set('n', 'gh', '<cmd>diffget //2<cr>', { desc = 'get left diff' })
-- vim.keymap.set('n', 'gl', '<cmd>diffget //3<cr>', { desc = 'get right diff' })

vim.keymap.set('n', '<leader>gb', tele.git_branches, { desc = '[g]it [b]ranches' })
vim.keymap.set('n', '<leader>glb', tele.git_bcommits, { desc = '[g]it [l]og [b]uffer' })
vim.keymap.set('n', '<leader>gl.', tele.git_commits, { desc = '[g]it [l]og' })
--- Lists commits for a range of lines in the current buffer with diff preview
-- vim.keymap.set('v', '<leader>gl', tele.git_bcommits_range, { desc = '[g]it [l]og' })
-- stylua: ignore
vim.keymap.set('n', '<leader>gf', function() tele.git_files { use_file_path = true } end, { desc = '[g]it [f]iles' })
vim.keymap.set('n', '<leader>gg', tele.git_status, { desc = '[g]o [g]it' })
vim.keymap.set('n', '<leader>gz', tele.git_stash, { desc = '[g]it zstash' })

--
return {
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gs', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'rhysd/git-messenger.vim',
    cmd = { 'GitMessenger' },
    keys = { { '<leader>gm', ':GitMessenger<CR>', desc = '[g]it [m]essenger' } },
  },
}
