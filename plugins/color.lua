return {
  { "Mofiqul/vscode.nvim", lazy = false },
  { "joshdick/onedark.vim", lazy = false },
  { "sainnhe/everforest", lazy = false },
  { "sickill/vim-monokai", lazy = false },
  { "sainnhe/gruvbox-material", lazy = false },
  { "sainnhe/sonokai", lazy = false },
  { "tomasiser/vim-code-dark", lazy = false },
  { "sainnhe/edge", lazy = false },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = function()
      require("gruvbox").setup {
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = false, -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
    end,
    priority = 1000,
  },
}
