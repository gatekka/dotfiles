local c = require("colors")
local hs = require("plugins.hyprsplit")

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

------------------
--- HYPRSPLIT  ---
------------------
hs.config({
	num_workspaces = 5, -- 5 workspaces per monitor
	persistent_workspaces = true,
})

------------------------------
--- PROGRAM SPECIFIC RULES ---
------------------------------

-- qView
hl.window_rule({
	name = "qView",
	match = { class = "(com.interversehq.qView)" },
	float = true,
})

-- Gemini
hl.window_rule({
	name = "Gemini",
	match = { class = "(gemini)" },
	pseudo = true,
	size = "750 750",
	keep_aspect_ratio = true,
})

-- MPV
hl.window_rule({
	name = "MPV",
	match = { class = "(mpv)" },
	float = true,
	size = "75% 75%",
	keep_aspect_ratio = true,
})

hl.window_rule({
	name = "Fullscreened Windows",
	match = { fullscreen = true },
	no_shadow = true,
	border_size = 0,
	rounding = 0,
	no_anim = true,
})

-- All programs: ignore maximize requests from apps
hl.window_rule({
	name = "All Programs",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-------------------
--- LAYER RULES ---
-------------------
hl.layer_rule({
	name = "Swaync Control Center",
	match = { namespace = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0.1,
})
hl.layer_rule({
	name = "Swaync Notification Window",
	match = { namespace = "swaync-notification-window" },
	blur = true,
	ignore_alpha = 0.1,
})
hl.layer_rule({
	name = "Vicinae",
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0.1,
})
hl.layer_rule({
	name = "Waybar",
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.1,
})
hl.layer_rule({
	name = "Wlogout",
	match = { namespace = "logout_dialog" },
	blur = true,
})

--------------------
--- LAYOUT RULES ---
--------------------
-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
hl.config({
	scrolling = {
		focus_fit_method = 1,
		column_width = 0.95,
		direction = "down",
	},
})

-----------------------
--- WORKSPACE RULES ---
-----------------------
-- When workspace has 1 visible window
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 50, gaps_in = 0 })
hl.workspace_rule({ workspace = "w[tv1]s[true]", gaps_out = 62.5, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "r[6-6]w[tv1]", gaps_out = ... })  -- was gapsout:300 400
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 }) -- when fullscreened

hl.workspace_rule({ workspace = "s[true]", layout = "scrolling" }) -- special workspaces
hl.workspace_rule({ workspace = "1", layout = "scrolling" }) -- workspace 1

-- Bind workspaces to monitors (was commented out)
-- hl.workspace_rule({ workspace = "1", monitor = "DP-3" })  -- ...and so on for 2-5
-- hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1" })  -- ...and so on for 7-10

------------------------------------------------------------------------------------------
-- PLUGINS (hyprpm: hyprexpo, hyprbars). pcall'd so a missing plugin can't abort the file.
------------------------------------------------------------------------------------------
local function configure_plugins()
	pcall(hl.config, {
		plugin = {
			hyprexpo = {
				workspace_method = "center",
				columns = 3,
				skip_empty = false,
			},
			hyprbars = {
				bar_height = 25,
				bar_color = c.surface_container,
				bar_buttons_alignment = "left",
				bar_part_of_window = true,
				bar_precedence_over_border = false,
				col = { text = c.primary_fixed },
				bar_title_enabled = true,
				bar_text_font = "CodeNewRoman Nerd Font Propo",
				bar_blur = true,
				on_double_click = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
			},
		},
	})

	if hl.plugin and hl.plugin.hyprbars then
		pcall(hl.plugin.hyprbars.add_button, {
			bg_color = c.red,
			size = 14,
			icon = "", -- paste your Nerd Font glyph back here
			action = [[hyprctl dispatch 'hl.dsp.window.close()']],
		})
		pcall(hl.plugin.hyprbars.add_button, {
			bg_color = c.yellow,
			size = 14,
			icon = "", -- and here
			action = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
		})
	end
end

hl.on("config.reloaded", configure_plugins)
