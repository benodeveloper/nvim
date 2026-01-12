return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- Optional but recommended
  },
  opts = {
    cmdline = {
      view = "cmdline_popup", -- This puts the : command in the middle!
    },
    messages = {
      enabled = true,
      view = "mini", -- Keeps annoying messages in the corner
    },
    popupmenu = {
      enabled = true, -- Use a fancy UI for the tab-completion menu
    },
  },
}
