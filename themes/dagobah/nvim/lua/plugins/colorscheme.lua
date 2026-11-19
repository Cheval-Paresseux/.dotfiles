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
      base08 = p.ember, -- errors, tags, deletions
      base09 = p.lichen, -- numbers, constants
      base0A = p.lantern, -- types, search
      base0B = p.moss, -- strings, additions
      base0C = p.bog, -- escapes, regex
      base0D = p.mist, -- functions
      base0E = p.saber, -- keywords
      base0F = p.bark, -- delimiters, deprecated
    })
    vim.g.colors_name = "dagobah"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.saber, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.lichen, bold = true })
    hl("Search", { fg = p.crust, bg = p.lantern })
    hl("IncSearch", { fg = p.crust, bg = p.lichen })
    hl("CurSearch", { fg = p.crust, bg = p.lichen })

    -- No background: kitty's translucent glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.overlay0 })
    hl("FloatTitle", { fg = p.saber, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.water })
    hl("@variable.parameter", { fg = p.reed, italic = true })
    hl("@variable.builtin", { fg = p.ember })
    hl("@property", { fg = p.water })
    hl("@module", { fg = p.water })
    hl("@constructor", { fg = p.bark })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.bark })
    hl("@tag", { fg = p.saber })
    hl("@tag.attribute", { fg = p.lantern })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })
    hl("SnacksDashboardHeader", { fg = p.saber })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.ember, Warn = p.lantern, Info = p.mist, Hint = p.bark, Ok = p.moss }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.moss })
    hl("GitSignsChange", { fg = p.lantern })
    hl("GitSignsDelete", { fg = p.ember })
    hl("DiffAdd", { bg = "#1d3020" })
    hl("DiffChange", { bg = "#2c2b1a" })
    hl("DiffDelete", { bg = "#36201c" })
    hl("DiffText", { bg = "#474224" })
  end,
}
