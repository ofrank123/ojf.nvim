local harpoon = require("harpoon")

harpoon:setup();

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end,
    { desc = "[H]arpoon menu" })
vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end,
    { desc = "[A]dd to harpoon list"})
vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end,
    { desc = "[R]emove from harpoon list"})
