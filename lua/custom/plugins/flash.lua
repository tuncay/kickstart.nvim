-- Flash: Fast navigation plugin
-- Jump anywhere on screen with just a few keystrokes
-- Repurposes the disabled 's' key for something more useful

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    -- Customize search options
    search = {
      multi_window = true, -- Search across all visible windows
      forward = true,
      wrap = true,
      mode = 'exact', -- exact: exact match, search: fuzzy, fuzzy: full fuzzy
    },
    -- Customize jump labels
    label = {
      uppercase = false, -- Use only lowercase labels (easier to type)
      rainbow = {
        enabled = true, -- Use different colors for labels
        shade = 5,
      },
    },
    modes = {
      -- Normal mode search
      search = {
        enabled = true,
      },
      -- Char mode (f, F, t, T motions)
      char = {
        enabled = true,
        keys = { 'f', 'F', 't', 'T' }, -- Enable flash on these keys
        highlight = { backdrop = false },
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
