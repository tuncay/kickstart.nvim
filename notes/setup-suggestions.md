# Neovim Setup Suggestions

Analysis performed: 2025-10-18

## High Priority Issues

### 1. **Theme Conflict**
You have both `nightfox` and `tokyonight` configured. Nightfox loads with `lazy=false, priority=1000` and sets colorblind adjustments (which is great!), but then init.lua:982 overrides it with `tokyonight-night`.

**Suggestion**: Choose one theme. If you need the colorblind adjustments, keep nightfox and remove/comment the tokyonight setup. If you prefer tokyonight, remove nightfox.lua or add colorblind settings to tokyonight if available.

### 2. **Nerd Font Setting**
You have `vim.g.have_nerd_font = false` (init.lua:94) but several plugins expect icons:
- nvim-web-devicons (disabled when false)
- aerial.nvim depends on devicons
- mini.statusline would look better with icons

**Suggestion**: If you have a Nerd Font installed (which your brew install command doesn't include), set this to `true`. Otherwise, install one: `brew install --cask font-jetbrains-mono-nerd-font`

### 3. **Missing Formatters**
You have LSPs for Python, Rust, TypeScript, C# but conform.nvim only configures stylua.

**Suggestion**: Add formatters in init.lua around line 854:
```lua
formatters_by_ft = {
  lua = { 'stylua' },
  python = { 'ruff_format' }, -- or { 'isort', 'black' }
  rust = { 'rustfmt' },
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
  typescript = { 'prettierd', 'prettier', stop_after_first = true },
  javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  json = { 'prettier' },
  markdown = { 'prettier' },
},
```

And add them to mason ensure_installed (init.lua:802):
```lua
vim.list_extend(ensure_installed, {
  'stylua',
  'prettier',
  'rustfmt',
  'ruff',  -- or black, isort
})
```

## Medium Priority Improvements

### 4. **Auto-CD Behavior is Very Aggressive**
Your changedir.lua automatically changes to git root on every `BufEnter`. This could be surprising when:
- Opening files from different repositories in the same session
- Working with non-git files
- Intentionally working in a subdirectory

**Suggestion**: Consider making this opt-in per session or add a toggle:
```lua
vim.g.auto_cd_root = true  -- can toggle with :lua vim.g.auto_cd_root = false

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.g.auto_cd_root and vim.bo.buftype == '' then
      cdroot_of { cwd = vim.fn.expand '%:p:h' }
    end
  end,
})
```

### 5. **Turkish Langmap Escaping**
In keymaps.lua:1, the backslashes look odd: `ö\\,,ç\\;`

**Suggestion**: Verify this is working correctly. It might need to be `ö,,ç;` or proper escaping.

### 6. **Git Keymaps Semantics**
`<leader>gg` opens git_status, but `gg` in Vim traditionally means "go to top". This might cause muscle memory conflicts.

**Suggestion**: Consider `<leader>gs` for git status (oh wait, that's lazygit). Maybe use `<leader>gt` for git status, or reconsider the mnemonic.

### 7. **Gitsigns Keymaps**
You load gitsigns but don't have keymaps for staging hunks, resetting hunks, etc. (The kickstart/plugins/gitsigns.lua should provide these, but verify they're there.)

**Suggestion**: Ensure you have hunk operations mapped. Common ones:
- Stage hunk: `<leader>hs`
- Reset hunk: `<leader>hr`
- Preview hunk: `<leader>hp`
- Blame line: `<leader>hb`

## Optional Enhancements

### 8. **Add Useful Navigation Plugins**
Your setup is great for code but could use enhanced motion:

```lua
-- In lua/custom/plugins/:
{
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
  },
}
```
(You already disabled `s`, so this would replace it with something powerful!)

### 9. **Better Diagnostic UI**
```lua
{
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
    { '<leader>xq', '<cmd>Trouble quickfix toggle<cr>', desc = 'Quickfix (Trouble)' },
  },
}
```

### 10. **Session Management**
With your project picker, auto-saving sessions would be great:

```lua
{
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>vr', function() require('persistence').load() end, desc = '[r]estore session' },
    { '<leader>vl', function() require('persistence').load({ last = true }) end, desc = '[l]ast session' },
  },
}
```

### 11. **Treesitter Textobjects**
You mention these in comments but don't use them. They're incredibly powerful:

```lua
-- Add to nvim-treesitter config:
{
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
        },
      },
    }
  end,
}
```

### 12. **Telescope Ignore Patterns**
Your telescope config only ignores `.git/`, `node_modules`, `.cache/`. Consider adding:

```lua
file_ignore_patterns = {
  '%.git/',
  'node_modules',
  '%.cache/',
  '%.venv/',
  '__pycache__/',
  'target/',  -- Rust
  'dist/',
  'build/',
  '%.min%.js',
}
```

### 13. **Completion Preset**
You're using the 'default' preset (Ctrl-Y to accept). Many find 'super-tab' more intuitive:

```lua
keymap = { preset = 'super-tab' },  -- Tab to accept
```

### 14. **Diagnostic Virtual Text Verbosity**
Your diagnostics show all severities in virtual text. This can be noisy. Consider:

```lua
virtual_text = {
  source = 'if_many',
  spacing = 2,
  severity = { min = vim.diagnostic.severity.WARN },  -- Only show WARN and ERROR
}
```

## Minor Notes

15. **vim-abolish** - Great plugin but ensure you're using it! It's powerful for abbreviations and case coercion (`:help abolish`)

16. **Zen Mode** - Nice addition! Consider adding twilight.nvim for even better focus mode

17. **Aerial** - You have it bound to `<leader>o`. Consider `AerialToggle` instead of `AerialOpen` for easier closing

18. **Rust Analyzer Config** - Your config is comprehensive but some settings might be outdated. The current rust-analyzer is pretty good with defaults.

## Implementation Priority

If you want to tackle these, I'd suggest this order:

1. Fix the theme conflict (choose one!)
2. Install Nerd Font and set have_nerd_font = true
3. Add formatters for your languages
4. Review the auto-cd behavior (consider adding a toggle)
5. Add flash.nvim for better navigation (since you disabled 's')
6. Add trouble.nvim for better diagnostic viewing
7. Verify gitsigns keymaps are working
8. Consider session management with persistence.nvim
9. Everything else as needed

## Summary

Overall, you have an excellent, well-organized setup! The main issues are:
- Theme conflict needs resolution
- Missing some tooling for the languages you work with
- A few quality-of-life improvements that would make daily use smoother

Your custom features (project picker, Turkish keyboard support, auto-cd) show you've thought carefully about your workflow. The suggestions above are mostly about completing the setup for the languages you're already configured for.
