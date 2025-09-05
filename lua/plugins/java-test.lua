return {
    "nvim-neotest/neotest",
    dependencies = {
        "rcasia/neotest-java", -- The adapter for Java
    },
    config = function()
        require("neotest").setup({
            adapters = { require("neotest-java") },
            icons = {
                passed = "✅",
                failed = "❌",
                running = "⏳",
            },
        })
    end,
    -- Keymaps for neotest
    keys = {
        {
            "<leader>tt",
            function()
                require("neotest").run.run()
            end,
            desc = "Run Nearest Test",
        },
        {
            "<leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Run Tests in File",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle Test Summary",
        },
        {
            "<leader>td",
            function()
                require("neotest").run.run({ strategy = "dap" })
            end,
            desc = "Debug Nearest Test",
        },
    },
}
