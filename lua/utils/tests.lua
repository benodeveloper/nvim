-- lua/utils/tests.lua (Corrected Version)
local M = {}

local function get_current_function_name()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    for i = cursor_line, 1, -1 do
        local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
        if line:match("@Test") then
            for j = i, i + 3 do
                local func_line = vim.api.nvim_buf_get_lines(0, j, j + 1, false)[1]
                local match = func_line:match("void%s+([%w_]+)%s*%(") -- Java
                    or func_line:match("fun%s+`?([%w_]+)`?%s*%(") -- Kotlin
                if match then
                    return match
                end
            end
        end
    end
    return nil
end

function M.run_gradle_test(mode)
    local file_path = vim.fn.expand("%:p")

    local class_path = file_path:match("src/test/java/(.+)") or file_path:match("src/test/kotlin/(.+)")

    if not class_path then
        print("Error: Could not determine test class path. Path did not match expected structure.")
        return
    end

    local fqcn = class_path:gsub("/", "."):gsub(".java$", ""):gsub(".kt$", "")
    local test_filter = fqcn

    if mode == "function" then
        local func_name = get_current_function_name()
        if func_name then
            test_filter = fqcn .. "." .. func_name
        else
            print("Warning: Could not find test function. Running tests for the whole file instead.")
        end
    end

    local command = string.format('./gradlew test --tests "%s"', test_filter)

    local term = require("toggleterm.terminal").Terminal:new({
        cmd = command,
        dir = vim.fn.getcwd(),
        direction = "float",
        close_on_exit = false,
        on_open = function(t)
            vim.api.nvim_buf_set_keymap(t.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(t.bufnr, "t", "<esc>", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
    })
    term:toggle()
    print("Running command: " .. command)
end

return M
