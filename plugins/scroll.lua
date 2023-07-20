return {
  "karb94/neoscroll.nvim",
  lazy = false,
  config = function()
    require("neoscroll").setup {
      hide_cursor = false,
      stop_eof = false,
      respect_scrolloff = false,
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
    }
    local t = {}
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50" } }
    t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50" } }
    require("neoscroll.config").set_mappings(t)
  end,
}
