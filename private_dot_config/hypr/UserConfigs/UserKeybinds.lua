local programs = require("UserConfigs/UserDefaultPrograms")
local paths = require("UserConfigs/UserPaths")
local hs = require("plugins.hyprsplit")

-- Tip: use `wev` to see key codes
local mod = "SUPER" -- "Windows" key as main modifier

-- Apps / launchers
hl.bind(
	mod .. " + SHIFT + code:61",
	hl.dsp.exec_cmd("vicinae vicinae://extensions/sovereign/hypr-keybinds/hyprland-keybinds"),
	{ description = "Show Hyprland Keybinds" }
)

hl.bind(
	mod .. " + PRINT",
	hl.dsp.exec_cmd("hyprshot -z -m output -o " .. paths.picturesPath),
	{ description = "Screenshot monitor" }
)
hl.bind(
	mod .. " + SHIFT + S",
	hl.dsp.exec_cmd("hyprshot -z -m region -o " .. paths.picturesPath),
	{ description = "Screenshot region" }
)

hl.bind(mod .. " + C", hl.dsp.exec_cmd(programs.terminal), { description = "Open terminal" })
hl.bind(mod .. " + Q", hl.dsp.window.close(), { description = "Closes active window" })
hl.bind(mod .. " + M", hl.dsp.exec_cmd(paths.scripts .. "/wlogout.sh"), { description = "Open power management menu" })
hl.bind(mod .. " + E", hl.dsp.exec_cmd(programs.fileManager), { description = "Open file manager" })
hl.bind(mod .. " + R", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle window floating state" })
hl.bind(
	mod .. " + V",
	hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"),
	{ description = "Open clipboard" }
)
hl.bind(
	mod .. " + code:60",
	hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/core/search-emojis"),
	{ description = "Open emoji picker" }
)
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(programs.menu), { description = "Open launcher (vicinae)" })

-- Layout (dwindle)
hl.bind(mod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudo mode on active window" })
hl.bind(mod .. " + T", hl.dsp.layout("togglesplit"), { description = "Toggle split of active window" })

-- Volume mixer
hl.bind(
	mod .. " + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(programs.terminal .. " -e wiremix"),
	{ description = "Open wiremix" }
)
hl.bind(
	mod .. " + XF86AudioLowerVolume",
	hl.dsp.exec_cmd(programs.terminal .. " -e wiremix"),
	{ description = "Open wiremix" }
)
hl.bind(
	mod .. " + XF86AudioMute",
	hl.dsp.exec_cmd(programs.terminal .. " -e wiremix"),
	{ description = "Open volume control" }
)

-- Focus and move windows
local dirs = { H = "left", L = "right", K = "up", J = "down" }
for key, dir in pairs(dirs) do
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }), { description = "Move focus window" })
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ direction = dir }),
		{ description = "Move active window" }
	)
end

-- Maximize window
hl.bind(
	mod .. " + F",
	hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
	{ description = "Maximize window" }
)

-- Fullscreen window
hl.bind(
	mod .. " + G",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = "Fullscreen window" }
)

-- Pin window
hl.bind(
	mod .. " + SHIFT + P",
	hl.dsp.window.pin({ action = "toggle" }),
	{ description = "Pin floating window to all workspaces" }
)

-- Resize active window
local resize = { H = { -60, 0 }, L = { 60, 0 }, K = { 0, -60 }, J = { 0, 60 } }
for key, v in pairs(resize) do
	hl.bind(
		mod .. " + CTRL + " .. key,
		hl.dsp.window.resize({ x = v[1], y = v[2], relative = true }),
		{ description = "Resize active window" }
	)
end

-- Workspaces via hyprsplit
for i = 1, 5 do
	hl.bind(mod .. " + " .. i, hs.dsp.focus({ workspace = i }), { description = "Switch workspace" })
	hl.bind(
		mod .. " + SHIFT + " .. i,
		hs.dsp.window.move({ workspace = i, follow = false }),
		{ description = "Move active window to workspace" }
	)
end
hl.bind(
	mod .. " + TAB",
	hs.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }),
	{ description = "Swap active workspaces" }
)

-- Special workspace (scratchpad)
hl.bind(mod .. " + code:49", hl.dsp.workspace.toggle_special("0"))
hl.bind(mod .. " + SHIFT + code:49", hl.dsp.window.move({ workspace = "special:0", follow = false }))

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- Multimedia keys (repeating + works on lock screen) ---------------------
local rl = { repeating = true, locked = true }
local function with_desc(desc)
	return { repeating = true, locked = true, description = desc }
end

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"),
	with_desc("Raise volume 1%")
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
	with_desc("Lower volume 1%")
)
hl.bind(
	"SHIFT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	with_desc("Raise volume 5%")
)
hl.bind(
	"SHIFT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	with_desc("Lower volume 5%")
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), with_desc("Mute volume"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), rl)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), rl)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), rl)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
