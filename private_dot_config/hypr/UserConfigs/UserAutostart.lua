-- https://wiki.hypr.land/configuring/core/autostart/
local programs = require("UserConfigs/UserDefaultPrograms")

-----------------
--- AUTOSTART ---
-----------------

-- Autostart necessary processes (notification daemons, status bars, etc.)
hl.on("hyprland.start", function()
	-- Autostarting apps to workspaces:
	hl.exec_cmd(programs.terminal, { workspace = "6 silent" })

	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("syncthing --no-browser")
	hl.exec_cmd("syncthingtray --single-instance --wait") -- start syncthing tray
	hl.exec_cmd("swaync")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("gsettings set org.cinnamon.desktop.default-applications.terminal exec " .. programs.terminal) -- default terminal in Nemo
	hl.exec_cmd("hyprctl setcursor BreezeX-RosePine-Linux 24")
	hl.exec_cmd("wpctl settings --save bluetooth.autoswitch-to-headset-profile false") -- https://wiki.archlinux.org/title/PipeWire#Automatic_profile_selection
	hl.exec_cmd("waybar")
	hl.exec_cmd("elephant") -- for Walker
	hl.exec_cmd("vicinae server")
	hl.dispatch(hl.dsp.focus({ monitor = 1 })) -- focus main monitor on startup
end)
