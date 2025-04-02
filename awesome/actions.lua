local awful = require("awful")
local hk_pu = require("awful.hotkeys_popup")
local menubar = require("menubar")

local apps = require("apps")
local menu = require("menu")

local inc_step = 0.05
local chg_step = 1

return {
  awesome = {
    show_help = function()
      hk_pu.show_help()
    end,
    show_menu = function()
      menu:show()
    end,
    restart = function()
      awesome.restart()
    end,
    quit = function()
      awesome.quit()
    end,
    run_lua_code = function()
      awful.prompt.run({
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().promptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval",
      })
    end,
  },
  client = {
    tgl_full = function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    close = function()
      local c = awful.client.next(0)
      c:kill()
    end,
    tgl_flt = function()
      awful.client.floating.toggle()
    end,
    swap = function()
      local c = awful.client.next(0)
      c:swap(awful.client.getmaster())
    end,
    mv_to_scr = function()
      local c = awful.client.next(0)
      c:move_to_screen()
    end,
    keep_on_top = function()
      local c = awful.client.next(0)
      c.ontop = not c.ontop
    end,
    minimize = function()
      local c = awful.client.next(0)
      c.minimized = true
    end,
    restore = function()
      local c = awful.client.restore()
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end,
    tgl_max = function()
      local c = awful.client.next(0)
      c.maximized = not c.maximized
      c:raise()
    end,
    tgl_max_vt = function()
      local c = awful.client.next(0)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    tgl_max_hz = function()
      local c = awful.client.next(0)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    focus_on_next = function()
      awful.client.focus.byidx(1)
    end,
    focus_on_prev = function()
      awful.client.focus.byidx(-1)
    end,
    swp_next = function()
      awful.client.swap.byidx(1)
    end,
    swp_prev = function()
      awful.client.swap.byidx(-1)
    end,
    jmp_to_urg = function()
      awful.client.urgent.jumpto()
    end,
    go_back = function()
      awful.client.focus.history.previous()
      if awful.client.focus then
        awful.client.focus:raise()
      end
    end,
  },
  launcher = {
    spawn_term = function()
      awful.spawn(apps.terminal)
    end,
    spawn_browser = function()
      awful.spawn(apps.browser)
    end,
    run_prompt = function()
      awful.screen.focused().promptbox:run()
    end,
    run_launcher = function()
      awful.spawn(apps.launcher)
    end,
    show_menubar = function()
      menubar.show()
    end,
  },
  layout = {
    inc_width = function()
      awful.tag.incmwfact(inc_step)
    end,
    dec_width = function()
      awful.tag.incmwfact(-inc_step)
    end,
    inc_num_masters = function()
      awful.tag.incmaster(chg_step, nil, true)
    end,
    dec_num_masters = function()
      awful.tag.incmaster(-chg_step, nil, true)
    end,
    inc_num_cols = function()
      awful.tag.incncol(chg_step, nil, true)
    end,
    dec_num_cols = function()
      awful.tag.incncol(-chg_step, nil, true)
    end,
    select_next = function()
      awful.layout.inc(chg_step)
    end,
    select_prev = function()
      awful.layout.inc(-chg_step)
    end,
  },
  screen = {
    focus_on_next = function()
      awful.screen.focus_relative(1)
    end,
    focus_on_prev = function()
      awful.screen.focus_relative(-1)
    end,
  },
  tag = {
    view_next = function(t)
      awful.tag.viewprev(t.screen)
    end,
    view_prev = function(t)
      awful.tag.viewnext(t.screen)
    end,
    go_back = function()
      awful.tag.history.restore()
    end,
    view = function(i)
      return function()
        local scr = awful.screen.focused()
        local tag = scr.tags[i]
        if tag then
          tag:view_only()
        end
      end
    end,
    toggle = function(i)
      return function()
        local scr = awful.screen.focused()
        local tag = scr.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end
    end,
    move_client = function(i)
      return function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end
    end,
    toggle_client = function(i)
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
}
