-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.config({
	animations = { enabled = true },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1, bezier = "myBezier" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slidefade 10%" })
