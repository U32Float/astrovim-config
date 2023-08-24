local Util = {}

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match "(.*/)"
end

local function read_json(file)
  local f = io.open(file, "r")
  if not f then return {} end
  local content = f:read "*all"
  f:close()
  return vim.fn.json_decode(content)
end

local function write_json(file, table)
  local f = io.open(file, "w")
  local content = f:write(vim.fn.json_encode(table))
  f:close()
end

function Util.read(name, default)
  local user_data = read_json(script_path() .. ".user-data")

  local data = user_data[name]
  if data == nil then
    return default
  else
    return data
  end
end

function Util.write(name, value)
  local user_data = read_json(script_path() .. ".user-data")
  user_data[name] = value
  write_json(script_path() .. ".user-data", user_data)
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function Util.get_root()
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
function Util.OpenDiagnosicIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then return end
  end
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float(0, {
    scope = "line",
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

function Util.set_workspace()
  local cwd = vim.fn.getcwd()
  local root = Util.get_root()

  if cwd == root then return end

  vim.cmd("cd " .. root)
  vim.cmd(string.format("call system(\"tmux rename-window '%s'\")", root))

  local workspace = read_json "workspace.json"
  if workspace == nil then return end

  local hide = workspace["hide"]
  if hide then require("neo-tree").config.filesystem.filtered_items.hide_by_pattern = hide end
end

return Util
