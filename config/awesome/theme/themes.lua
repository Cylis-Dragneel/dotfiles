local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local theme = {}

theme.font = "Monsterrat Bold 11"

theme.bg_normal = "#1e1e2e"
theme.bg_focus = "#74c7ec"
theme.bg_urgent = "#f38ba8"

theme.fg_normal = "#cdd6f4"
theme.fg_focus = "#cba6f7"
theme.fg_urgent = "#f38ba8"

theme.useless_gap = dpi(8)
theme.border_width = dpi(4)
theme.border_color_normal = "#1d1e2e"
theme.border_color_active = "#cba6f7"
theme.border_color_marked = "#1d1d1d"
theme.tooltip_opacity = 0

theme.wallpaper = "~/Pictures/Wallpapers/japanese-purple.jpg"

gears.wallpaper.maximized(theme.wallpaper)

return theme
