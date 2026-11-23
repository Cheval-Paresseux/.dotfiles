-- Language servers come from nvim-lspconfig's lsp/ configs, installed through Mason.
-- Files in lua/plugins/lang/ add their own servers, tools, formatters and linters to the opts below.

return {
  {
    "mason-org/mason.nvim",
    lazy = false, -- adds Mason's bin directory to PATH for the other plugins
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "stylua", "shfmt", "tree-sitter-cli" }, -- tools that are not language servers
    },
    config = function(_, opts)
      require("mason").setup()
      local registry = require("mason-registry")
      registry.refresh(function()
        for _, name in ipairs(opts.ensure_installed) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok and not pkg:is_installed() then pkg:install() end
        end
      end)
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      -- server name = settings merged over nvim-lspconfig's defaults ({} keeps the defaults)
      servers = {
        lua_ls = {},
      },
    },
    config = function(_, opts)
      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
        callback = function(event)
          local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc }) end
          map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("n", "gr", function() Snacks.picker.lsp_references() end, "References")
          map("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
          map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")
          map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")
        end,
      })

      for name, config in pairs(opts.servers) do
        if next(config) then vim.lsp.config(name, config) end
      end

      -- Installs the listed servers; every installed server is then enabled automatically
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(opts.servers),
        automatic_enable = { exclude = { "stylua" } }, -- stylua is used as a formatter through conform
      })
    end,
  },

  -- Formatting, on save and with <leader>cf (toggle with <leader>uf)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ lsp_format = "fallback" }) end,
        mode = { "n", "x" },
        desc = "Format",
      },
      {
        "<leader>uf",
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end,
        desc = "Toggle Format on Save",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        fish = { "fish_indent" },
      },
      format_on_save = function()
        if not vim.g.disable_autoformat then return { timeout_ms = 500, lsp_format = "fallback" } end
      end,
    },
  },

  -- Linters that are not language servers
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    opts = {
      linters_by_ft = {
        fish = { "fish" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("user_lint", { clear = true }),
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
