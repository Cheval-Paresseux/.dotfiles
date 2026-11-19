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
      base08 = p.blaster, -- errors, tags, deletions
      base09 = p.rust, -- numbers, constants
      base0A = p.gold, -- types, search
      base0B = p.sage, -- strings, additions
      base0C = p.dusk, -- escapes, regex
      base0D = p.sky, -- functions
      base0E = p.sun, -- keywords
      base0F = p.bone, -- delimiters, deprecated
    })
    vim.g.colors_name = "tatooine"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.sun, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.rust, bold = true })
    hl("Search", { fg = p.crust, bg = p.gold })
    hl("IncSearch", { fg = p.crust, bg = p.rust })
    hl("CurSearch", { fg = p.crust, bg = p.rust })

    -- No background: kitty's translucent glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.overlay0 })
    hl("FloatTitle", { fg = p.sun, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.duskBlue })
    hl("@variable.parameter", { fg = p.sand, italic = true })
    hl("@variable.builtin", { fg = p.blaster })
    hl("@property", { fg = p.duskBlue })
    hl("@module", { fg = p.duskBlue })
    hl("@constructor", { fg = p.bone })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.bone })
    hl("@tag", { fg = p.sun })
    hl("@tag.attribute", { fg = p.gold })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })
    hl("SnacksDashboardHeader", { fg = p.sun })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.blaster, Warn = p.gold, Info = p.sky, Hint = p.bone, Ok = p.sage }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.sage })
    hl("GitSignsChange", { fg = p.gold })
    hl("GitSignsDelete", { fg = p.blaster })
    hl("DiffAdd", { bg = "#2a2e1c" })
    hl("DiffChange", { bg = "#33291a" })
    hl("DiffDelete", { bg = "#38201a" })
    hl("DiffText", { bg = "#4d3d22" })
  end,
}
