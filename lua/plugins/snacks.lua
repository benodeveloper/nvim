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
.______    _______ .__   __.   ______    _______   ___________    ____ 
|   _  \  |   ____||  \ |  |  /  __  \  |       \ |   ____\   \  /   / 
|  |_)  | |  |__   |   \|  | |  |  |  | |  .--.  ||  |__   \   \/   /  
|   _  <  |   __|  |  . `  | |  |  |  | |  |  |  ||   __|   \      /   
|  |_)  | |  |____ |  |\   | |  `--'  | |  '--'  ||  |____   \    /    
|______/  |_______||__| \__|  \______/  |_______/ |_______|   \__/     
                                                                         ]],
            },
            sections = {
                {
                    pane = 1,
                    { section = "header" },
                    { section = "keys", gap = 0 },
                },
                {
                    pane = 2,
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
                    { section = "startup" },
                },
            },
        },
        explorer = { enabled = true },
        -- indent = { enabled = false },
        -- input = { enabled = false },
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
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
}
