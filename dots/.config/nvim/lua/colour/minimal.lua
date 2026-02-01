local M = {}

M.setup = function()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "bwminimal"

  local hi = vim.api.nvim_set_hl
  local c = { fg = "#FFFFFF", bg = "#000000", grey = "#808080" }

  -- Standard highlights
  hi(0, "Normal",       { fg = c.fg, bg = c.bg })
  hi(0, "Comment",      { fg = c.grey, bg = c.bg, italic = true })
  hi(0, "Constant",     { fg = c.fg, bg = c.bg })
  hi(0, "Identifier",   { fg = c.fg, bg = c.bg })
  hi(0, "Statement",    { fg = c.fg, bg = c.bg })
  hi(0, "PreProc",      { fg = c.fg, bg = c.bg })
  hi(0, "Type",         { fg = c.fg, bg = c.bg })
  hi(0, "Special",      { fg = c.fg, bg = c.bg })
  hi(0, "Underlined",   { fg = c.fg, bg = c.bg, underline = true })
  hi(0, "Todo",         { fg = c.bg, bg = c.fg, bold = true })

  -- Minimal UI tweaks
  hi(0, "LineNr",       { fg = c.grey, bg = c.bg })
  hi(0, "CursorLine",   { bg = c.bg })
  hi(0, "CursorColumn", { bg = c.bg })
  hi(0, "StatusLine",   { fg = c.fg, bg = c.bg, bold = true })
  hi(0, "VertSplit",    { fg = c.fg, bg = c.bg })

  -- Treesitter highlights
  hi(0, "@comment",       { fg = c.grey, bg = c.bg, italic = true })
  hi(0, "@constant",      { fg = c.fg, bg = c.bg })
  hi(0, "@string",        { fg = c.fg, bg = c.bg })
  hi(0, "@function",      { fg = c.fg, bg = c.bg })
  hi(0, "@function.call", { fg = c.fg, bg = c.bg })
  hi(0, "@method",        { fg = c.fg, bg = c.bg })
  hi(0, "@type",          { fg = c.fg, bg = c.bg })
  hi(0, "@keyword",       { fg = c.fg, bg = c.bg })
  hi(0, "@variable",      { fg = c.fg, bg = c.bg })
  hi(0, "@property",      { fg = c.fg, bg = c.bg })
  hi(0, "@field",         { fg = c.fg, bg = c.bg })
  hi(0, "@number",        { fg = c.fg, bg = c.bg })
  hi(0, "@operator",      { fg = c.fg, bg = c.bg })
  hi(0, "@boolean",       { fg = c.fg, bg = c.bg })
  hi(0, "@conditional",   { fg = c.fg, bg = c.bg })
  hi(0, "@repeat",        { fg = c.fg, bg = c.bg })
end

return M
