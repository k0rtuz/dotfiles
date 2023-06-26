local awful = require("awful")

local M = {}

local inc_step = 0.05
local chg_step = 1

function M.inc_width()
	awful.tag.incmwfact(inc_step)
end

function M.dec_width()
	awful.tag.incmwfact(-inc_step)
end

function M.inc_num_masters()
	awful.tag.incmaster(chg_step, nil, true)
end

function M.dec_num_masters()
	awful.tag.incmaster(-chg_step, nil, true)
end

function M.inc_num_cols()
	awful.tag.incncol(chg_step, nil, true)
end

function M.dec_num_cols()
	awful.tag.incncol(-chg_step, nil, true)
end

function M.select_next()
  awful.layout.inc(chg_step)
end

function M.select_prev()
  awful.layout.inc(-chg_step)
end

return M
