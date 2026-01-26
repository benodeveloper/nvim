return {
  {
    "the-coding-doggo/batman.nvim",
    lazy = false, 
    priority = 1000, 
    config = function()
      require("batman").setup({
        theme = "joker_night",
         -- transparent_background = true,
      })
      vim.cmd("colorscheme batman")
    end,
  },
}
