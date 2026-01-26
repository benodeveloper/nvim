return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*', -- Use a release tag to ensure stability
    opts = {
      -- 'default' for standard vim keymaps, 'super-tab' for a VS Code feel
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- Sources define where your suggestions come from
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Experimental but highly recommended for Rust
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
}
