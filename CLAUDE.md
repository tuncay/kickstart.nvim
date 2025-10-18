# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on kickstart.nvim, customized with additional plugins and Turkish keyboard layout support. The configuration uses Lua and the lazy.nvim plugin manager.

## Architecture

### Core Structure

- `init.lua` - Main configuration file (single-file approach from kickstart.nvim)
  - Contains vim options, keymaps, autocommands, and plugin setup
  - Uses lazy.nvim for plugin management
  - Imports custom plugins from `lua/custom/plugins/`

- `lua/custom/` - Custom configurations and plugins
  - `plugins/*.lua` - Individual plugin configurations (auto-imported via lazy.nvim)
  - `repo-select.lua` - Custom Telescope picker for project switching
  - `mini-files.lua` - File explorer configuration using mini.files

- `lua/kickstart/` - Kickstart.nvim optional plugins (mostly disabled)

### Key Custom Features

#### Project Management (`lua/custom/repo-select.lua`)
Custom Telescope picker that scans configured directories (`~/works/`, `~/works/dummy/`, `~/notes/`) for projects. Supports worktree directories (searches nested subdirectories when a directory name contains 'worktree').

- Accessed via `<leader>sp` keymap
- Projects are discovered dynamically from configured directories
- Automatically handles git worktrees

#### Auto CD to Git Root (`lua/custom/plugins/changedir.lua`)
Automatically changes the working directory to the git repository root when entering a buffer. This is a critical behavior affecting all file operations.

- `:CdRoot` - Manually change to git root
- `:CdParent` - Change to parent directory of current file
- Auto-runs on `BufEnter` for normal buffers

#### Turkish Keyboard Support (`lua/custom/plugins/keymaps.lua`)
Configures `langmap` for Turkish Q keyboard layout, mapping Turkish characters to their English equivalents for Vim commands. Custom keymaps include:
- `jk` in insert mode → Escape
- Centered scrolling with `<C-d>`, `<C-u>`, `n`, `N`, `*`
- Move visual lines with `J` and `K`
- Disabled `s` and `<C-z>` in normal/visual/operator modes

#### File Browser (`lua/custom/mini-files.lua`)
Uses mini.files for file navigation with custom keymaps:
- `-` - Open explorer at current file location
- `_` - Open explorer at cwd
- `<C-s>`, `<C-v>`, `<C-t>` - Split horizontally/vertically/tab
- `g~` - Set cwd to focused directory
- `gx` - Open with system default
- `gy` - Yank full path

## Plugin Management

Uses lazy.nvim for plugin management:
- `:Lazy` - View plugin status
- `:Lazy update` - Update plugins
- `:Lazy sync` - Install/update/clean plugins

Plugin installation is automatic on first launch. The configuration auto-installs LSP servers via Mason.

## LSP Configuration

Configured language servers:
- **Lua** - lua_ls with lazydev.nvim for Neovim API support
- **Python** - pyright and ruff
- **Rust** - rust_analyzer (extensive inlay hints configuration)
- **TypeScript** - typescript-tools.nvim (separate from main LSP setup)
- **C#** - omnisharp

LSP keymaps (available when LSP attaches):
- `grn` - Rename symbol
- `gra` - Code action
- `grr` - Find references (Telescope)
- `gri` - Go to implementation (Telescope)
- `grd` - Go to definition (Telescope)
- `grD` - Go to declaration
- `grt` - Go to type definition (Telescope)
- `gO` - Document symbols (Telescope)
- `gW` - Workspace symbols (Telescope)
- `<leader>th` - Toggle inlay hints

Mason tools:
- `:Mason` - Open Mason UI
- Auto-installs LSP servers defined in `servers` table and stylua

## Completion

Uses blink.cmp with LuaSnip for snippets. Preset is 'default':
- `<C-y>` - Accept completion
- `<C-space>` - Open menu or docs
- `<C-n>`/`<C-p>` or arrow keys - Select items
- `<Tab>`/`<S-Tab>` - Navigate snippet placeholders

## Key Telescope Commands

- `<leader>sf` - Search files (fd with hidden files, excludes .git)
- `<leader>sg` - Live grep (ripgrep with hidden files, excludes .git)
- `<leader>sp` - Project picker (custom)
- `<leader>sw` - Search current word
- `<leader>sd` - Search diagnostics
- `<leader>sr` - Resume last search
- `<leader>s.` - Recent files
- `<leader><leader>` - Buffer list
- `<leader>/` - Fuzzy find in current buffer
- `<leader>sn` - Search Neovim config files

## Formatting

Uses conform.nvim:
- `<leader>f` - Format buffer
- Auto-formats on save (except C/C++)
- Configured formatters: stylua (Lua)

## Dependencies

External tools required (from README.md):
```bash
brew install git gh nvim ripgrep fd fzf node rustup dotnet lazygit
rustup default stable
```

- **ripgrep** and **fd** - Required for Telescope search functionality
- **node** - Required for TypeScript development
- **rustup** - For Rust development
- **dotnet** - For C# development
- **lazygit** - Git UI (configured in git plugin)

## Important Notes

1. **Working Directory Behavior**: The auto-cd-to-git-root feature runs on every buffer enter. When making changes that affect file paths or project structure, be aware that the cwd will automatically change.

2. **Turkish Keyboard**: The langmap configuration affects all normal mode commands. Turkish keys are mapped to their English equivalents for Vim motions.

3. **Single File vs Modular**: This configuration follows kickstart.nvim's single-file approach in init.lua, with custom plugins separated into lua/custom/plugins/. Each file in lua/custom/plugins/ is auto-loaded by lazy.nvim.

4. **Theme**: Currently using tokyonight-night colorscheme (defined in init.lua), with nightfox available in custom plugins.

5. **Diagnostic Configuration**: Only ERROR severity diagnostics are underlined. Virtual text shows all diagnostic levels but only errors are underlined.
