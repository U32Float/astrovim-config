return {
  n = {
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
  },
  v = {
    ["s"] = { '"_d', desc = "Delete wihout copy" },
    ["c"] = { '"_c', desc = "Replace wihout copy" },

    ["<S-l>"] = { "$", desc = "Go to end of line" },
    ["<S-h>"] = { "^", desc = "Go to beginning of line" },
    ["<S-m>"] = false, -- Remove binding

    ["<C-j>"] = { function() require("neoscroll").scroll(25, true, 50, nil, {}) end, desc = "Scroll down" },
    ["<C-k>"] = { function() require("neoscroll").scroll(-25, true, 50, nil, {}) end, desc = "Scroll up" },
  },
  t = {},
}
