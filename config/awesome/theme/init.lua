local beautiful = require("beautiful")
local gears = require("gears")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/themes.lua")

require("theme.bar") -- This loads our new file
