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
      base08 = p.stop, -- errors, tags, deletions
      base09 = p.uv, -- numbers, constants
      base0A = p.tungsten, -- types, search
      base0B = p.go, -- strings, additions
      base0C = p.ice, -- escapes, regex
      base0D = p.cyan, -- functions
      base0E = p.neon, -- keywords
      base0F = p.lace, -- delimiters, deprecated
    })
    vim.g.colors_name = "quinn"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.neon, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.blush, bold = true })
    hl("Search", { fg = p.crust, bg = p.tungsten })
    hl("IncSearch", { fg = p.crust, bg = p.neon })
    hl("CurSearch", { fg = p.crust, bg = p.neon })

    -- No background: kitty's dark glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.crimson })
    hl("FloatTitle", { fg = p.neon, bold = true, italic = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.blush })
    hl("@variable.parameter", { fg = p.glow, italic = true })
    hl("@variable.builtin", { fg = p.stop })
    hl("@property", { fg = p.blush })
    hl("@module", { fg = p.blush })
    hl("@constructor", { fg = p.ice })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.ice })
    hl("@tag", { fg = p.neon })
    hl("@tag.attribute", { fg = p.tungsten })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay1, italic = true })

    -- Dashboard: the mask in neon, the keys like whispered options
    hl("SnacksDashboardHeader", { fg = p.neon })
    hl("SnacksDashboardIcon", { fg = p.crimson })
    hl("SnacksDashboardDesc", { fg = p.subtext1, italic = true })
    hl("SnacksDashboardKey", { fg = p.blush, bold = true })
    hl("SnacksDashboardFooter", { fg = p.overlay1, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.stop, Warn = p.tungsten, Info = p.cyan, Hint = p.ice, Ok = p.go }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.go })
    hl("GitSignsChange", { fg = p.tungsten })
    hl("GitSignsDelete", { fg = p.stop })
    hl("DiffAdd", { bg = "#16291d" })
    hl("DiffChange", { bg = "#2e2214" })
    hl("DiffDelete", { bg = "#361419" })
    hl("DiffText", { bg = "#4a3418" })
  end,
}
