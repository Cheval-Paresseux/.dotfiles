return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt fuzzy matcher
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = { border = "rounded", draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
      },
      signature = { window = { border = "rounded" } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      cmdline = {
        keymap = { preset = "cmdline", ["<Right>"] = false, ["<Left>"] = false },
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = function() return vim.fn.getcmdtype() == ":" end },
          ghost_text = { enabled = true },
        },
      },
    },
  },

  -- Neovim API completion and types when editing this config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = { modes = { insert = true, command = true, terminal = false } },
  },

  -- Extra a/i text objects: f function, c class, o block, u call, a argument, q quote, b bracket, g buffer
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" },
          u = ai.gen_spec.function_call(),
          g = function()
            local last = vim.fn.line("$")
            return { from = { line = 1, col = 1 }, to = { line = last, col = math.max(#vim.fn.getline(last), 1) } }
          end,
        },
      }
    end,
  },

  -- Better commentstring for embedded languages (gc / gcc are built into Neovim)
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
}
