return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "light"
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
      base08 = p.crimson, -- errors, tags, deletions
      base09 = p.plum, -- numbers, constants
      base0A = p.ochre, -- types, search
      base0B = p.bamboo, -- strings, additions
      base0C = p.celadon, -- escapes, regex
      base0D = p.indigo, -- functions
      base0E = p.sun, -- keywords
      base0F = p.steel, -- delimiters, deprecated
    })
    vim.g.colors_name = "mugen"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.sun, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.sun, bold = true, underline = true })
    hl("Search", { fg = p.base, bg = p.ochre })
    hl("IncSearch", { fg = p.base, bg = p.sun })
    hl("CurSearch", { fg = p.base, bg = p.sun })

    -- Floats and sidebars share the editor background (it also fills kitty's padding)
    hl("NormalFloat", { fg = p.text, bg = p.base })
    hl("FloatBorder", { fg = p.text, bg = p.base })
    hl("FloatTitle", { fg = p.sun, bg = p.base, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.steel })
    hl("@variable.parameter", { fg = p.wood, italic = true })
    hl("@variable.builtin", { fg = p.crimson })
    hl("@property", { fg = p.steel })
    hl("@module", { fg = p.steel })
    hl("@constructor", { fg = p.celadon })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.celadon })
    hl("@tag", { fg = p.sun })
    hl("@tag.attribute", { fg = p.ochre })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })
    hl("SnacksDashboardHeader", { fg = p.sun })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.crimson, Warn = p.ochre, Info = p.indigo, Hint = p.celadon, Ok = p.bamboo }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.bamboo })
    hl("GitSignsChange", { fg = p.ochre })
    hl("GitSignsDelete", { fg = p.crimson })
    hl("DiffAdd", { bg = "#dde6cf" })
    hl("DiffChange", { bg = "#efe2c4" })
    hl("DiffDelete", { bg = "#f0d3d3" })
    hl("DiffText", { bg = "#e4cc95" })
  end,
}
