return {
  "aznhe21/hop.nvim",
  config = function()
    require("hop").setup {
      uppercase_labels = false,
    }
  end,
  keys = {
    -- { "<leader>w", "<cmd>HopWordAC<cr>", "Hop to word in current line", nowait = true },
    { "<leader>b", "<cmd>HopWordBC<cr>", "Hop to word in current line", nowait = true },
    { "<leader>j", "<cmd>HopLineStartAC<cr>", "Hop to line under cursor", nowait = true },
    { "<leader>k", "<cmd>HopLineStartBC<cr>", "Hop to line above cursor", nowait = true },

    -- { "<leader>w", "<cmd>HopWordAC<cr>", "Hop to word in current line", nowait = true, mode = "v" },
    { "<leader>b", "<cmd>HopWordBC<cr>", "Hop to word in current line", nowait = true, mode = "v" },
    { "<leader>j", "<cmd>HopLineStartAC<cr>", "Hop to line under cursor", nowait = true, mode = "v" },
    { "<leader>k", "<cmd>HopLineStartBC<cr>", "Hop to line above cursor", nowait = true, mode = "v" },
  },
}
