-- Rust: needs the toolchain from rustup (cargo, rustfmt, clippy)
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust", "ron" } },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              check = { command = "clippy" }, -- show clippy lints on save instead of plain cargo check
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { rust = { "rustfmt" } } },
  },

  -- Versions, features and docs for dependencies in Cargo.toml (completion, hover, code actions)
  {
    "Saecki/crates.nvim",
    tag = "stable",
    event = "BufRead Cargo.toml",
    opts = {
      lsp = { enabled = true, actions = true, completion = true, hover = true },
      popup = { border = "rounded" },
    },
  },
}
