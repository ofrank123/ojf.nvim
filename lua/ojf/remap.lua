function nmap(map, fn, desc)
	vim.keymap.set("n", map, fn, { desc = desc })
end

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")


nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("Q", "<nop>")
nmap("<leader>d", vim.cmd.Ex, "Open [D]irectory")

