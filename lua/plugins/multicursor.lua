return {
    "jake-stewart/multicursor.nvim",
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        local set = vim.keymap.set

        -- Add cursors above/below
        set({"n", "v"}, "<C-Up>", function() mc.addCursor("k") end, { desc = "Add cursor above" })
        set({"n", "v"}, "<C-Down>", function() mc.addCursor("j") end, { desc = "Add cursor below" })

        -- Add cursor by matching word under cursor
        set({"n", "v"}, "<C-n>", function() mc.addCursor("*") end, { desc = "Add cursor at next match" })
        
        -- Skip the current match and move to the next
        set({"n", "v"}, "<C-x>", function() mc.skipCursor("*") end, { desc = "Skip match" })

        -- Standard Escape to clear cursors
        set("n", "<Esc>", function()
            if mc.hasCursors() then
                mc.clearCursors()
            else
                -- Standard clear search highlight
                vim.cmd("noh")
            end
        end, { desc = "Clear cursors or highlights" })
    end
}
