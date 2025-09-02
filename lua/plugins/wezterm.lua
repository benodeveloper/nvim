return {
    -- wezterm config
    "willothy/wezterm.nvim",
    event = "UIEnter",
    config = function()
        local w = require("wezterm")
        w.setup({})

        -- Define a keymap to open a new vertical split
        vim.keymap.set("n", "<leader>wl", function()
            w.split_pane.horizontal({ domain = "CurrentPaneDomain" })
        end, { desc = "open new vertical terminal" })

        -- -- Define a keymap to open a new horizontal split
        -- vim.keymap.set("n", '<leader>t', function()
        --     w.split_pane.vertical({ domain = "CurrentPaneDomain" })
        -- end, { desc = 'open new vertical terminal' })

        -- Define a keymap to open a new horizontal split
        vim.keymap.set("n", "<leader>wb", function()
            w.split_pane.vertical({ domain = "CurrentPaneDomain" })
        end, { desc = "open new bottom terminal" })
    end,
}
