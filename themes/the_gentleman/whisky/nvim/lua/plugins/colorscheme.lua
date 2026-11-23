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
      base08 = p.wine, -- errors, tags, deletions
      base09 = p.rose, -- numbers, constants
      base0A = p.ember, -- types, search
      base0B = p.velvet, -- strings, additions
      base0C = p.teal, -- escapes, regex
      base0D = p.smoke, -- functions
      base0E = p.amber, -- keywords
      base0F = p.brass, -- delimiters, deprecated
    })
    vim.g.colors_name = "whisky"

    local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end

    -- Editor
    hl("CursorLine", { bg = p.mantle })
    hl("CursorLineNr", { fg = p.amber, bold = true })
    hl("LineNr", { fg = p.surface2 })
    hl("Visual", { bg = p.surface2 })
    hl("WinSeparator", { fg = p.surface1 })
    hl("MatchParen", { fg = p.honey, bold = true })
    hl("Search", { fg = p.crust, bg = p.ember })
    hl("IncSearch", { fg = p.crust, bg = p.honey })
    hl("CurSearch", { fg = p.crust, bg = p.honey })

    -- No background: kitty's smoked glass shows through
    local clear = { "Normal", "NormalNC", "SignColumn", "FoldColumn", "EndOfBuffer", "NormalFloat" }
    for _, name in ipairs(clear) do
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = name }), { bg = "NONE" }))
    end
    hl("FloatBorder", { fg = p.brass })
    hl("FloatTitle", { fg = p.amber, bold = true, italic = true })
    hl("Pmenu", { fg = p.subtext1, bg = p.mantle })
    hl("PmenuSel", { fg = p.text, bg = p.surface1, bold = true })

    -- Syntax: variables stay neutral so keywords, functions and strings stand out
    hl("@variable", { fg = p.text })
    hl("@variable.member", { fg = p.lightSmoke })
    hl("@variable.parameter", { fg = p.tobacco, italic = true })
    hl("@variable.builtin", { fg = p.wine })
    hl("@property", { fg = p.lightSmoke })
    hl("@module", { fg = p.lightSmoke })
    hl("@constructor", { fg = p.teal })
    hl("@punctuation", { fg = p.overlay1 })
    hl("@punctuation.delimiter", { fg = p.overlay1 })
    hl("@punctuation.bracket", { fg = p.overlay1 })
    hl("@operator", { fg = p.teal })
    hl("@tag", { fg = p.amber })
    hl("@tag.attribute", { fg = p.honey })
    hl("@tag.delimiter", { fg = p.overlay1 })
    hl("@constructor.lua", { fg = p.overlay1 }) -- table braces
    hl("Comment", { fg = p.overlay1, italic = true })

    -- Dashboard: the glass in amber, the keys like a menu
    hl("SnacksDashboardHeader", { fg = p.amber })
    hl("SnacksDashboardIcon", { fg = p.brass })
    hl("SnacksDashboardDesc", { fg = p.subtext1, italic = true })
    hl("SnacksDashboardKey", { fg = p.honey, bold = true })
    hl("SnacksDashboardFooter", { fg = p.overlay1, italic = true })

    -- Indent guides stay in the background, the current scope is a step brighter
    hl("SnacksIndent", { fg = p.surface0 })
    hl("SnacksIndentScope", { fg = p.overlay0 })

    -- Diagnostics and git
    for name, color in pairs({ Error = p.wine, Warn = p.ember, Info = p.smoke, Hint = p.teal, Ok = p.velvet }) do
      hl("Diagnostic" .. name, { fg = color })
      hl("DiagnosticVirtualText" .. name, { fg = color, bg = p.mantle })
      hl("DiagnosticUnderline" .. name, { sp = color, undercurl = true })
    end
    hl("GitSignsAdd", { fg = p.velvet })
    hl("GitSignsChange", { fg = p.ember })
    hl("GitSignsDelete", { fg = p.wine })
    hl("DiffAdd", { bg = "#1f2a1c" })
    hl("DiffChange", { bg = "#2e2414" })
    hl("DiffDelete", { bg = "#2e1617" })
    hl("DiffText", { bg = "#4a3518" })
  end,
}
