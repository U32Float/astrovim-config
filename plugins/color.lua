local util = require "user.util"

function override_everforest()
  vim.g.everforest_background = "dark"
  vim.g.everforest_colors_override = {
    -- bg_dim = { "#000000", "233" },
    -- bg0 = { "#000000", "235" },
    -- bg1 = { "#141414", "236" },
    -- bg2 = { "#1d1d1d", "237" },
    -- bg3 = { "#282828", "238" },
    -- bg4 = { "#323232", "239" },
    -- bg5 = { "#3b3b3b", "240" },
    -- bg_red = { "#514045", "52" },
    -- bg_green = { "#425047", "22" },
    -- bg_blue = { "#3a515d", "17" },
    -- bg_yellow = { "#4d4c43", "136" },
    bg_visual = { "#485e61", "255" },
  }

  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#434f55", default = false })
end

function override_gruvbox()
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#d5c4a1", default = false })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "#b57614", default = false })
  vim.api.nvim_set_hl(0, "IncSearch", { link = "PMenuSel", default = false })
  vim.api.nvim_set_hl(0, "Search", { link = "PMenu", default = false })
  vim.api.nvim_set_hl(0, "CurSearch", { link = "PMenuSel", default = false })
end

function override_colorscheme()
  vim.api.nvim_set_hl(0, "CursorColumn", { link = "StatusLine", default = false })
  vim.api.nvim_set_hl(0, "ScrollView", { link = "StatusLine", default = false })
  vim.api.nvim_set_hl(0, "HlSearchLens", { link = "DiagnosticVirtualTextInfo", default = false })
  vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "DiagnosticVirtualTextInfo", default = false })
end

function on_colorscheme()
  if vim.g.ready then
    util.write("theme", { colorscheme = vim.g.colors_name, background = vim.opt.background._value })
  end
  override_colorscheme()
end

vim.api.nvim_create_autocmd("ColorScheme", {
  command = "lua on_colorscheme()",
})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "everforest",
  command = "lua override_everforest()",
})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "gruvbox",
  command = "lua override_gruvbox()",
})

return {
  { "Mofiqul/vscode.nvim", lazy = false },
  { "joshdick/onedark.vim", lazy = false },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
  },
  { "arzg/vim-colors-xcode", lazy = false },
  { "sickill/vim-monokai", lazy = false },
  { "sainnhe/gruvbox-material", lazy = false },
  { "sainnhe/sonokai", lazy = false },
  { "tomasiser/vim-code-dark", lazy = false },
  { "sainnhe/edge", lazy = false },
  { "goatslacker/mango.vim", lazy = false },
  { "dunstontc/vim-vscode-theme", lazy = false },
  { "rose-pine/neovim", name = "rose-pine", lazy = false },
  { "gmr458/vscode_dark_modern.nvim", lazy = false },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
  { "RRethy/nvim-base16", lazy = false },
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
