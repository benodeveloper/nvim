return {
    {
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup({
                show_numbers = true, -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            })
        end,
    },
}
