return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    terminal = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
 ██████╗ ███████╗███╗  ██╗ ██████╗ ██████╗ ███████╗██╗   ██╗
 ██╔══██╗██╔════╝████╗ ██║██╔═══██╗██╔══██╗██╔════╝██║   ██║
 ██████╔╝█████╗  ██╔██╗ ██║██║   ██║██║  ██║█████╗  ██║   ██║
 ██╔══██╗██╔══╝  ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ╚██╗ ██╔╝
 ██████╔╝███████╗██║ ╚████║╚██████╔╝██████╔╝███████╗ ╚████╔╝ 
 ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝ ]],
      },
      sections = {
        { section = "header", hl = "SnacksDashboardHeader" },
        { section = "keys", gap = 0 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
