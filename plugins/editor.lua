return {
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      -- hi default link HlSearchNear IncSearch
      -- hi default link HlSearchLens WildMenu
      -- hi default link HlSearchLensNear IncSearch

      require("hlslens").setup {
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "N" or "n")
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and "N" or "n"
          else
            indicator = ""
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= "" then
              text = ("󰧟[%s %d/%d]"):format(indicator, idx, cnt)
            else
              text = ("󰧟[%d/%d]"):format(idx, cnt)
            end
            chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
          else
            text = ("󰧟[%s %d]"):format(indicator, idx)
            chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
      }
    end,
  },
  {
    "rapan931/lasterisk.nvim",
  },
  -- {
  --   "petertriho/nvim-scrollbar",
  --   lazy = false,
  --   config = function()
  --     require("scrollbar").setup {
  --       show = true,
  --       show_in_active_only = true,
  --       set_highlights = true,
  --       folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
  --       max_lines = false, -- disables if no. of lines in buffer exceeds this
  --       hide_if_all_visible = true, -- Hides everything if all lines are visible
  --       throttle_ms = 100,
  --       handle = {
  --         text = "  ",
  --         blend = 0, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
  --         color = nil,
  --         color_nr = nil, -- cterm
  --         highlight = "CursorColumn",
  --         hide_if_all_visible = true, -- Hides handle if all lines are visible
  --       },
  --       marks = {
  --         Cursor = {
  --           text = "__",
  --           priority = 0,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "Normal",
  --         },
  --         Search = {
  --           text = { "__", "==" },
  --           priority = 1,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "Search",
  --         },
  --         Error = {
  --           text = { "__", "==" },
  --           priority = 2,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "DiagnosticFloatingError",
  --         },
  --         Warn = {
  --           text = { "__", "==" },
  --           priority = 3,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "DiagnosticFloatingWarn",
  --         },
  --         Info = {
  --           text = { "__", "==" },
  --           priority = 4,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "DiagnosticFloatingInfo",
  --         },
  --         Hint = {
  --           text = { "__", "==" },
  --           priority = 5,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "DiagnosticFloatingHint",
  --         },
  --         Misc = {
  --           text = { "__", "==" },
  --           priority = 6,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "Normal",
  --         },
  --         GitAdd = {
  --           text = "┆",
  --           priority = 7,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "GitSignsAdd",
  --         },
  --         GitChange = {
  --           text = "┆",
  --           priority = 7,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "GitSignsChange",
  --         },
  --         GitDelete = {
  --           text = "▁",
  --           priority = 7,
  --           gui = nil,
  --           color = nil,
  --           cterm = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "GitSignsDelete",
  --         },
  --       },
  --       excluded_buftypes = {
  --         "terminal",
  --       },
  --       excluded_filetypes = {
  --         "cmp_docs",
  --         "cmp_menu",
  --         "noice",
  --         "prompt",
  --         "TelescopePrompt",
  --         "neo-tree",
  --         "alpha",
  --         "",
  --       },
  --       autocmd = {
  --         render = {
  --           "BufWinEnter",
  --           "TabEnter",
  --           "TermEnter",
  --           "WinEnter",
  --           "CmdwinLeave",
  --           "TextChanged",
  --           "VimResized",
  --           "WinScrolled",
  --         },
  --         clear = {
  --           "BufWinLeave",
  --           "TabLeave",
  --           "TermLeave",
  --           "WinLeave",
  --         },
  --       },
  --       handlers = {
  --         cursor = true,
  --         diagnostic = true,
  --         gitsigns = false, -- Requires gitsigns
  --         handle = true,
  --         search = true, -- Requires hlslens
  --         ale = false, -- Requires ALE
  --       },
  --     }
  --   end,
  -- },
  {
    "dstein64/nvim-scrollview",
    lazy = false,

    config = function()
      require("scrollview").setup {
        excluded_filetypes = { "nerdtree", "alpha" },
        current_only = true,
        winblend = 0,
        base = "right",
        hover = true,
        column = 1,
        signs_on_startup = { "all" },
        diagnostics_severities = { vim.diagnostic.severity.WARN },
      }
    end,
  },
  {
    "anuvyklack/windows.nvim",
    lazy = false,
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
  },
}
