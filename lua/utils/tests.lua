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
function M.create_test_file()
    local source_path = vim.fn.expand("%:p")
    local test_path
    local boilerplate = {}
    local class_name

    -- Check if we are already in a test file
    -- ✅ FIX: Use separate 'or' checks for each test file extension
    if
        source_path:match("%.test%.")
        or source_path:match("Test%.java$")
        or source_path:match("Test%.kt$")
        or source_path:match("Test%.php$")
    then
        print("Already in a test file.")
        return
    end

    -- Determine file type and generate paths/boilerplate based on the SOURCE file
    if source_path:match("%.java$") or source_path:match("%.kt$") then
        test_path = source_path:gsub("/src/main/", "/src/test/")
        test_path = test_path:gsub("(.+)%.java$", "%1Test.java"):gsub("(.+)%.kt$", "%1Test.kt")

        local test_dir = vim.fn.fnamemodify(test_path, ":h")
        class_name = vim.fn.fnamemodify(test_path, ":t:r")
        local package_match = test_dir:match("src/test/java/(.+)") or test_dir:match("src/test/kotlin/(.+)")
        local package_str = package_match and package_match:gsub("/", ".") or ""

        boilerplate = {
            "package " .. package_str .. ";",
            "",
            "import static org.junit.jupiter.api.Assertions.*;",
            "import org.junit.jupiter.api.Test;",
            "",
            "class " .. class_name .. " {",
            "",
            "    @Test",
            "    void testSomething() {",
            "        assertTrue(true);",
            "    }",
            "",
            "}",
        }
    elseif source_path:match("%.php$") then
        test_path = source_path:gsub("/app/", "/tests/Unit/")
        test_path = test_path:gsub("(.+)%.php$", "%1Test.php")

        class_name = vim.fn.fnamemodify(test_path, ":t:r")
        local package_path = test_path:match("tests/Unit/(.+)")
        local namespace = "Tests\\Unit\\"
            .. (package_path and package_path:gsub("/", "\\"):gsub(class_name .. "%.php$", "") or "")
        namespace = namespace:sub(1, -2)

        boilerplate = {
            "<?php",
            "",
            "namespace " .. namespace .. ";",
            "",
            "use Tests\\TestCase;",
            "",
            "class " .. class_name .. " extends TestCase",
            "{",
            "    /** @test */",
            "    public function it_does_something(): void",
            "    {",
            "        $this->assertTrue(true);",
            "    }",
            "}",
        }
    elseif
        source_path:match("%.tsx$")
        or source_path:match("%.jsx$")
        or source_path:match("%.ts$")
        or source_path:match("%.js$")
    then
        test_path = source_path:gsub("(.+)%.(tsx|jsx|ts|js)$", "%1.test.%2")

        class_name = vim.fn.fnamemodify(test_path, ":t:r")

        boilerplate = {
            "import { render, screen } from '@testing-library/react';",
            "import '@testing-library/jest-dom';",
            "",
            'describe("' .. class_name:gsub("%.test", "") .. '", () => {',
            '  it("should do something", () => {',
            "    // Test logic here",
            "  });",
            "});",
        }
    else
        print("Could not determine a test file path for this file type.")
        return
    end

    if vim.fn.filereadable(test_path) == 1 then
        print("Test file already exists. Opening it.")
        vim.cmd.edit(test_path)
        return
    end

    local test_dir = vim.fn.fnamemodify(test_path, ":h")
    vim.fn.mkdir(test_dir, "p")
    vim.fn.writefile(boilerplate, test_path)
    print("Created test file at: " .. test_path)
    vim.cmd.edit(test_path)
end

return M
