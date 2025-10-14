vim.opt.langmap = 'ıi,ğ[,ü],Ğ{,Ü}'
vim.keymap.set('i', 'jk', '<Esc>')
-- vim.keymap.set('n', 'ı', 'i')

vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Nop>')
vim.keymap.set({ 'n', 'x', 'o' }, '<c-z>', '<Nop>')

-- Keep things vertically centered during searches
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '*', '*zzzv')

vim.keymap.set('n', '#', '#zzzv')
vim.keymap.set('n', 'g*', 'g*zzzv')
vim.keymap.set('n', 'g#', 'g#zzzv')

-- -- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

return {}
