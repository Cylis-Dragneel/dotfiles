-- load libraries

local awful = require("awful")
local naughty = require("naughty")
require("awful.autofocus")

--[[
Error Handling:
This will run if an error is encountered and 
send a notification specifying what happened. 
It's best to put this at the start of the file.
--]]

naughty.connect_signal("request::display_error",function (message,startup)
      naughty.notification {
        urgency = "critical",
        title = "Error" .. (startup and " during startup!" or "!"),
        message = message
      }
end)

-- Set Variables
terminal = "wezterm"
modkey = "Mod4"

-- Load Modules
require("binds")
require("rules")
require("theme.init")

--[[
Layouts:
	This specifies the layouts available to the user.
	To see more layouts, read the docs on awful.layout.
--]]

tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.floating
	})
end)

--[[
	Tags:
	This specifies the tags available to the user.
	These will be added to each connected screen
	and set the layout to the first in the layout table.
--]]

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8" }, s, awful.layout.layouts[1])
end)

--[[
	Sloppy focus:
	This will focus clients when your mouse hovers over them.
--]]
client.connect_signal("mouse::enter", function(c)
	c:activate { context = "mouse_enter", raise = false }
end)

--[[
	Tiling fix:
	This puts new windows at the bottom of the stack
	instead of replacing the master window.
--]]
client.connect_signal('manage', function(c)
	if not awesome.startup then awful.client.setslave(c) end
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)
