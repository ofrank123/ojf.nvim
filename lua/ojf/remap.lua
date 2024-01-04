function nmap(map, fn, desc)
	vim.keymap.set("n", map, fn, { desc = desc })
end

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", "\"+y", { desc="yank to clipboard" })
vim.keymap.set("x", "<leader>y", "\"+y", { desc="yank to clipboard" })
vim.keymap.set("x", "<leader>p", "\"+p", { desc="paste from clipboard" })

nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("Q", "<nop>")
nmap("<leader>d", vim.cmd.Ex, "Open [D]irectory")

