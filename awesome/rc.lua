-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local apps = require("apps")
local autostart = require("autostart")
local error = require("error")
local global_keys = require("keyboard.global")
local global_buttons = require("mouse.global")
local desktop = require("ui.desktop")
local rules = require("rules")
local signals = require("signals.main")

local gfs = require("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local menubar = require("menubar")

error.handle()
-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gfs.get_themes_dir() .. "custom/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it
desktop.bind()
global_buttons.bind()
global_keys.bind()

awful.rules.rules = rules

signals.connect()
autostart()
