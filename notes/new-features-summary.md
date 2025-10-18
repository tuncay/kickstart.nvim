# New Features Summary

Summary of all changes applied: 2025-10-18

## 🎨 Visual Changes

### 1. Nerd Font Enabled
- **What changed**: Icons now display throughout Neovim
- **Terminal setup needed**: Configure your terminal to use "JetBrainsMono Nerd Font"
- **Where**: Already installed via pacman (`ttf-jetbrains-mono-nerd`)

### 2. Nightfox Theme (with Colorblind Support)
- **Active theme**: nightfox
- **Colorblind adjustments**: deutan=0.38, protan=0.63
- **Variants available**: nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
- **How to change**: Edit `lua/custom/plugins/nightfox.lua` line 23

---

## 🔧 New Tools & Features

### 3. Flash.nvim - Fast Navigation
**Quick jumps anywhere on screen**

**Keybindings:**
- `s` - Flash jump (type 2 chars → see labels → jump)
- `S` - Treesitter jump (jump to functions, classes, etc.)
- `r` (in operator mode) - Remote flash (e.g., `dr` = delete to remote location)
- Flash automatically enhances `f`, `F`, `t`, `T` motions

**Usage example:**
```
Press 's' → type 'fu' → see labels on all 'fu' matches → type label → jump!
```

### 4. Trouble.nvim - Better Diagnostics
**Beautiful diagnostic viewer**

**Keybindings:**
- `<leader>xx` - Toggle workspace diagnostics (all project errors/warnings)
- `<leader>xX` - Toggle buffer diagnostics (current file only)
- `<leader>xs` - Toggle symbols (code outline)
- `<leader>xl` - Toggle LSP info (definitions, references)
- `<leader>xL` - Toggle location list
- `<leader>xq` - Toggle quickfix list
- `]x` - Next diagnostic in Trouble
- `[x` - Previous diagnostic in Trouble

**Inside Trouble window:**
- `Enter` - Jump to diagnostic
- `q` - Close Trouble
- `o` - Jump but keep Trouble open
- `?` - Show help

### 5. Persistence.nvim - Session Management
**Auto-save and restore your workspace**

**Keybindings:**
- `<leader>vr` - [r]estore session for current directory
- `<leader>vl` - [l]oad last session (regardless of directory)
- `<leader>vd` - [d]on't save current session (disable for this session)

**Automatic behavior:**
- Sessions auto-save on exit
- Auto-restore when you run `nvim` in a directory (not when opening specific file)
- Saves: buffers, splits, tabs, cursor positions, working directory

**Workflow:**
```bash
cd ~/works/my-project
nvim                    # Opens fresh
# Work on files, create splits...
:q                      # Session saved
# Later...
cd ~/works/my-project
nvim                    # Everything restored!
```

### 6. Treesitter Textobjects
**Operate on code structures semantically**

**Select Textobjects:**
- `af` / `if` - [a]round / [i]nside [f]unction
- `ac` / `ic` - [a]round / [i]nside [c]lass
- `aa` / `ia` - [a]round / [i]nside [a]rgument/parameter
- `ai` / `ii` - [a]round / [i]nside condit[i]onal (if/else)
- `al` / `il` - [a]round / [i]nside [l]oop
- `ab` / `ib` - [a]round / [i]nside [b]lock

**Jump Between Structures:**
- `]f` / `[f` - Next/previous function start
- `]F` / `[F` - Next/previous function end
- `]c` / `[c` - Next/previous class start
- `]C` / `[C` - Next/previous class end
- `]a` / `[a` - Next/previous argument
- `]i` / `[i` - Next/previous conditional
- `]l` / `[l` - Next/previous loop

**Swap Parameters:**
- `<leader>a` - Swap parameter with next
- `<leader>A` - Swap parameter with previous

**Peek Definitions:**
- `<leader>df` - Peek function definition
- `<leader>dF` - Peek class definition

**Repeatable Motions:**
- `;` - Repeat last motion forward
- `,` - Repeat last motion backward

**Usage examples:**
```
daf     - Delete entire function (from anywhere in function)
vac     - Visual select entire class
cif     - Change function body
yaa     - Yank argument/parameter
]f      - Jump to next function
```

