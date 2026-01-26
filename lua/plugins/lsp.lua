return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer" },
      })

      -- Global Diagnostic Config (The "Helper" UI)
      vim.diagnostic.config({
        virtual_text = true,  -- Shows error message next to code
        signs = true,         -- Shows icons in the side column
        underline = true,     -- Underlines the actual bad code
        update_in_insert = false,
        severity_sort = true,
      })

      -- Register the Config
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            -- CRITICAL: This is what finds the unimported classes
            checkOnSave = { command = "clippy" },
            diagnostics = {
              enable = true,
              experimental = { enable = true }
            },
            -- This makes unused code look "faded"
            hover = { actions = { enable = true } },
            completion = {
              autoimport = { enable = true }, -- Crucial for auto-imports
              callable = { snippets = "fill_arguments" }, -- Adds () and arguments automatically
            },
          },
        },
      })

      vim.lsp.enable("rust_analyzer")
    end,
  },
}
