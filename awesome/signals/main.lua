local clt = require("signals.client")
local slp = require("signals.sloppyfocus")

return {
  connect = function()
    clt.connect()
    slp.enable()
  end,
}