### 7. Auto-CD Toggle
**Control automatic git root directory changing**

**Keybindings:**
- `:ToggleAutoCd` - Toggle auto-cd on/off (shows status)
- `:CdRoot` - Manually cd to git root
- `:CdParent` - Manually cd to current file's directory

**Status:**
- Default: **Enabled** (auto-cd on `BufEnter`)
- Check: `:lua print(vim.g.auto_cd_root)`
- Disable: `:lua vim.g.auto_cd_root = false`

---

## 🎨 Formatters Added

### Formatters Now Configured
Mason will auto-install these on next startup:

- **Lua**: stylua (already had)
- **Python**: ruff_format
- **Rust**: rustfmt
- **JavaScript/TypeScript**: prettierd, prettier
- **JSON/JSONC**: prettier
- **Markdown**: prettier
- **YAML**: prettier
- **CSS**: prettier
- **HTML**: prettier

**Usage:**
- `<leader>f` - Format current buffer
- Auto-formats on save (except C/C++)

**Verify installation:**
- `:Mason` - Check installed tools

---

## ⌨️ Completion Changes

### Super-Tab Preset Enabled
**More intuitive completion**

**Old way:**
- `<C-y>` - Accept completion

**New way (super-tab):**
- `<Tab>` - Accept completion OR jump to next snippet placeholder
- `<S-Tab>` - Previous item OR previous snippet placeholder
- `<C-space>` - Open menu
- `<C-n>` / `<C-p>` - Navigate items
- `<C-e>` - Close menu
- `<C-k>` - Toggle signature help

---

## 🔍 Telescope Improvements

### Comprehensive Ignore Patterns Added
Telescope now ignores:

**Version Control:**
- `.git/`, `.svn/`, `.hg/`

**Dependencies:**
- `node_modules/`, `vendor/`

**Python:**
- `__pycache__/`, `*.pyc`, `.venv/`, `venv/`, `.pytest_cache/`, `.mypy_cache/`

**Rust:**
- `target/`, `Cargo.lock`

**JavaScript/TypeScript:**
- `.next/`, `.nuxt/`, `.cache/`, `.turbo/`

**Build Outputs:**
- `build/`, `dist/`, `*.o`, `*.so`, `*.dll`, `*.exe`

**Minified Files:**
- `*.min.js`, `*.min.css`

**IDE:**
- `.vscode/`, `.idea/`, `.vs/`

**OS:**
- `.DS_Store`, `Thumbs.db`

**Result:** Faster searches, cleaner results!

---

## 📊 Diagnostic Changes

### Virtual Text Filter
**Less noise, more focus**

**What changed:**
- Only **ERROR** and **WARN** show as inline text
- **INFO** and **HINT** still visible in:
  - Gutter signs (left column)
  - Trouble window (`<leader>xx`)
  - Telescope diagnostics (`<leader>sd`)
  - Hover info (`K`)

**Result:** Cleaner editing, less visual clutter!

---

## 🔨 Minor Improvements

### 8. Aerial Toggle
- **Changed**: `<leader>o` now toggles (instead of only opening)
- **Usage**: Press once to open, again to close

### 9. Turkish Langmap
- **Verified**: Working correctly
- **Documented**: Comments added explaining each mapping

### 10. Gitsigns
- **Status**: Already perfectly configured!
- **Key hunks operations**: `<leader>hs`, `<leader>hr`, `<leader>hp`, etc.

---

## 📚 Quick Reference Card

### Essential New Keybindings

**Navigation:**
```
s           - Flash jump
S           - Flash treesitter
]f / [f     - Next/prev function
]c / [c     - Next/prev class
```

**Diagnostics:**
```
<leader>xx  - Trouble workspace
<leader>xX  - Trouble buffer
]x / [x     - Next/prev in Trouble
```

**Code Operations:**
```
daf         - Delete function
vac         - Select class
cif         - Change function body
<leader>a   - Swap parameter
```

**Sessions:**
```
<leader>vr  - Restore session
<leader>vl  - Load last session
<leader>vd  - Don't save session
```

