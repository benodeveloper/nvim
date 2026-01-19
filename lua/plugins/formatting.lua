return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>tf",
      function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          Snacks.notify.info("Autoformat Enabled")
        else
          vim.g.disable_autoformat = true
          Snacks.notify.warn("Autoformat Disabled")
        end
      end,
      desc = "Toggle Autoformat",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = function(bufnr)
      -- Check the global toggle
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
