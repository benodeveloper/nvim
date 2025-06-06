return {
    "folke/snacks.nvim",
    search = false,
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            preset = {
                -- Used by the `header` section
                header = [[


                            ██████╗ ███████╗███╗   ██╗ ██████╗ ██████╗ ███████╗██╗   ██╗
                            ██╔══██╗██╔════╝████╗  ██║██╔═══██╗██╔══██╗██╔════╝██║   ██║
                            ██████╔╝█████╗  ██╔██╗ ██║██║   ██║██║  ██║█████╗  ██║   ██║
                            ██╔══██╗██╔══╝  ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ╚██╗ ██╔╝
                            ██████╔╝███████╗██║ ╚████║╚██████╔╝██████╔╝███████╗ ╚████╔╝ 
                            ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝  
                                                            
                                                                         ]],
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 0 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
                { section = "startup" },
            },
        },
        explorer = { enabled = true },
        -- indent = { enabled = false },
        -- input = { enabled = false },
        --
        -- statuscolumn = {
        --     left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        --     right = { "fold", "git" }, -- priority of signs on the right (high to low)
        --     folds = {
        --         open = false, -- show open fold icons
        --         git_hl = false, -- use Git Signs hl for fold icons
        --     },
        --     git = {
        --         -- patterns to match Git signs
        --         patterns = { "GitSign", "MiniDiffSign" },
        --     },
        --     refresh = 50,
        -- },
        input = {
            win = {
                position = "bottom", -- Options: 'top', 'bottom', 'left', 'right'
                -- Additional customization options
            },
            -- Other input configurations
        },
        picker = { enabled = true },
        notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- scope = { enabled = true },
        -- scroll = { enabled = true },
        statuscolumn = { enabled = true },
        -- words = { enabled = true },
        --
        image = {
            formats = {
                "svg",
                "png",
                "jpg",
                "jpeg",
                "gif",
                "bmp",
                "webp",
                "tiff",
                "heic",
                "avif",
                "mp4",
                "mov",
                "avi",
                "mkv",
                "webm",
                "pdf",
            },
            force = false, -- try displaying the image, even if the terminal does not support it
            doc = {
                -- enable image viewer for documents
                -- a treesitter parser must be available for the enabled languages.
                enabled = true,
                -- render the image inline in the buffer
                -- if your env doesn't support unicode placeholders, this will be disabled
                -- takes precedence over `opts.float` on supported terminals
                inline = true,
                -- render the image in a floating window
                -- only used if `opts.inline` is disabled
                float = true,
                max_width = 80,
                max_height = 40,
                -- Set to `true`, to conceal the image text when rendering inline.
                -- (experimental)
                ---@param lang string tree-sitter language
                ---@param type snacks.image.Type image type
                conceal = function(lang, type)
                    -- only conceal math expressions
                    return type == "math"
                end,
            },
            img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
            -- window options applied to windows displaying image buffers
            -- an image buffer is a buffer with `filetype=image`
            wo = {
                wrap = false,
                number = false,
                relativenumber = false,
                cursorcolumn = false,
                signcolumn = "no",
                foldcolumn = "0",
                list = false,
                spell = false,
                statuscolumn = "",
            },
            cache = vim.fn.stdpath("cache") .. "/snacks/image",
            debug = {
                request = false,
                convert = false,
                placement = false,
            },
            -- env = {},
            -- icons used to show where an inline image is located that is
            -- rendered below the text.
            icons = {
                math = "󰪚 ",
                chart = "󰄧 ",
                image = " ",
            },
            ---@class snacks.image.convert.Config
            convert = {
                notify = true, -- show a notification on error
                ---@type snacks.image.args
                mermaid = function()
                    local theme = vim.o.background == "light" and "neutral" or "dark"
                    return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
                end,
                ---@type table<string,snacks.image.args>
                magick = {
                    default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
                    vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
                    math = { "-density", 192, "{src}[0]", "-trim" },
                    pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
                },
            },
            math = {
                enabled = true, -- enable math expression rendering
                -- in the templates below, `${header}` comes from any section in your document,
                -- between a start/end header comment. Comment syntax is language-specific.
                -- * start comment: `// snacks: header start`
                -- * end comment:   `// snacks: header end`
                typst = {
                    tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
                },
                latex = {
                    font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
                    -- for latex documents, the doc packages are included automatically,
                    -- but you can add more packages here. Useful for markdown documents.
                    packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
                    tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
                },
            },
        },
    },
}
