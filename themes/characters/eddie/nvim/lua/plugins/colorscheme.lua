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
      base0A = p.mustard, -- types, search
      base0B = p.moss, -- strings, additions
      base0C = p.lichen, -- escapes, regex
      base0D = p.lovat, -- functions
      base0E = p.scarlet, -- keywords
      base0F = p.leather, -- delimiters, deprecated
    })
    vim.g.colors_name = "eddie"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.scarlet, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.paleMustard, bold = true })
    hl("Search", { fg = p.crust, bg = p.mustard })
    hl("IncSearch", { fg = p.oatmeal, bg = p.scarlet })
    hl("CurSearch", { fg = p.oatmeal, bg = p.scarlet })

    hl("NormalFloat", { fg = p.text, bg = p.mantle })
    hl("FloatBorder", { fg = p.leather, bg = p.mantle })
    hl("FloatTitle", { fg = p.scarlet, bg = p.mantle, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.paleLovat })
    hl("@variable.parameter", { fg = p.saddle, italic = true })
    hl("@variable.builtin", { fg = p.claret })
    hl("@property", { fg = p.paleLovat })
    hl("@module", { fg = p.paleLovat })
    hl("@constructor", { fg = p.lichen })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.lichen })
    hl("@tag", { fg = p.scarlet })
    hl("@tag.attribute", { fg = p.saddle })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay1, italic = true })

    -- Dashboard: the arms in scarlet and leather, the keys like an estate ledger
    hl("SnacksDashboardHeader", { fg = p.scarlet })
    hl("SnacksDashboardIcon", { fg = p.leather })
    hl("SnacksDashboardDesc", { fg = p.subtext1 })
    hl("SnacksDashboardKey", { fg = p.mustard, bold = true })
    hl("SnacksDashboardFooter", { fg = p.overlay1, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.claret, Warn = p.mustard, Info = p.lovat, Hint = p.lichen, Ok = p.moss }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.moss })
    hl("GitSignsChange", { fg = p.mustard })
    hl("GitSignsDelete", { fg = p.claret })
    hl("DiffAdd", { bg = "#232a17" })
    hl("DiffChange", { bg = "#2c2614" })
    hl("DiffDelete", { bg = "#2e1820" })
    hl("DiffText", { bg = "#4a3d1c" })
  end,
}
