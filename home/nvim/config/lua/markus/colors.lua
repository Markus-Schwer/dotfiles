require('onedark').setup()
require('onedark').load()

require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer', 'DiagnosticError', 'DiagnosticWarn', 'DiagnosticInfo',
    'DiagnosticHint', 'DiagnosticOk', 'DiagnosticVirtualTextError',
    'DiagnosticVirtualTextError', 'DiagnosticVirtualTextWarn',
    'DiagnosticVirtualTextInfo', 'DiagnosticVirtualTextHint',
    'DiagnosticVirtualTextOk', 'DiagnosticUnderlineError', 'DiagnosticUnderlineWarn',
    'DiagnosticUnderlineInfo', 'DiagnosticUnderlineHint', 'DiagnosticUnderlineOk',
    'DiagnosticFloatingError', 'DiagnosticFloatingWarn', 'DiagnosticFloatingInfo',
    'DiagnosticFloatingHint', 'DiagnosticFloatingOk', 'DiagnosticSignError',
    'DiagnosticSignWarn', 'DiagnosticSignInfo', 'DiagnosticSignHint',
    'DiagnosticSignOk', 'DiagnosticDeprecated', 'DiagnosticUnnecessary'
  },
})
vim.g.transparent_enabled = true
