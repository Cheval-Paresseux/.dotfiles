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
      base08 = p.ruby, -- errors, tags, deletions
      base09 = p.amethyst, -- numbers, constants
      base0A = p.topaz, -- types, search
      base0B = p.emerald, -- strings, additions
      base0C = p.aquamarine, -- escapes, regex
      base0D = p.sapphire, -- functions
      base0E = p.gold, -- keywords
      base0F = p.steel, -- delimiters, deprecated
    })
    vim.g.colors_name = "coruscant"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.gold, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.amethyst, bold = true })
    hl("Search", { fg = p.crust, bg = p.topaz })
    hl("IncSearch", { fg = p.crust, bg = p.amethyst })
    hl("CurSearch", { fg = p.crust, bg = p.amethyst })

    -- No background: kitty's translucent office glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.brass })
    hl("FloatTitle", { fg = p.gold, bold = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.steel })
    hl("@variable.parameter", { fg = p.subtext1, italic = true })
    hl("@variable.builtin", { fg = p.gold })
    hl("@property", { fg = p.steel })
    hl("@module", { fg = p.steel })
    hl("@constructor", { fg = p.aquamarine })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.aquamarine })
    hl("@tag", { fg = p.gold })
    hl("@tag.attribute", { fg = p.topaz })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay0, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })
    hl("SnacksDashboardHeader", { fg = p.gold })

    -- Diagnostics and git
    for name, color in pairs({
      Error = p.ruby,
      Warn = p.topaz,
      Info = p.sapphire,
      Hint = p.aquamarine,
      Ok = p.emerald,
    }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.emerald })
    hl("GitSignsChange", { fg = p.topaz })
    hl("GitSignsDelete", { fg = p.ruby })
    hl("DiffAdd", { bg = "#1c2a1d" })
    hl("DiffChange", { bg = "#2c2616" })
    hl("DiffDelete", { bg = "#251d33" })
    hl("DiffText", { bg = "#463a1c" })
  end,
}
