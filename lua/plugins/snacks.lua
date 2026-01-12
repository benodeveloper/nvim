return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true }, 
    notifier = { enabled = true },
    picker = {enabled = true},
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
  },
}
