--- Root path utility module for Neovim plugins/configs.
-- Provides helpers for detecting, normalizing, and resolving filesystem paths,
-- especially useful for project root discovery.

local M = setmetatable({}, {
  --- Allow calling the module directly, which delegates to M.get(...)
  __call = function(m, ...)
    return m.get(...)
  end,
})

--- Detector function for current working directory.
-- @return table: A table containing the current working directory as string.
function M.detectors.cwd()
  return { vim.uv.cwd() }
end

--- Get the normalized absolute path of the current working directory.
-- Uses realpath to resolve symlinks and normalizes the result.
-- @return string: The normalized absolute path or an empty string if failed.
function M.cwd()
  return M.realpath(vim.uv.cwd()) or ""
end

--- Resolve a path to its real (absolute) filesystem location and normalize it.
-- Uses uv.fs_realpath to resolve symlinks.
-- @param path string: The input path.
-- @return string|nil: The normalized, real path. Nil if input is empty or invalid.
function M.realpath(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.uv.fs_realpath(path) or path
  return M.norm(path)
end

--- Normalize a file path for consistent internal usage.
-- Resolves redundant segments, unifies path separators,
-- optionally makes paths absolute and/or resolves symlinks.
-- @param path string: The input file path to normalize.
-- @param opts table|nil: Optional settings:
--   - absolute (boolean): If true, convert to absolute path (default: false).
--   - resolve_symlinks (boolean): If true, resolve symlinks (default: false).
-- @return string|nil: The normalized path, or nil if input is invalid.
function M.norm(path, opts)
  opts = opts or {}

  -- Return nil for empty or invalid input
  if not path or path == "" then
    return nil
  end

  -- Optionally resolve symlinks
  if opts.resolve_symlinks and vim.uv and vim.uv.fs_realpath then
    local real = vim.uv.fs_realpath(path)
    if real then path = real end
  end

  -- Optionally make path absolute
  if opts.absolute then
    -- If path is not absolute, prepend current working directory
    if not path:match("^/") and not path:match("^%a:[\\/]") then
      path = vim.fn.fnamemodify(path, ":p")
    end
  end

  -- Unify separators (use system's separator)
  local sep = package.config:sub(1, 1)
  path = path:gsub("[/\\]", sep)

  -- Remove redundant "./" and "../" segments
  local function clean(p)
    local parts = {}
    for part in string.gmatch(p, "[^"..sep.."]+") do
      if part == ".." then
        if #parts > 0 then
          table.remove(parts)
        end
      elseif part ~= "." and part ~= "" then
        table.insert(parts, part)
      end
    end
    return sep .. table.concat(parts, sep)
  end

  path = clean(path)

  return path
end

_G.RootUtil = M

return M
