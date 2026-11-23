-- Python: basedpyright for types and navigation, ruff for linting, formatting and imports
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "requirements" } },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = { analysis = { typeCheckingMode = "standard" } },
          },
          -- Use the project's .venv when there is one
          before_init = function(_, config)
            local python = config.root_dir and config.root_dir .. "/.venv/bin/python"
            if python and vim.uv.fs_stat(python) then config.settings.python = { pythonPath = python } end
          end,
        },
        ruff = {
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false -- basedpyright gives better hover docs
          end,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { python = { "ruff_organize_imports", "ruff_format" } } },
  },
}
