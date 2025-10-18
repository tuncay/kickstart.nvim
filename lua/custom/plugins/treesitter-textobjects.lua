-- Treesitter Textobjects: Operate on code structures semantically
-- Select, move, and manipulate functions, classes, parameters, etc.

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = 'Select around function' },
            ['if'] = { query = '@function.inner', desc = 'Select inside function' },
            ['ac'] = { query = '@class.outer', desc = 'Select around class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inside class' },
            ['aa'] = { query = '@parameter.outer', desc = 'Select around argument/parameter' },
            ['ia'] = { query = '@parameter.inner', desc = 'Select inside argument/parameter' },
            ['ai'] = { query = '@conditional.outer', desc = 'Select around conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'Select inside conditional' },
            ['al'] = { query = '@loop.outer', desc = 'Select around loop' },
            ['il'] = { query = '@loop.inner', desc = 'Select inside loop' },
            ['ab'] = { query = '@block.outer', desc = 'Select around block' },
            ['ib'] = { query = '@block.inner', desc = 'Select inside block' },
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = 'V', -- linewise
          },
          -- Include surrounding whitespace
          include_surrounding_whitespace = false,
        },

        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap parameter with next' },
          },
          swap_previous = {
            ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap parameter with previous' },
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next function start' },
            [']c'] = { query = '@class.outer', desc = 'Next class start' },
            [']a'] = { query = '@parameter.inner', desc = 'Next parameter' },
            [']i'] = { query = '@conditional.outer', desc = 'Next conditional' },
            [']l'] = { query = '@loop.outer', desc = 'Next loop' },
          },
          goto_next_end = {
            [']F'] = { query = '@function.outer', desc = 'Next function end' },
            [']C'] = { query = '@class.outer', desc = 'Next class end' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
            ['[c'] = { query = '@class.outer', desc = 'Previous class start' },
            ['[a'] = { query = '@parameter.inner', desc = 'Previous parameter' },
            ['[i'] = { query = '@conditional.outer', desc = 'Previous conditional' },
            ['[l'] = { query = '@loop.outer', desc = 'Previous loop' },
          },
          goto_previous_end = {
            ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
            ['[C'] = { query = '@class.outer', desc = 'Previous class end' },
          },
        },

        lsp_interop = {
          enable = true,
          border = 'rounded',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>df'] = { query = '@function.outer', desc = 'Peek function definition' },
            ['<leader>dF'] = { query = '@class.outer', desc = 'Peek class definition' },
          },
        },
      },
    }

    -- Repeat movement with ; and ,
    -- Make sure ; and , work with treesitter motions
    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
    -- vim way: ; goes to the direction you were moving, , goes the opposite
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    -- Make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
