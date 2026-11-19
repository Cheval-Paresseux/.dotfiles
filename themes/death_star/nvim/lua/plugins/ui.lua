return {
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- Plugins asking for nvim-web-devicons get mini.icons instead
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local p = require("config.palette")
      local function mode(color)
        return {
          a = { fg = p.crust, bg = color, gui = "bold" },
          b = { fg = color, bg = p.surface0 },
          c = { fg = p.subtext0, bg = p.crust },
        }
      end
      return {
        options = {
          theme = {
            normal = mode(p.saber),
            insert = mode(p.reactor),
            visual = mode(p.imperialBlue),
            replace = mode(p.lightning),
            command = mode(p.alarm),
            inactive = mode(p.overlay0),
          },
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = "",
          disabled_filetypes = { statusline = { "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = " ●", readonly = " 󰌾", unnamed = "" } },
          },
          lualine_x = {
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          },
          lualine_y = { "progress", "location" },
          lualine_z = { { "datetime", style = "%H:%M" } },
        },
        extensions = { "lazy", "man", "quickfix", "trouble" },
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
    },
    opts = {
      highlights = { fill = { bg = require("config.palette").base } },
      options = {
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        separator_style = { "", "" },
        indicator = { style = "none" },
        show_buffer_close_icons = false,
        offsets = { { filetype = "snacks_layout_box" } },
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      routes = {
        -- Write messages ("12L, 340B written") and undo messages go to the small corner view
        {
          filter = {
            event = "msg_show",
            any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } },
          },
          view = "mini",
        },
      },
      presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
      views = {
        cmdline_popup = { border = { style = "single" } },
        popupmenu = { border = { style = "single" } },
        hover = { border = { style = "single" } },
      },
    },
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      win = { border = "single" },
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>sn", group = "noice" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps" },
    },
  },
}
