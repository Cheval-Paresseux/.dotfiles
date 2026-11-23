return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "mason-org/mason.nvim" }, -- parsers are compiled with Mason's tree-sitter CLI
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "fish",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "qmljs",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      local missing = vim.tbl_filter(
        function(lang) return not vim.list_contains(ts.get_installed(), lang) end,
        opts.ensure_installed
      )
      if #missing > 0 then ts.install(missing) end

      -- Highlighting and indentation for every filetype with a parser
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(event)
          if pcall(vim.treesitter.start, event.buf) then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- ]f [f function, ]c [c class, ]a [a argument (capital letter: jump to end)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = { move = { set_jumps = true } },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
      local move = require("nvim-treesitter-textobjects.move")
      local objects = { f = "@function.outer", c = "@class.outer", a = "@parameter.inner" }
      for key, query in pairs(objects) do
        local function map(lhs, fn, desc)
          vim.keymap.set({ "n", "x", "o" }, lhs, function()
            if vim.wo.diff and key == "c" then
              return vim.cmd("normal! " .. lhs) -- keep ]c [c for diff changes
            end
            move[fn](query, "textobjects")
          end, { desc = desc })
        end
        local name = query:match("@(%w+)")
        map("]" .. key, "goto_next_start", "Next " .. name .. " Start")
        map("[" .. key, "goto_previous_start", "Prev " .. name .. " Start")
        map("]" .. key:upper(), "goto_next_end", "Next " .. name .. " End")
        map("[" .. key:upper(), "goto_previous_end", "Prev " .. name .. " End")
      end
    end,
  },

  -- Auto close and rename HTML/JSX tags
  { "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
