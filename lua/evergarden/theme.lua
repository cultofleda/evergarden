---@class evergarden.types.styleconfig
---@field tabline { reverse: boolean, color: evergarden.types.colors.enum }
---@field search { reverse: boolean, inc_reverse: boolean }
---@field types { italic: boolean }
---@field keyword { italic: boolean }
---@field comment { italic: boolean }

---@class evergarden.types.theme
---@field none evergarden.types.color
---@field colors evergarden.types.colors
---@field base { fg: evergarden.types.color, bg: evergarden.types.color }
---@field bg evergarden.types.color
---@field fg evergarden.types.color
---@field bg0 evergarden.types.color
---@field bg1 evergarden.types.color
---@field bg2 evergarden.types.color
---@field bg3 evergarden.types.color
---@field fg0 evergarden.types.color
---@field fg1 evergarden.types.color
---@field fg2 evergarden.types.color
---@field sakura  evergarden.types.color
---@field sage    evergarden.types.color
---@field sukai   evergarden.types.color
---@field shinme  evergarden.types.color
---@field sakaeru evergarden.types.color
---@field taiyo evergarden.types.color
---@field seiun   evergarden.types.color
---@field ike     evergarden.types.color
---@field syntax EvergardenSyntax
---@field diagnostic { ['ok'|'error'|'warn'|'info'|'hint']: evergarden.types.color }
---@field diff { ['add'|'delete'|'change']: evergarden.types.color }
---@field style evergarden.types.styleconfig
---@field sign evergarden.types.color
---@field comment evergarden.types.color
---@field bg_accent evergarden.types.color
---@field fg_accent evergarden.types.color

---@class EvergardenSyntax
---@field keyword evergarden.types.color
---@field object evergarden.types.color
---@field type evergarden.types.color
---@field context evergarden.types.color
---@field constant evergarden.types.color
---@field call evergarden.types.color
---@field string evergarden.types.color
---@field macro evergarden.types.color
---@field annotation evergarden.types.color

local M = {}

---@param colors evergarden.types.colors
---@param config evergarden.types.config
---@return evergarden.types.theme
function M.setup(colors, config)
  local theme   = {}

  theme.none    = { 'NONE', 0 }
  theme.colors  = colors

  theme.bg      = theme.none
  if not config.transparent_background then
    theme.bg = colors.bg0
    if config.contrast_dark == 'hard' then
      theme.bg = colors.bg0_hard
    end
    if config.contrast_dark == 'soft' then
      theme.bg = colors.bg0_soft
    end
  end
  theme.base    = { fg = colors.bg0, bg = theme.bg }
  theme.fg      = colors.fg

  theme.bg0     = colors.bg0
  theme.bg1     = colors.bg1
  theme.bg2     = colors.bg2
  theme.bg3     = colors.bg3

  theme.fg0     = colors.grey0
  theme.fg1     = colors.fg
  theme.fg2     = colors.grey1

  local sign_colors = { soft = theme.bg3 }
  theme.sign      = sign_colors[config.contrast_dark] or theme.none
  theme.comment   = theme.fg2
  theme.bg_accent = theme.bg1
  theme.fg_accent = colors.bg4

  theme.ike     = colors.aqua
  theme.shinme  = colors.green
  theme.sakura  = colors.red
  theme.taiyo   = colors.orange
  theme.sakaeru = colors.yellow
  theme.sukai   = colors.blue
  theme.sage    = colors.aqua
  theme.seiun   = colors.purple

  theme.syntax  = {
    keyword = theme.sakura,
    object = theme.fg1,
    type = theme.sakaeru,
    context = theme.fg0,
    constant = theme.seiun,
    call = theme.shinme,
    string = theme.shinme,
    macro = theme.taiyo,
    annotation = theme.sakura,
  }
  theme.diagnostic = {
    ok = theme.shinme,
    error = theme.sakura,
    warn = theme.sakaeru,
    info = theme.sage,
    hint = theme.sukai,
  }
  theme.diff = {
    add = theme.shinme,
    delete = theme.sakura,
    change = theme.sage,
  }

  theme.style = {
    search = { reverse = true }
  }
  theme.style = vim.tbl_deep_extend('force', theme.style, config.style)

  return theme
end

return M
