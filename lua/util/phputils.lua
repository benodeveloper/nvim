local M = {}

M.sort_php_imports = function()
	local start_line, end_line
	local bufnr = vim.api.nvim_get_current_buf()

	-- Find first and last "use " lines
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for i, line in ipairs(lines) do
		if line:match("^use%s+") then
			if not start_line then
				start_line = i - 1 -- 0-based index
			end
			end_line = i - 1
		end
	end

	if not start_line or not end_line then
		print("No use statements found")
		return
	end

	-- Extract, sort, replace
	local import_lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)

	table.sort(import_lines, function(a, b)
		return #a < #b -- shortest line first
	end)

	vim.api.nvim_buf_set_lines(bufnr, start_line, end_line + 1, false, import_lines)
	print("PHP imports sorted by line length")
end

M.align_php_array = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local mode = vim.fn.mode()

	-- Get visual selection range
	local start_line, end_line
	if mode == "v" or mode == "V" then
		start_line = vim.fn.getpos("'<")[2] - 1
		end_line = vim.fn.getpos("'>")[2]
		-- Normalize (sometimes selection is backwards)
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
	else
		print("Select lines in visual mode first")
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

	-- Find max key length (before "=>")
	local max_key_len = 0
	for _, line in ipairs(lines) do
		local key = line:match("^%s*([^=]+)=>")
		if key then
			key = vim.trim(key)
			if #key > max_key_len then
				max_key_len = #key
			end
		end
	end

	-- Detect base indentation from first line
	local indent = lines[1]:match("^(%s*)") or ""

	-- Rebuild lines with padding
	for i, line in ipairs(lines) do
		local key, value = line:match("^(%s*[^=]+)=>(.*)$")
		if key and value then
			key = vim.trim(key)
			local spaces = string.rep(" ", max_key_len - #key + 1)
			lines[i] = string.format("%s%-s%s=>%s", indent, key, spaces, value)
		end
	end

	vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, lines)
	print("Aligned PHP array")
end

return M
