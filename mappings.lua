-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function get_root()
  local root_patterns = { ".git", "lua" }
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then roots[#roots + 1] = r end
      end
    end
  end
  table.sort(roots, function(a, b) return #a > #b end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
-- Show diagnostics under the cursor when holding position
function OpenDiagnosticIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then return end
  end
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float(0, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

DARKMODE = true

LIGHT_THEME = "gruvbox"
DARK_THEME = "everforest"

return {
  i = {
    ["jk"] = { "<Esc>", desc = "Escape insert mode", noremap = true },
  },
  n = {
    ["<Esc>"] = { function() require("notify").dismiss() end, desc = "Dismiss notifications" },
    ["x"] = { '"_x', desc = "Delete char wihout copy" },
    ["X"] = { '"_X', desc = "Delete char (before) wihout copy" },

    ["s"] = { '"_d', desc = "Delete wihout copy" },
    ["S"] = { '"_D', desc = "Delete rest of line wihout copy" },
    ["ss"] = { '"_dd', desc = "Delete line wihout copy" },

    ["c"] = { '"_c', desc = "Replace wihout copy" },
    ["cc"] = { '"_cc', desc = "Replace line wihout copy" },
    ["C"] = { '"_C', desc = "Replace rest of line wihout copy" },

    ["<cr>"] = { "@q", desc = "Apply macro (q)" },

    ["*"] = { "*N", desc = "Select all occurences", silent = true },
    ["<leader>n"] = { ":noh <cr>", silent = true, nowait = true, desc = "Remove highlights" },

    ["<leader>A"] = { "ggVG", desc = "Select all" },

    ["<S-l>"] = { "$", desc = "Go to end of line" },
    ["<S-h>"] = { "^", desc = "Go to beginning of line" },
    ["<S-m>"] = false, -- Remove binding

    ["<C-j>"] = { function() require("neoscroll").scroll(25, true, 50, nil, {}) end, desc = "Scroll down" },
    ["<C-k>"] = { function() require("neoscroll").scroll(-25, true, 50, nil, {}) end, desc = "Scroll up" },

    ["<leader>ut"] = { "<cmd>Telescope colorscheme<cr>", desc = "Switch colorscheme" },
    ["<leader>L"] = { "<cmd>Lazy<cr>", desc = "Open Lazy" },
    ["<leader>e"] = {
      function()
        require("neo-tree.command").execute {
          toggle = true,
          dir = get_root(),
          position = "right",
        }
        -- vim.cmd "Neotree reveal"
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    ["<leader>E"] = {
      function() vim.cmd "Neotree reveal" end,
      desc = "Reveal file in tree",
    },

    ["<leader>T"] = {
      function()
        if DARKMODE then
          DARKMODE = false
          vim.cmd "set background=light"
          vim.cmd("colorscheme " .. LIGHT_THEME)
        else
          DARKMODE = true
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
    -- ["K"] = { function() vim.lsp.buf.hover() end, desc = "Lsp symbol hover" },
    ["gh"] = { OpenDiagnosticIfNoFloat, desc = "Lsp diagnostics hover" },

    ["<leader>w"] = { "<cmd>HopWordCurrentLine<cr>", desc = "Hop to word in current line", nowait = true },
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
  },
  t = {},
}
