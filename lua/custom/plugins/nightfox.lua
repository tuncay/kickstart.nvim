return {
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        colorblind = {
          enable = true,
          simulate_only = false, -- keep this false to actually improve contrast
          severity = {
            -- tweak 0.0..1.0; you said slight red/green, so start like this:
            deutan = 0.38, -- green weakness
            protan = 0.63, -- red weakness (lower if you mostly struggle with green)
            tritan = 0.0, -- blue weakness (likely not needed)
          },
        },
      },
    },
    config = function(_, opts)
      require('nightfox').setup(opts)
      vim.opt.termguicolors = true
      vim.cmd 'colorscheme nightfox' -- or any variant: dayfox/dawnfox/duskfox/nordfox/terafox/carbonfox
    end,
  },
}
