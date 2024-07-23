local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clock = wibox.widget.textclock("%I:%M %p")

screen.connect_signal("request::desktop_decoration", function(s)

    --[[
      Taglist:
      This widget shows all of AwesomeWM's tags.
      Think of them like workspaces. You can
      click on one to switch to that tag.
    --]]
    s.taglist = awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = {
        awful.button({ }, 1, function(t)
          t:view_only()
        end)
      }
    }

    --[[
      Tasklist:
      This widget displays all active windows. Left
      click on a window's name to toggle minimization.
    --]]
    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        widget_template = {
            {
                {
                    id     = "text_role",
                    forced_height = dpi(20),
                    widget = wibox.widget.textbox
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place
            },
            id     = "background_role",
            widget = wibox.container.background
        },
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end)
        }
    }

    --[[
      Layouts:
      This widget shows the active layout. Left
      click to go to the next layout and right
      click to go to the previous layout.
    --]]
    s.layouts = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
        }
    }

    --[[
      Wibar:
      This is where we create our bar. 
    --]]
    s.wibar = awful.wibar {
        screen = s,
        position = "top",
        height = dpi(40),
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        widget = {
            {
                s.taglist,
                s.tasklist,
                {
                    clock,
                    s.layouts,
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        }
    }
end)
