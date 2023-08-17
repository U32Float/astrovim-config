return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    local node = {
      hl_group = "Search",
      virt_text = { { "{*}", "VirtualTextHint" } },
    }
    local vis = {
      hl_group = "Normal",
    }
    local types = require "luasnip.util.types"
    opts.ext_opts = {
      [types.insertNode] = {
        active = node,
        visited = vis,
        passive = node,
        -- snippet_passive = node,
      },
      -- [types.choiceNode] = {
      --   active = node,
      -- unvisited = node,
      -- },
      -- [types.snippet] = {
      --   passive = node,
      -- },
    }

    -- include the default astronvim config that calls the setup call
    require "plugins.configs.luasnip"(plugin, opts)
    -- load snippets paths
    require("luasnip.loaders.from_vscode").lazy_load {
      -- this can be used if your configuration lives in ~/.config/nvim
      -- if your configuration lives in ~/.config/astronvim, the full path
      -- must be specified in the next line
      paths = { "./lua/user/snippets" },
    }
  end,
}
