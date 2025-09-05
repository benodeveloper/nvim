return {
    "hrsh7th/nvim-cmp",
    enabled = true,
    version = false, -- last release is way too old
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {

        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "mfussenegger/nvim-jdtls",
        "octaltree/cmp-look",
        "L3MON4D3/cmp-luasnip-choice",
        "chrisgrieser/cmp-nerdfont",
        "MeanderingProgrammer/render-markdown.nvim",
        "ray-x/cmp-treesitter",
        "saadparwaiz1/cmp_luasnip",
        "zbirenbaum/copilot-cmp",
        "lukas-reineke/cmp-rg",
        "prabirshrestha/vim-lsp",
        "SergioRibera/cmp-dotenv",
        "jcha0713/cmp-tw2css",
        "dmitmel/cmp-vim-lsp",
        "roginfarrer/cmp-css-variables",
        "PhilippFeO/cmp-help-tags",
        "JMarkin/cmp-diag-codes",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
    config = function()
        require("luasnip/loaders/from_lua").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip/loaders/from_vscode").lazy_load()

        vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }

        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

        local kind_icons = {
            Class = " ",
            Color = " ",
            Comment = "//",
            Constant = " ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = "",
            Field = "󰄶 ",
            File = " ",
            Folder = " ",
            Function = "ƒ ",
            Interface = " ",
            Keyword = "󰌆 ",
            Method = " ",
            Module = "󰏗 ",
            Operator = "󰆕 ",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            String = "󱌯 ",
            Struct = " ",
            Text = " ",
            TypeParameter = "󰅲 ",
            Unit = " ",
            Value = "󰎠 ",
            Variable = "󰀫",
        }

        local luasnip = require("luasnip")
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                    winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                },
                documentation = {
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                    winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                },
            },
            view = {
                entries = {
                    name = "custom",
                    selection_order = "near_cursor",
                    follow_cursor = true,
                },
            },
            mapping = cmp.mapping.preset.insert({
                -- ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
                -- ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
                -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                -- ['<CR>'] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         if luasnip.expandable() then
                --             luasnip.expand()
                --         else
                --             cmp.confirm({
                --                 select = true,
                --             })
                --         end
                --     else
                --         fallback()
                --     end
                -- end),
                ["<C-CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "copilot" },
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" },
                { name = "luasnip_choice" },
                { name = "render-markdown" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lua" },
                { name = "treesitter" },
                { name = "vim_lsp" },
                { name = "dotenv" },
                { name = "diag-codes" },
                { name = "css-variables" },
                { name = "tw2css" },
                {
                    name = "cmp_help_tags", -- '_' not '-' 😯
                    -- recommended to avoid cluttering
                    keyword_length = 5,
                },
                {
                    name = "look",
                    keyword_length = 3,
                    option = {
                        convert_case = true,
                        loud = true,
                    },
                    max_item_count = 5,
                },
                {
                    name = "rg",
                    -- Try it when you feel cmp performance is poor
                    -- keyword_length = 3
                },
                { name = "nerdfont" },
            }),
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    -- Kind icons
                    -- This concatenates the icons with the name of the item kind
                    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                    -- Trim text function
                    function trim(text)
                        local max = 40
                        if text and text:len(1, max) > max then
                            text = text:sub(1, max) .. "..."
                        end
                        return text
                    end
                    vim_item.abbr = trim(vim_item.abbr)
                    -- Source
                    vim_item.menu = ({
                        copilot = "( Copilot )",
                        nvim_lsp = "( LSP )",
                        nvim_lsp_signature_help = "( Signature )",
                        luasnip = "( LuaSnip )",
                        buffer = "( Buffer )",
                        path = "( Path )",
                        nvim_lua = "( Lua )",
                        treesitter = "( Treesitter )",
                        look = "( Look )",
                        cmdline = "( CMD )",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sorting = {
                comparators = {
                    cmp.config.compare.score,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.length,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.order,
                },
            },
            experimental = {
                ghost_text = true,
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path", group_index = 1 },
                { name = "cmdline", group_index = 2 },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end,
    main = "lazyvim.util.cmp",
}