**Utilities:**
```
<leader>f   - Format buffer
<leader>o   - Toggle outline
:ToggleAutoCd - Toggle auto-cd
```

**Completion:**
```
<Tab>       - Accept completion
<S-Tab>     - Previous item
<C-space>   - Open menu
```

---

## 🚀 Post-Installation Checklist

### Immediate Actions:
1. ✅ Restart Neovim: `:qa` then `nvim`
2. ⏳ Mason will auto-install formatters (wait for completion)
3. 🔤 Configure terminal font: "JetBrainsMono Nerd Font"
4. 🎨 Verify theme: Should see nightfox colors
5. 🔍 Test Flash: Press `s` and type 2 characters

### Testing New Features:
1. **Flash**: Open a file, press `s`, type 2 chars
2. **Trouble**: `<leader>xx` to see diagnostics
3. **Formatters**: Open a Python/Rust/JS file, press `<leader>f`
4. **Textobjects**: Try `vaf` in a function
5. **Sessions**: Work in a project, close nvim, reopen (should restore)
6. **Completion**: Type something, press `<Tab>` to accept

### Verify Installation:
```vim
:Mason              " Check formatters installed
:Lazy               " Check all plugins loaded
:checkhealth        " Verify everything is healthy
```

---

## 🎓 Learning Resources

### Master These First:
1. **Flash navigation** (`s`) - Will speed up your editing significantly
2. **Trouble diagnostics** (`<leader>xx`) - Better than Telescope for errors
3. **Textobjects** (`daf`, `vac`) - Game-changer for code editing
4. **Super-tab completion** (`<Tab>`) - More intuitive than `<C-y>`

### Advanced Features:
5. **Session management** - Great for project-based workflow
6. **Parameter swapping** (`<leader>a`) - Clean up function signatures
7. **Treesitter jumping** (`]f`, `[c`) - Navigate code structure
8. **Peek definitions** (`<leader>df`) - Quick reference without jumping

### Pro Tips:
- Combine operators with textobjects: `daf`, `cif`, `yac`
- Use Flash in visual mode: `v` then `s` to select to location
- Trouble can replace quickfix: use `<leader>xq` for better view
- Sessions auto-restore only with `nvim`, not `nvim file.txt`
- Toggle auto-cd off when working across multiple repos

---

## 📝 Configuration Files Changed

### New Files Created:
- `lua/custom/plugins/flash.lua` - Flash navigation
- `lua/custom/plugins/trouble.lua` - Diagnostic viewer
- `lua/custom/plugins/persistence.lua` - Session management
- `lua/custom/plugins/treesitter-textobjects.lua` - Semantic code operations

### Modified Files:
- `init.lua` - Theme, formatters, completion preset, diagnostics, telescope ignores
- `lua/custom/plugins/changedir.lua` - Added toggle
- `lua/custom/plugins/keymaps.lua` - Documented langmap, freed up `s` for Flash
- `lua/custom/plugins/aerial.lua` - Changed to Toggle

---

## 🐛 Troubleshooting

### If icons don't show:
1. Check terminal font is set to "JetBrainsMono Nerd Font"
2. Restart terminal
3. Check: `:lua print(vim.g.have_nerd_font)` should return `true`

### If formatters don't work:
1. Open `:Mason` and verify they're installed
2. Wait for installation to complete
3. Try formatting: `<leader>f`

### If Flash doesn't work:
1. Verify `s` key is freed up (commented in keymaps.lua)
2. Restart Neovim
3. Try in a large file with many words

### If sessions don't restore:
1. Make sure you're in a directory, run `nvim` (not `nvim file.txt`)
2. Check auto-cd is on: `:lua print(vim.g.auto_cd_root)`
3. Sessions stored in: `~/.local/state/nvim/sessions/`

---

## 🎉 Enjoy Your Enhanced Neovim!

You now have:
- ⚡ Faster navigation (Flash)
- 📊 Better diagnostics (Trouble)
- 🔄 Session persistence
- 🎯 Semantic code operations (Textobjects)
- 🎨 Professional formatting for all languages
- ✨ Cleaner UI with Nerd Fonts
- 🔧 More intuitive completion (super-tab)

Happy coding! 🚀
