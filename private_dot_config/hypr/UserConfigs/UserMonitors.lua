-- https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@180",
	position = "0x0",
	scale = 1,
	bitdepth = 10,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "-1920x180",
	scale = 1,
})
