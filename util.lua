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

return Util
