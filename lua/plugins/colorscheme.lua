return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- High priority to load before other plugins
    lazy = false,    -- Load immediately
    config = function()
      require('onedark').setup({
        -- Choose your flavor: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'poly'
        style = 'darker', 
        transparent = true,  -- If you want your terminal background to show through
        term_colors = true,   -- Use onedark colors for the built-in terminal
        ending_tildes = false, -- Hide the ~ at the end of the buffer
        
        -- You can customize specific colors for Snacks.nvim here if needed
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
      })
      require('onedark').load()
    end,
  },
}
