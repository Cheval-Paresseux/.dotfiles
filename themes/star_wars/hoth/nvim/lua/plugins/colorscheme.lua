return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local p = require("config.palette")
    vim.o.background = "light"
    require("base16-colorscheme").setup({
      base00 = p.base, -- background
      base01 = p.mantle, -- status line, popups
      base02 = p.surface1, -- selection
      base03 = p.overlay0, -- comments
      base04 = p.overlay1, -- line numbers
      base05 = p.text, -- text
      base06 = p.subtext1,
      base07 = p.text,
      base08 = p.vader, -- errors, tags, deletions
      base09 = p.violet, -- numbers, constants
      base0A = p.beacon, -- types, search
      base0B = p.tundra, -- strings, additions
      base0C = p.glacier, -- escapes, regex
      base0D = p.saber, -- functions
      base0E = p.rebel, -- keywords
      base0F = p.steel, -- delimiters, deprecated
    })
    vim.g.colors_name = "hoth"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.rebel, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.violet, bold = true })
    hl("Search", { fg = p.crust, bg = p.beacon })
    hl("IncSearch", { fg = p.crust, bg = p.violet })
    hl("CurSearch", { fg = p.crust, bg = p.violet })

    -- No background: kitty's translucent glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.overlay0 })
    hl("FloatTitle", { fg = p.rebel, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.frost })
    hl("@variable.parameter", { fg = p.hide, italic = true })
    hl("@variable.builtin", { fg = p.vader })
    hl("@property", { fg = p.frost })
    hl("@module", { fg = p.frost })
    hl("@constructor", { fg = p.steel })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.steel })
    hl("@tag", { fg = p.rebel })
    hl("@tag.attribute", { fg = p.beacon })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })
    hl("SnacksDashboardHeader", { fg = p.rebel })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.vader, Warn = p.beacon, Info = p.saber, Hint = p.steel, Ok = p.tundra }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.tundra })
    hl("GitSignsChange", { fg = p.beacon })
    hl("GitSignsDelete", { fg = p.vader })
    hl("DiffAdd", { bg = "#d9ecd5" })
    hl("DiffChange", { bg = "#f1e8cc" })
    hl("DiffDelete", { bg = "#f4d9db" })
    hl("DiffText", { bg = "#e6d49c" })
  end,
}
