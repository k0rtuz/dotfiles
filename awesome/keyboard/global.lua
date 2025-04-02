local awful = require("awful")
local gears = require("gears")

local act = require("actions")
local kb = require("keyboard.base")
local client_keys = require("keyboard.client")

return {
  bind = function()
    local global_keys = gears.table.join(
      -- Awesome
      awful.key({ kb.mod }, "s", act.awesome.show_help, { description = "Show help", group = "awesome" }),
      awful.key({ kb.mod }, "w", act.awesome.show_menu, { description = "Show main menu", group = "awesome" }),
      awful.key({ kb.mod, kb.ctrl }, "r", act.awesome.restart, { description = "Reload AwesomeWM", group = "awesome" }),
      awful.key({ kb.mod, kb.sh }, "q", act.awesome.quit, { description = "Quit AwesomeWM", group = "awesome" }),
      awful.key({ kb.mod }, "x", act.awesome.run_lua_code, { description = "Execute prompt (Lua)", group = "awesome" }),
      awful.key({ kb.alt }, "i", kb.cycle, { description = "Cycle keyboard layout", group = "awesome" }),

      -- Launcher
      awful.key({ kb.mod }, "Return", act.launcher.spawn_term, { description = "Open a terminal", group = "launcher" }),
      awful.key(
        { kb.mod },
        "b",
        act.launcher.spawn_browser,
        { description = "Open a browser window", group = "launcher" }
      ),
      awful.key({ kb.mod }, "r", act.launcher.run_prompt, { description = "Run prompt", group = "launcher" }),
      awful.key(
        { kb.mod },
        "e",
        act.launcher.run_launcher,
        { description = "Open launcher (Rofi)", group = "launcher" }
      ),
      awful.key({ kb.mod }, "p", act.launcher.show_menubar, { description = "Show menubar", group = "launcher" }),

      -- Layout
      awful.key(
        { kb.mod },
        "l",
        act.layout.inc_width,
        { description = "Increase master width factor", group = "layout" }
      ),
      awful.key(
        { kb.mod },
        "h",
        act.layout.dec_width,
        { description = "Decrease master width factor", group = "layout" }
      ),
      awful.key(
        { kb.mod, kb.sh },
        "h",
        act.layout.inc_num_masters,
        { description = "Increase the number of master clients", group = "layout" }
      ),
      awful.key(
        { kb.mod, kb.sh },
        "l",
        act.layout.dec_num_masters,
        { description = "Decrease the number of master clients", group = "layout" }
      ),
      awful.key(
        { kb.mod, kb.ctrl },
        "h",
        act.layout.inc_num_cols,
        { description = "Increase the number of columns", group = "layout" }
      ),
      awful.key(
        { kb.mod, kb.ctrl },
        "l",
        act.layout.dec_num_cols,
        { description = "Decrease the number of columns", group = "layout" }
      ),
      awful.key({ kb.mod }, "space", act.layout.select_next, { description = "Select next layout", group = "layout" }),
      awful.key(
        { kb.mod, kb.sh },
        "space",
        act.layout.select_prev,
        { description = "Select previous layout", group = "layout" }
      ),

      -- Screen
      awful.key(
        { kb.mod, kb.ctrl },
        "k",
        act.screen.focus_on_next,
        { description = "Focus the next screen", group = "screen" }
      ),
      awful.key(
        { kb.mod, kb.ctrl },
        "j",
        act.screen.focus_on_prev,
        { description = "Focus the previous screen", group = "screen" }
      ),

      -- Tag
      awful.key({ kb.mod }, "Left", act.tag.view_prev, { description = "View previous tag", group = "tag" }),
      awful.key({ kb.mod }, "Right", act.tag.view_next, { description = "View next tag", group = "tag" }),
      awful.key({ kb.mod }, "Escape", act.tag.go_back, { description = "Go back", group = "tag" })

      -- Misc
      -- awful.key({}, "", actions.foo, { description = "", group = "" }),
    )

    global_keys = gears.table.merge(global_keys, client_keys.instance)

    for i = 1, 5 do
      global_keys = gears.table.join(
        global_keys,
        awful.key({ kb.mod }, "#" .. i + 9, act.tag.view(i), { description = "View tag #" .. i, group = "tag" }),
        awful.key(
          { kb.mod, kb.sh },
          "#" .. i + 9,
          act.tag.move_client(i),
          { description = "Move focused client to tag #" .. i, group = "tag" }
        )
      )
    end
    root.keys(global_keys)
  end,
}
