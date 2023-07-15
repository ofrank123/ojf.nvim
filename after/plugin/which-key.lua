local wk = require("which-key").setup({
    window = {
        border = "single"
    }
})

require'which-key'.register({
    f = "[F]ind",
    g = "[G]it",
    p = "[P]roject"
}, { prefix = "<leader>" })
