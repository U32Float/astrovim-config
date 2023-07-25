return {
  "goolord/alpha-nvim",
  opts = function()
    local dashboard = require "alpha.themes.dashboard"
    local logo = [[
            ██╗ ██████╗ ███████╗██████╗     ██╗   ██╗██╗███╗   ███╗
            ██║██╔═══██╗██╔════╝██╔══██╗    ██║   ██║██║████╗ ████║
            ██║██║   ██║█████╗  ██████╔╝    ██║   ██║██║██╔████╔██║
       ██   ██║██║   ██║██╔══╝  ██╔═══╝     ╚██╗ ██╔╝██║██║╚██╔╝██║
       ╚█████╔╝╚██████╔╝███████╗██║          ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚════╝  ╚═════╝ ╚══════╝╚═╝           ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/lua/user/init.lua<CR>"),
      dashboard.button("s", " " .. " Restore session", [[:lua require("persistence").load() <cr>]]),
      dashboard.button("t", "󰥻" .. "  Typing practice", ":lua require('typebreak').start() <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
}
