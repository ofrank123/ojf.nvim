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

local function commentHeader()
	vim.cmd('normal A//------------------------------');
	vim.cmd('normal o//~ ojf: ');
	vim.cmd('startinsert!');
end
nmap("<leader>ch", commentHeader, "Insert [H]eader");

local function commentNote()
	vim.cmd('normal A//- ojf: ');
	vim.cmd('startinsert!');
end
nmap("<leader>cn", commentNote, "Insert [N]ote");
