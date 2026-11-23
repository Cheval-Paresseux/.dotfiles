return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local p = require("config.palette")
    require("base16-colorscheme").setup({
      base00 = p.base, -- background
      base01 = p.mantle, -- status line, popups
      base02 = p.surface1, -- selection
      base03 = p.overlay0, -- comments
      base04 = p.overlay1, -- line numbers
      base05 = p.text, -- text
      base06 = p.subtext1,
      base07 = p.text,
      base08 = p.claret, -- errors, tags, deletions
      base09 = p.heather, -- numbers, constants
      base0A = p.cognac, -- types, search
      base0B = p.sage, -- strings, additions
      base0C = p.verdigris, -- escapes, regex
      base0D = p.slate, -- functions
      base0E = p.gold, -- keywords
      base0F = p.oldGold, -- delimiters, deprecated
    })
    vim.g.colors_name = "eddie"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.gold, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.paleGold, bold = true })
    hl("Search", { fg = p.crust, bg = p.cognac })
    hl("IncSearch", { fg = p.crust, bg = p.paleGold })
    hl("CurSearch", { fg = p.crust, bg = p.paleGold })

    -- No background: kitty's smoked glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.oldGold })
    hl("FloatTitle", { fg = p.gold, bold = true, italic = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.lightSlate })
    hl("@variable.parameter", { fg = p.camel, italic = true })
    hl("@variable.builtin", { fg = p.claret })
    hl("@property", { fg = p.lightSlate })
    hl("@module", { fg = p.lightSlate })
    hl("@constructor", { fg = p.verdigris })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.verdigris })
    hl("@tag", { fg = p.gold })
    hl("@tag.attribute", { fg = p.paleGold })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay1, italic = true })

    -- Dashboard: the glass in gold, the keys like a menu
    hl("SnacksDashboardHeader", { fg = p.gold })
    hl("SnacksDashboardIcon", { fg = p.oldGold })
    hl("SnacksDashboardDesc", { fg = p.subtext1, italic = true })
    hl("SnacksDashboardKey", { fg = p.paleGold, bold = true })
    hl("SnacksDashboardFooter", { fg = p.overlay1, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.claret, Warn = p.cognac, Info = p.slate, Hint = p.verdigris, Ok = p.sage }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.sage })
    hl("GitSignsChange", { fg = p.cognac })
    hl("GitSignsDelete", { fg = p.claret })
    hl("DiffAdd", { bg = "#1a2a1e" })
    hl("DiffChange", { bg = "#2a2616" })
    hl("DiffDelete", { bg = "#2c1719" })
    hl("DiffText", { bg = "#4a4024" })
  end,
}
