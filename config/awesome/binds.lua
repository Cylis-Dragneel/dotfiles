local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Mouse
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ modkey }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end)
    })
end)

-- General keybinds
awful.keyboard.append_global_keybindings({
      -- Awesome keybinds
        awful.key(
          { modkey }, "/",
            hotkeys_popup.show_help,
          { description = "show keybinds", group = "awesome" }
        ),
        awful.key(
          { modkey, "Shift" }, "r",
            awesome.restart,
          { description = "reload awesome", group = "awesome" }
        ),
        awful.key(
          { modkey, "Shift" }, "q",
            awesome.quit,
          { description = "quit awm", group = "awesome"}
        ),
        awful.key(
          { modkey }, "Tab", function()
            awful.client.focus.byidx(1)
          end,
          { description = "next window", group = "awesome" }
        ),
        awful.key(
          { modkey, "Shift" }, "Tab", function()
            awful.client.focus.byidx(-1)
          end,
          { description = "previous window", group = "awesome" }
        ),
        awful.key(
          { modkey }, "Return", function()
            awful.spawn.with_shell(terminal)
          end,
          { description = "run terminal", group = "awesome" }
        ),
        awful.key(
          { modkey, "Shift" }, "Return", function()
            awful.spawn("rofi -show drun")
          end,
          { description = "run rofi", group = "awesome" }
        ),

      -- Tag keybinds
        awful.key {
            modifiers   = { modkey },
            keygroup    = "numrow",
            description = "only view tag",
            group       = "tag",
            on_press    = function(index)
                local screen = awful.screen.focused()
                local tag = screen.tags[index]
                if tag then
                    tag:view_only()
                end
            end,
        },
        awful.key {
            modifiers = { modkey, "Shift" },
            keygroup    = "numrow",
            description = "move focused client to tag and follow",
            group       = "tag",
            on_press    = function(index)
                if client.focus then
                    local tag = client.focus.screen.tags[index]
                    if tag then
                        client.focus:move_to_tag(tag)
              tag:view_only()
                    end
                end
            end,
        }
})

-- Client keybinds
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key(
			{ modkey }, "c",
			function(c)
				awful.placement.centered(c, { honor_workarea = true })
			end,
			{ description = "center window", group = "client" }
		),
    awful.key(
			{ modkey }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }
		),
	  awful.key(
			{ modkey, "Shift" }, "s",
			function(c)
				c.floating = not c.floating
				c:raise()
			end,
        	{ description = "toggle floating", group = "client" }
		),
	  awful.key(
			{ modkey }, "n",
			function(c)
				client.focus.minimized = true
			end,
        	{ description = "minimize", group = "client" }
		),
	  awful.key(
			{ modkey }, "m",
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
        	{ description = "toggle maximize", group = "client" }
		),
		awful.key(
			{ modkey }, "q",
      function(c)
				c:kill()
			end,
 			{ description = "close", group = "client" }
		),
	})
end)
