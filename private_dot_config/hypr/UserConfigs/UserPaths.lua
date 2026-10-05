local home = os.getenv("HOME")

return {
	home = home,
	picturesPath = home .. "/Pictures",
	scripts = home .. "/.config/hypr/scripts",
}
