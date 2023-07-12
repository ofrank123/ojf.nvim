function ColorThings(color)
	vim.cmd("set termguicolors")

	color = color or "solarized"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorThings()
