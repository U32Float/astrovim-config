return {
  "aznhe21/hop.nvim",
  lazy = false,
  config = function()
    require("hop").setup {
      uppercase_labels = false,
    }
  end,
  keys = {},
}
