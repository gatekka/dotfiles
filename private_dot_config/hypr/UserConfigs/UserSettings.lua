-- https://wiki.hypr.land/Configuring/Basics/Variables/
local c = require("colors")

-- Dwindle layout
hl.config({
	dwindle = { preserve_split = true }, -- You probably want this
})

-- Master layout
hl.config({
	master = { new_status = "master" },
})

-- General
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 10,
		border_size = 1,
		no_focus_fallback = false,
		extend_border_grab_area = 30,
		hover_icon_on_border = false,

		col = {
			active_border = {
				colors = {
					c.outline,
					c.background,
					c.outline,
					c.background,
					c.outline,
					c.background,
					c.outline,
					c.background,
					c.outline,
				},
			},
			-- inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true, -- resize windows by dragging borders and gaps

		-- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},
})

-- Misc
hl.config({
	misc = {
		force_default_wallpaper = 0, -- 0 or 1 disables the anime mascot wallpapers
		disable_hyprland_logo = true,
		middle_click_paste = false,
		focus_on_activate = true,
	},
})

-- Input
hl.config({
	input = {
		kb_layout = "us",
		-- kb_variant, kb_model, kb_options, kb_rules were empty, so omitted (defaults)
		repeat_delay = 225,

		follow_mouse = 2,
		mouse_refocus = false,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification
		force_no_accel = true,

		touchpad = { natural_scroll = false },
	},
})

-- Gestures
hl.config({
	gestures = { workspace_swipe_touch = false },
})

-- Cursor
hl.config({
	cursor = { no_hardware_cursors = true },
})

-- Per-device config
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
