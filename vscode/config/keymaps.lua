function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("i", "jk", "<Esc>", { desc = "Escape insert mode" })

map("n", "x", '"_x', { desc = "Delete with copy" })
map("n", "X", '"_X', { desc = "Delete rest of line with copy" })
map("n", "s", '"_d', { desc = "Delete without copy" })
map("v", "s", '"_d', { desc = "Delete without copy" })
map("n", "ss", '"_dd', { desc = "Delete line without copy" })
map("n", "S", '"_D', { desc = "Delete rest of line without copy" })

map("n", "c", '"_c', { desc = "Replace" })
map("n", "C", '"_C', { desc = "Replace rest of line" })
map("v", "c", '"_c', { desc = "Replace" })
map("v", "C", '"_C', { desc = "Replace rest of line" })

map("n", "<cr>", "@q", { desc = "Apply macro (@q)", noremap = false })

map("n", "<Space>n", ":noh <cr>", {
  desc = "Remove highlights",
  silent = true,
  nowait = true,
})

map("n", "<Space>A", "ggVG", {
  desc = "Select all",
})

map("n", "*", "*N", { desc = "Select all occurences", silent = true })

map("n", "<S-l>", "$", { desc = "Go to end of line" })
map("n", "<S-h>", "^", { desc = "Go to beginning of line" })
-- Disable Shift-m
map("n", "<S-m>", "<Nop>", {})

map("v", "<S-l>", "$", { desc = "Go to end of line" })
map("v", "<S-h>", "^", { desc = "Go to beginning of line" })
-- Disable Shift-m
map("v", "<S-m>", "<Nop>", {})

map("n", "gc", "<Plug>VSCodeCommentary", {})
map("n", "gcc", "<Plug>VSCodeCommentaryLine", {})
map("v", "gc", "<Plug>VSCodeCommentary", {})

map("n", "<leader>f", "<Cmd>call VSCodeNotify('editor.action.formatDocument', 0)<CR>", {})
map("v", "<leader>f", "<Cmd>call VSCodeNotifyVisual('editor.action.formatSelection', 0)<CR><Esc>", {})
