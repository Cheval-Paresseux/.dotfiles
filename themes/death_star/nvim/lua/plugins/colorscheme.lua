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
      base08 = p.lightning, -- errors, tags, deletions
      base09 = p.fire, -- numbers, constants
      base0A = p.alarm, -- types, search
      base0B = p.reactor, -- strings, additions
      base0C = p.hologram, -- escapes, regex
      base0D = p.imperialBlue, -- functions
      base0E = p.saber, -- keywords
      base0F = p.steel, -- delimiters, deprecated
    })
    vim.g.colors_name = "death_star"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.saber, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.fire, bold = true })
    hl("Search", { fg = p.crust, bg = p.alarm })
    hl("IncSearch", { fg = p.crust, bg = p.fire })
    hl("CurSearch", { fg = p.crust, bg = p.fire })

    -- Floats and sidebars share the editor background (it also fills kitty's padding)
    hl("NormalFloat", { fg = p.text, bg = p.base })
    hl("FloatBorder", { fg = p.blood, bg = p.base })
    hl("FloatTitle", { fg = p.saber, bg = p.base, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.steel })
    hl("@variable.parameter", { fg = p.subtext1, italic = true })
    hl("@variable.builtin", { fg = p.saber })
    hl("@property", { fg = p.steel })
    hl("@module", { fg = p.steel })
    hl("@constructor", { fg = p.hologram })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.hologram })
    hl("@tag", { fg = p.saber })
    hl("@tag.attribute", { fg = p.alarm })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })
    hl("SnacksDashboardHeader", { fg = p.saber })

    -- Diagnostics and git
    for name, color in pairs({
      Error = p.lightning,
      Warn = p.alarm,
      Info = p.imperialBlue,
      Hint = p.hologram,
      Ok = p.reactor,
    }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.reactor })
    hl("GitSignsChange", { fg = p.alarm })
    hl("GitSignsDelete", { fg = p.lightning })
    hl("DiffAdd", { bg = "#1c2a1d" })
    hl("DiffChange", { bg = "#2c2616" })
    hl("DiffDelete", { bg = "#251d33" })
    hl("DiffText", { bg = "#463a1c" })
  end,
}
