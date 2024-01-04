local dap = require('dap');

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb'
};

dap.adapters.dlv = {
    type = 'executable',
    command = '/usr/bin/dlv',
    name = 'dlv'
};

local currentExecutable = nil

-- C/CPP
local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch",
	program = function()
		if currentExecutable == nil then
			currentExecutable = vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
			)
		else
			currentExecutable = vim.fn.input(
			"Path to executable: ",
			currentExecutable,
			"file"
			)
		end
		return currentExecutable
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

dap.configurations.cpp = { lldb };
dap.configurations.c = { lldb };
dap.configurations.h = { lldb };

-- Go
local dlv = {
	name = "Attach to process",
	type = "dlv",
	request = "attach",
	pid = require("dap.utils").pick_process,
	stopOnEntry = false,
	runInTerminal = false,
}

dap.configurations.go = { dlv }

local dapui = require('dapui');
dapui.setup();
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<F5>", function() dap.continue() end);
vim.keymap.set("n", "<S-F5>", function() dap.terminate() end);
vim.keymap.set("n", "<F10>", function() dap.step_over() end);
vim.keymap.set("n", "<F11>", function() dap.step_into() end);
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle [B]reakpoint"});
