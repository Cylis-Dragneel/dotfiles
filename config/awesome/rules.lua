local awful = require("awful")
local ruled = require("ruled")
local naughty = require("naughty")

ruled.client.connect_signal("request::rules", function()
	-- All new clients will follow this rule
	ruled.client.append_rule {
		id = "global",
		rule = { },
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.centered+awful.placement.no_offscreen
		}
	}

	-- Clients that will always start as floating
	ruled.client.append_rule {
		id = "floating",
		rule_any = {
			class = {
				"Arandr", "Sxiv" -- Add your own here! You can find the class name with xprop
			},
			name = {
				"Event Tester" -- xev windows
			},
			role = {
				"pop-up"
			}
		},
		properties = { floating = true }
	}
end)

ruled.notification.connect_signal("request::rules", function()
	-- All notifications will follow this rule
	ruled.notification.append_rule {
		rule = { },
		properties = {
			screen = awful.screen.preferred,
			implicit_timeout = 5,
		}
	}
end)

-- Create notifications
naughty.connect_signal("request::display", function(n)
	naughty.layout.box { notification = n }
end)
