function ColorThings(color)
	vim.cmd("set termguicolors")

	color = color or "solarized"
	vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, 'PMenu', { bg = '#002b36' }) -- Override
    vim.api.nvim_set_hl(0, 'LineNr', { bg = '#002b36', fg='#657b83' }) -- Override
end

ColorThings()
