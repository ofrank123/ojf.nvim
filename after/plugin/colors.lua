function ColorThings(color)
	vim.cmd("set termguicolors")

	color = color or "solarized"
	vim.cmd.colorscheme(color)
end

ColorThings()
