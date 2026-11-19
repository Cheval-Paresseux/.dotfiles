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
      base08 = p.red, -- errors, tags, deletions
      base09 = p.orange, -- numbers, constants
      base0A = p.yellow, -- types, search
      base0B = p.green, -- strings, additions
      base0C = p.sky, -- escapes, regex
      base0D = p.blue, -- functions
      base0E = p.aqua, -- keywords
      base0F = p.mist, -- delimiters, deprecated
    })
    vim.g.colors_name = "base"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.aqua, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.orange, bold = true })
    hl("Search", { fg = p.crust, bg = p.yellow })
    hl("IncSearch", { fg = p.crust, bg = p.orange })
    hl("CurSearch", { fg = p.crust, bg = p.orange })

    -- Floats and sidebars share the editor background (it also fills kitty's padding)
    hl("NormalFloat", { fg = p.text, bg = p.base })
    hl("FloatBorder", { fg = p.overlay0, bg = p.base })
    hl("FloatTitle", { fg = p.aqua, bg = p.base, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.lightBlue })
    hl("@variable.parameter", { fg = p.sand, italic = true })
    hl("@variable.builtin", { fg = p.red })
    hl("@property", { fg = p.lightBlue })
    hl("@module", { fg = p.lightBlue })
    hl("@constructor", { fg = p.sky })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.sky })
    hl("@tag", { fg = p.aqua })
    hl("@tag.attribute", { fg = p.yellow })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.red, Warn = p.yellow, Info = p.blue, Hint = p.sky, Ok = p.green }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.green })
    hl("GitSignsChange", { fg = p.yellow })
    hl("GitSignsDelete", { fg = p.red })
    hl("DiffAdd", { bg = "#232e21" })
    hl("DiffChange", { bg = "#302c1e" })
    hl("DiffDelete", { bg = "#35222a" })
    hl("DiffText", { bg = "#4a4228" })
  end,
}
