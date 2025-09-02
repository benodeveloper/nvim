local function setup_java_boilerplate()
    -- Only run if the buffer is empty
    if vim.fn.line("$") > 1 or #vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] > 0 then
        return
    end

    -- Get file path and determine class name
    local file_path = vim.api.nvim_buf_get_name(0)
    local class_name = vim.fn.fnamemodify(file_path, ":t:r")

    -- Determine package name from the file path
    local package_str = ""
    local package_match = file_path:match("src/main/java/(.+)")
    if package_match then
        local package_dir = vim.fn.fnamemodify(package_match, ":h")
        if package_dir ~= "." then
            package_str = package_dir:gsub("/", ".")
        end
    end

    -- Create the boilerplate content
    local boilerplate = {
        "package " .. package_str .. ";",
        "",
        "public class " .. class_name .. " {",
        "     ", -- Indented line for the cursor
        "}",
    }

    -- Insert the content into the new buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, false, boilerplate)

    -- Move the cursor inside the class body
    vim.api.nvim_win_set_cursor(0, { 4, 4 })
end

-- Create an autocommand group to ensure it's cleared on reload
local java_template_group = vim.api.nvim_create_augroup("JavaBoilerplate", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufEnter" }, {
    group = java_template_group,
    pattern = "*.java",
    callback = setup_java_boilerplate,
})
