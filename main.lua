local json = require "lunajson"
local save_path = "todo.json"


local function read_todo()
  local file = io.open(save_path, "r")
  if not file then
    error("OIIII UR STUFF SUCKJ")
  end
  local file_data = file:read()
  file:close()

  return json.decode(file_data)
end

local function save_todo(data)
  local json_data = json.encode(data)
  local file = io.open(save_path, "w")
  if not file then
    error("Oi, fix ur stuff")
  end
  file:write(json_data)
  file:close()
end

if #arg ~= 0 then
  local data = read_todo()

  if arg[1] == "finish" then
    data[arg[2]] = true
  elseif arg[1] == "remove" then
    data[arg[2]] = nil
  elseif arg[1] == "add" then
    data[arg[2]] = false
  end

  save_todo(data)
else
  local data = read_todo()
  for k, v in pairs(data) do
    local status = "Finished"
    if not v then
      status = "In progress"
    end
    print(k, "Status: " .. status)
  end
end
