local homedir = os.getenv('HOME')
local servers = {

    gopls = {},
    rust_analyzer = {},
    powershell_es = {
        filetypes = { 'ps1' },
        --        bundle_path = '$HOME/.local/share/nvim/mason/packages/powershell-editor-services/',
        --        shell = 'pwsh',
        cmd =
        { 'pwsh', '-NoLogo', '-NoProfile', '-Command', homedir..'/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1', '-BundledModulesPath', homedir..'/.local/share/nvim/mason/packages/powershell-editor-services', '-FeatureFlags', '@()', '-AdditionalModules', '@()', '-HostName', '"My Client"', '-HostProfileId', "'myclient'", "-HostVersion 1.0.0", '-LogLevel', 'Normal' }
    },
    tsserver = {
    },
    html = { filetypes = { 'html', 'twig', 'hbs' } },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim' }, disable = { 'missing-fields' } }
        },
    },
}

local on_attach =
    function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        local function quickfix()
            vim.lsp.buf.code_action({
                filter = function(a) return a.isPreferred end,
                apply = true
            })
        end

        vim.keymap.set('n', '<leader>qf', quickfix, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            cmd = (servers[server_name] or {}).cmd
        }
    end,
}
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
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
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
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
        { name = 'path' },
    },
}
