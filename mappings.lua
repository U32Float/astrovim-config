local util = require "user.util"
local tmux = require "nvim-tmux-navigation"

LIGHT_THEME = "gruvbox"
DARK_THEME = "everforest"

return {
  i = {
    ["jk"] = { "<Esc>", desc = "Escape insert mode", noremap = true },
  },
  n = {
    ["<Esc>"] = {
      function()
        vim.cmd ":noh"
        require("notify").dismiss()
      end,
      desc = "Dismiss notifications",
    },
    ["x"] = { '"_x', desc = "Delete char wihout copy" },
    ["X"] = { '"_X', desc = "Delete char (before) wihout copy" },

    ["s"] = { '"_d', desc = "Delete wihout copy" },
    ["S"] = { '"_D', desc = "Delete rest of line wihout copy" },
    ["ss"] = { '"_dd', desc = "Delete line wihout copy" },

    ["c"] = { '"_c', desc = "Replace wihout copy" },
    ["cc"] = { '"_cc', desc = "Replace line wihout copy" },
    ["C"] = { '"_C', desc = "Replace rest of line wihout copy" },

    ["<S-cr>"] = {
      function()
        vim.api.nvim_feedkeys("@q", "m", false)
        require("notify").notify("Applied macro (q)", "info")
      end,
      desc = "Apply macro (q)",
    },

    -- ["*"] = { "*N", desc = "Select all occurences", silent = true },
    ["*"] = {
      function()
        require("lasterisk").search()
        require("hlslens").start()
      end,
      desc = "Select all occurences",
      silent = true,
    },
    ["<leader>n"] = { ":noh <cr>", silent = true, nowait = true, desc = "Remove highlights" },

    ["<leader>A"] = { "ggVG", desc = "Select all" },

    ["<S-l>"] = { "$", desc = "Go to end of line" },
    ["<S-h>"] = { "^", desc = "Go to beginning of line" },
    ["<S-m>"] = false, -- Remove binding

    ["<a-h>"] = { function() tmux.NvimTmuxNavigateLeft() end },
    ["<a-l>"] = { function() tmux.NvimTmuxNavigateRight() end },
    ["<a-j>"] = { function() tmux.NvimTmuxNavigateDown() end },
    ["<a-k>"] = { function() tmux.NvimTmuxNavigateUp() end },
    ["<a-n>"] = false,
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-j>"] = { function() require("neoscroll").scroll(25, true, 50, nil, {}) end, desc = "Scroll down" },
    ["<C-k>"] = { function() require("neoscroll").scroll(-25, true, 50, nil, {}) end, desc = "Scroll up" },
    ["<ScrollWheelUp>"] = { function() require("neoscroll").scroll(-3, false, 1, nil, {}) end, desc = "Scroll down" },
    ["<ScrollWheelDown>"] = { function() require("neoscroll").scroll(3, false, 1, nil, {}) end, desc = "Scroll up" },
    ["<ScrollWheelUp-C>"] = {
      function() require("neoscroll").scroll(-4, false, 1, nil, {}) end,
      desc = "Scroll down",
    },
    ["<ScrollWheelDown-C>"] = { function() require("neoscroll").scroll(4, false, 1, nil, {}) end, desc = "Scroll up" },

    ["<leader>L"] = { "<cmd>Lazy<cr>", desc = "Open Lazy" },

    ["<leader>e"] = {
      function()
        require("neo-tree.command").execute {
          toggle = true,
          dir = util.get_root(),
          position = "right",
        }
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    ["<leader>E"] = {
      function()
        require("neo-tree.command").execute {
          focus = true,
          reveal = true,
          dir = util.get_root(),
          position = "right",
        }
      end,
      desc = "Reveal file in tree",
    },

    ["<leader>/"] = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in current buffer"},

    ["<leader>T"] = {
      function()
        if util.read("darkmode", true) then
          util.write("darkmode", false)
          vim.cmd "set background=light"
          vim.cmd("colorscheme " .. LIGHT_THEME)
        else
          util.write("darkmode", true)
          vim.cmd "set background=dark"
          vim.cmd("colorscheme " .. DARK_THEME)
        end
      end,
      desc = "Switch Dark/Light mode",
      nowait = true,
    },

    ["<leader>a"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
    },

    ["<cr>"] = {
      function() vim.lsp.buf.format() end,
      desc = "Format buffer",
    },

    ["<leader>uv"] = {
      function()
        local v = util.read("virtual_text", true)
        util.write("virtual_text", not v)
        vim.diagnostic.config { virtual_text = not v }
        require("notify").notify(string.format("Virtual text = %s", not v))
      end,
      desc = "Toggle virtual text on/off",
    },

    -- ["<leader>w"] = { "<cmd>HopWordCurrentLine<cr>", desc = "Hop to word in current line", nowait = true },

    ["<leader>j"] = { "<cmd>HopLineStartAC<cr>", desc = "Hop to line under cursor", nowait = true },
    ["<leader>k"] = { "<cmd>HopLineStartBC<cr>", desc = "Hop to line above cursor", nowait = true },

    ["<leader>fd"] = {
      function()
        if vim.bo.filetype ~= "rust" then
          require("notify").notify("Not supported for filetype: " .. vim.bo.filetype)
          return
        end
        vim.cmd "UniteWithCursorWord rust/doc"
      end,
      desc = "Search for word under cursor in docs",
    },
    ["<leader>fD"] = {
      function()
        if vim.bo.filetype ~= "rust" then
          require("notify").notify("Not supported for filetype: " .. vim.bo.filetype)
          return
        end
        vim.cmd "UniteWithInput rust/doc"
      end,
      desc = "Search in docs",
    },

    ["<leader>fs"] = {
      function() vim.cmd "Telescope lsp_document_symbols" end,
      desc = "Search lsp document symbols",
    },
    ["<leader>fw"] = {
      function() vim.cmd "Telescope lsp_workspace_symbols" end,
      desc = "Search lsp workspace symbols",
    },
    ["<leader>P"] = {
      function() vim.cmd "AerialNavToggle" end,
      desc = "Toggle outline popup",
    },
    ["<leader>O"] = {
      function() vim.cmd "AerialToggle" end,
      desc = "Toggle outline",
    },
  },
  v = {
    ["s"] = { '"_d', desc = "Delete wihout copy" },
    ["c"] = { '"_c', desc = "Replace wihout copy" },

    ["<S-l>"] = { "$", desc = "Go to end of line" },
    ["<S-h>"] = { "^", desc = "Go to beginning of line" },
    ["<S-m>"] = false, -- Remove binding

    ["<C-j>"] = { function() require("neoscroll").scroll(25, true, 50, nil, {}) end, desc = "Scroll down" },
    ["<C-k>"] = { function() require("neoscroll").scroll(-25, true, 50, nil, {}) end, desc = "Scroll up" },

    ["<leader>w"] = { "<cmd>HopWordCurrentLine<cr>", desc = "Hop to word in current line", nowait = true },
    ["<leader>j"] = { "<cmd>HopLineStartAC<cr>", desc = "Hop to line under cursor", nowait = true },
    ["<leader>k"] = { "<cmd>HopLineStartBC<cr>", desc = "Hop to line above cursor", nowait = true },

    ["<leader>n"] = { ":noh <cr>", silent = true, nowait = true, desc = "Remove highlights" },
  },
  t = {},
}
