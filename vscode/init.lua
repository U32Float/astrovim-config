-- Install lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy
vim.g.mapleader = " "

local function config()
  require "user.vscode.config.keymaps"
  require "user.vscode.config.autocmds"
  require "user.vscode.config.options"

  return "user.vscode.plugins"
end

require("lazy").setup(config())
