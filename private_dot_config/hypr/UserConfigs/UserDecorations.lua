-- https://wiki.hypr.land/configuring/core/config-options/#decoration
local c = require("colors")

hl.config({
	decoration = {
		active_opacity = 1.0,
		inactive_opacity = 0.90,
		rounding = 10,

		blur = {
			enabled = true,
			brightness = 1,
			contrast = 1,
			ignore_opacity = false,
			passes = 4,
			popups = true,
			special = true,
			size = 1,
			vibrancy = 0.2696,
		},

		shadow = {
			enabled = false,
			color = c.outline,
			color_inactive = "rgba(181a1a00)",
			range = 12,
			render_power = 3,
		},
	},
})
