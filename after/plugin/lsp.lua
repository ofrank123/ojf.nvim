-- [[ Configure LSP ]]
require('fidget').setup({})
require("mason").setup()

-- Border config
local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = _border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = _border
    }
)

vim.diagnostic.config{
    float={border=_border}
}

-- Diagnostic config
vim.diagnostic.config({
    virtual_text = false
})

function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            return
        end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
        scope = "cursor",
        focusable = false,
        close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
        },
    })
end

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
})

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    vim.api.nvim_command('autocmd CursorHold <bufnr> lua vim.lsp.util.show_line_diagnostics()')

    local nmap_lsp = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap_lsp('<leader>pr', vim.lsp.buf.rename, '[R]ename in [Project]')
    nmap_lsp('<leader>.', vim.lsp.buf.code_action, 'Code Action')

    nmap_lsp('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap_lsp('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap_lsp('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap_lsp('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap_lsp('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap_lsp('<leader>pt', vim.lsp.buf.type_definition, '[T]ype definition in [P]roject')

    -- See `:help K` for why this keymap
    nmap_lsp('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap_lsp('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    clangd = {},
    gopls = {},
    rust_analyzer = {},
    tsserver = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- neovim lua setup
require("neodev").setup({})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    formatting = {
        format = function(_, vim_item)
            if (string.len(vim_item.abbr) > 50) then
                vim_item.abbr = string.sub(vim_item.abbr, 1, 47) .. "...";
            end
            return vim_item;
        end
    },
    window = {
        completion = {
            border = "single",
        },
        documentation = {
            border = "single",
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}


