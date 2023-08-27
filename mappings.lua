local util = require "user.util"
local tmux = require "nvim-tmux-navigation"
local ls = require "luasnip"

return {
  i = {
    ["jk"] = { "<Esc>", desc = "Escape insert mode", noremap = true },
  },
  n = {
    ["<Esc>"] = {
      function()
        vim.cmd ":noh"
        require("notify").dismiss()
        ls.unlink_current()
      end,
      silent = true,
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

    -- ["<Tab>"] = {
    --   function()
    --     if ls.expand_or_jumpable() then ls.jump(1) end
    --   end,
    --   silent = true,
    --   desc = "Jump to next snippet insert point",
    -- },
    -- ["<S-Tab>"] = {
    --   function()
    --     if ls.expand_or_jumpable() then ls.jump(-1) end
    --   end,
    --   silent = true,
    --   desc = "Jump to previous snippet insert point",
    -- },

    ["<cr>"] = {
      function()
        vim.api.nvim_feedkeys("@q", "m", false)
        -- require("notify").notify("Applied macro (q)", "info")
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
    ["<C-j>"] = { function() require("neoscroll").scroll(25, false, 60, nil, {}) end, desc = "Scroll down" },
    ["<C-k>"] = { function() require("neoscroll").scroll(-25, false, 60, nil, {}) end, desc = "Scroll up" },
    -- ["<ScrollWheelUp>"] = { function() require("neoscroll").scroll(-5, true, 10, nil, {}) end, desc = "Scroll down" },
    -- ["<ScrollWheelDown>"] = { function() require("neoscroll").scroll(5, true, 10, nil, {}) end, desc = "Scroll up" },
    -- ["<ScrollWheelUp-C>"] = {
    --   function() require("neoscroll").scroll(-4, false, 1, nil, {}) end,
    --   desc = "Scroll down",
    -- },
    -- ["<ScrollWheelDown-C>"] = { function() require("neoscroll").scroll(4, false, 1, nil, {}) end, desc = "Scroll up" },

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
    ["<leader>r"] = {
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
    ["<leader>fr"] = {
      function() vim.cmd "Telescope oldfiles" end,
      desc = "Search recent files",
    },

    ["<leader>/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in current buffer" },

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

    ["<S-cr>"] = {
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

    ["<leader>w"] = { "<cmd>HopWord<cr>", desc = "Hop to word", nowait = true },

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

    ["<leader>m"] = { false, desc = "Marks / Harpoon" },

    ["<leader>ma"] = {
      function()
        require("harpoon.mark").add_file()
        require("notify").notify("Added " .. vim.fn.expand "%" .. " to harpoon list")
      end,
      desc = "Add file to harpoon list",
    },
    ["<leader>md"] = {
      function()
        require("harpoon.mark").rm_file(vim.fn.expand "%")
        require("notify").notify("Removed " .. vim.fn.expand "%" .. " from harpoon list")
      end,
      desc = "Remove file from harpoon list",
    },
    ["<leader>mD"] = {
      function()
        require("harpoon.mark").clear_all()
        require("notify").notify "Removed all marks from harpoon list"
      end,
      desc = "Remove all marks from harpoon list",
    },
    ["<leader>mm"] = {
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Open harpoon telescope",
    },
    ["<leader>mp"] = {
      function() require("harpoon.ui").nav_prev() end,
      desc = "Go to previous harpoon mark",
    },
    ["<leader>mn"] = {
      function() require("harpoon.ui").nav_next() end,
      desc = "Go to next harpoon mark",
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

    ["<leader>w"] = { "<cmd>HopWord<cr>", desc = "Hop to word", nowait = true },
    ["<leader>j"] = { "<cmd>HopLineStartAC<cr>", desc = "Hop to line under cursor", nowait = true },
    ["<leader>k"] = { "<cmd>HopLineStartBC<cr>", desc = "Hop to line above cursor", nowait = true },

    ["<leader>n"] = { ":noh <cr>", silent = true, nowait = true, desc = "Remove highlights" },
  },
  t = {},
}
