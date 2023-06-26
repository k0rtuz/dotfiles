local awful = require("awful")

local startup_apps = {
	"picom --daemon",
	-- 'nm-applet --indicator', -- wifi
	--'blueberry-tray', -- Bluetooth tray icon
	--'xfce4-power-manager', -- Power manager
	"numlockx on", -- enable numlock
	-- '/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager (alternate directory if the first one is incorrect)
	-- '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1  & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
	--'/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
	-- '/usr/libexec/polkit-gnome-authentication-agent-1', -- credential manager - path for void linux
	-- 'blueman-tray', -- bluetooth tray

	-- Add applications that need to be killed between reloads
	-- to avoid multipled instances, inside the awspawn script
	"~/.config/awesome/modules/autostart/runonce.zsh", -- Spawn "dirty" apps that can linger between sessions
}

local function run_once(cmd)
	local findme = cmd
	local firstspace = cmd:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace - 1)
	end
	awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

local M = {}

local function init()
	for _, app in ipairs(startup_apps) do
		run_once(app)
	end
end

return setmetatable(M, {
    __call = function()
      init()
    end
  }
)
