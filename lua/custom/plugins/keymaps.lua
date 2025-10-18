-- Map Turkish Q keyboard characters to English equivalents for Vim commands
-- This allows using Turkish layout while using Vim motions
-- ı→i (insert), ğ→[ (previous section), ü→] (next section),
-- Ğ→{ (previous paragraph), Ü→} (next paragraph),
-- ö→, (reverse f/t), ç→; (repeat f/t)
vim.opt.langmap = 'ıi,ğ[,ü],Ğ{,Ü},ö\\,,ç\\;'

-- Verify langmap is loaded correctly (uncomment to test):
-- vim.defer_fn(function()
--   print('langmap value: ' .. vim.o.langmap)
-- end, 100)
vim.keymap.set('i', 'jk', '<Esc>')
-- vim.keymap.set('n', 'ı', 'i')

-- Note: 's' is now used by flash.nvim for fast navigation
-- vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Nop>')
vim.keymap.set({ 'n', 'x', 'o' }, '<c-z>', '<Nop>')

-- Keep things vertically centered during searches
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '*', '*zzzv')
vim.keymap.set('n', '<c-n>', ':cnext<cr>')
vim.keymap.set('n', '<c-p>', ':cprevious<cr>')

vim.keymap.set('n', '#', '#zzzv')
vim.keymap.set('n', 'g*', 'g*zzzv')
vim.keymap.set('n', 'g#', 'g#zzzv')

-- -- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

return {}
