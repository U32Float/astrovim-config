return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  config = function()
    require("neo-tree").setup {
      default_component_configs = {
        window = {
          position = "right",
        },
      },
    }
  end,
  keys = {
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute {
          toggle = true,
          dir = vim.loop.cwd(),
          position = "right",
        }
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}
