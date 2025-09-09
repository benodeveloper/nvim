--- Boilerplate insertion utilities for new files in Neovim buffers.
-- Supports Java, PHP, and React (TSX/JSX) files.
--
-- Usage:
--   require("utils.boilerplate").setup_file_boilerplate()
-- Will automatically insert a language-appropriate template if buffer is empty.

local M = {}

--- Convert a string to PascalCase.
-- Useful for generating class/component names from filenames.
-- Splits by hyphen, underscore, or space, capitalizes each word.
-- @param str string: The input string.
-- @return string: The PascalCase version.
local function toPascalCase(str)
	local words = {}
	-- Split the string by delimiters like hyphen, underscore, or space
	for word in str:gmatch("[^-_%s]+") do
		table.insert(words, word)
	end
	for i, word in ipairs(words) do
		-- Capitalize the first letter and make the rest lowercase
		words[i] = word:sub(1, 1):upper() .. word:sub(2):lower()
	end
	return table.concat(words, "")
end

--- Insert boilerplate to a new buffer based on detected filetype.
-- Supported: Java, PHP, React (TSX/JSX)
-- Will NOT run if buffer is not empty.
function M.setup_file_boilerplate()
	-- Only run if the buffer is empty
	local total_lines = vim.fn.line("$")
	local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
	if total_lines > 1 or #first_line > 0 then
		return
	end

	local file_path = vim.api.nvim_buf_get_name(0)
	local boilerplate = {}
	local cursor_pos = {}

	--- Java Boilerplate ---
	if file_path:match("%.java$") then
		local class_name = vim.fn.fnamemodify(file_path, ":t:r")
		local package_str = ""
		local package_match = file_path:match("src/main/java/(.+)")
		if package_match then
			local package_dir = vim.fn.fnamemodify(package_match, ":h")
			if package_dir ~= "." then
				package_str = package_dir:gsub("/", ".")
			end
		end
		boilerplate = {
			"package " .. package_str .. ";",
			"",
			"public class " .. class_name .. " {",
			"    ", -- Indented line for the cursor
			"}",
		}
		cursor_pos = { 4, 5 } -- Line 4, 5th character (indented)

	--- PHP Boilerplate ---
	elseif file_path:match("%.php$") then
		local filename = vim.fn.fnamemodify(file_path, ":t")
		local class_name = vim.fn.fnamemodify(file_path, ":t:r")
		-- Only apply boilerplate if the filename starts with an uppercase letter (PSR standard for classes)
		if filename:sub(1, 1):match("%u") then
			local namespace_str = "App"
			-- Attempt to determine namespace from a common structure like 'app/...'
			local namespace_match = file_path:match("/app/(.+)")
			if namespace_match then
				local namespace_dir = vim.fn.fnamemodify(namespace_match, ":h")
				if namespace_dir ~= "." then
					namespace_str = "App\\" .. namespace_dir:gsub("/", "\\")
				end
			end
			boilerplate = {
				"<?php",
				"",
				"namespace " .. namespace_str .. ";",
				"",
				"class " .. class_name,
				"{",
				"    ", -- Indented line for the cursor
				"}",
			}
			cursor_pos = { 7, 5 } -- Line 7, 5th character (indented)
		end

	--- React Component Boilerplate (TSX/JSX) ---
	elseif file_path:match("%.tsx$") or file_path:match("%.jsx$") then
		local base_name = vim.fn.fnamemodify(file_path, ":t:r")
		local component_name = toPascalCase(base_name)
		local return_type = ""
		if file_path:match("%.tsx$") then
			return_type = ": React.ReactElement"
		end
		boilerplate = {
			"import React from 'react';",
			"",
			"const " .. component_name .. " = ()" .. return_type .. " => {",
			"  return (",
			"    <>",
			"      {/* Your component JSX here */}",
			"    </>",
			"  );",
			"};",
			"",
			"export default " .. component_name .. ";",
		}
		cursor_pos = { 6, 7 } -- Inside the empty fragment
	end

	-- If any boilerplate was generated, insert it and set the cursor
	if #boilerplate > 0 then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, boilerplate)
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end
end

return M
