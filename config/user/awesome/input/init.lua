local kb = require("input.keyboard")
local ms = require("input.mouse")

local M = {
	keyboard = kb,
	mouse = ms,
}

function M.bind()
  M.mouse.bind()
  M.keyboard.bind()
end

return M
