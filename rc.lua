-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Load Debian menu entries
require("debian.menu")

require("vicious")
require("vicious.contrib")
-- vicious.suspend()
-- vicious.widgets.org

-- Register widget and attach calendar widget to the textclock
datewidget = awful.widget.textclock({ align = "right" })
require('calendar2')
calendar2.addCalendarToWidget(datewidget)

-- Volume
local sink = "alsa_output.pci-0000_00_1b.0.analog-stereo"
volumewidget = widget({ type = "textbox"})
vicious.register(volumewidget, vicious.contrib.pulse, "Vol: $1%", 2, sink)
volumewidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () awful.util.spawn("pavucontrol") end),
                       awful.button({ }, 3, function () vicious.contrib.pulse.toggle(sink) end),
                       awful.button({ }, 4, function () vicious.contrib.pulse.add(5,sink) end),
                       awful.button({ }, 5, function () vicious.contrib.pulse.add(-5,sink) end)
))

-- {{{ Battery state Widget

-- Create an ACPI widget
batterywidget = widget({ type = "textbox" })
batterywidget.text = " Bat:"
batterywidget:buttons(awful.util.table.join(
                        awful.button({ }, 1, function () awful.util.spawn("xfce4-power-manager-settings") end)
))
batterywidgettimer = timer({ timeout = 60 })
batterywidgettimer:add_signal("timeout",
                              function()
                                fh = assert(io.popen("acpi | sed -r 's/^.+ ([0-9]+%).*$/\\1/'", "r"))
                                batterywidget.text = " Bat: " .. fh:read("*l") .. " "
                                fh:close()
                              end
)
batterywidgettimer:start()

-- }}}

mailwidget = widget({ type = "imagebox" })
mailwidget.image = image(awful.util.getdir("config") .. "/icons/icedove.png")
mailwidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.util.spawn(os.getenv("HOME") .. "/bin/tb") end)
))

filewidget = widget({ type = "imagebox" })
filewidget.image = image(awful.util.getdir("config") .. "/icons/file-manager.png")
filewidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.util.spawn("pcmanfm") end)
))

ffwidget = widget({ type = "imagebox" })
ffwidget.image = image(awful.util.getdir("config") .. "/icons/firefox.png")
ffwidget:buttons(awful.util.table.join(
                   awful.button({ }, 1, function () awful.util.spawn("firefox") end)
))

webwidget = widget({ type = "imagebox" })
webwidget.image = image(awful.util.getdir("config") .. "/icons/web-browser.png")
webwidget:buttons(awful.util.table.join(
                    awful.button({ }, 1, function () awful.util.spawn("epiphany-browser") end)
))

cwebwidget = widget({ type = "imagebox" })
cwebwidget.image = image(awful.util.getdir("config") .. "/icons/chromium.png")
cwebwidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.util.spawn("chromium") end)
))

-- telegramwidget = widget({ type = "imagebox" })
-- telegramwidget.image = image(awful.util.getdir("config") .. "/icons/telegram-icon.png")
-- telegramwidget:buttons(awful.util.table.join(
-- 		      awful.button({ }, 1, function () awful.util.spawn(os.getenv("HOME") .. "/bin/tele") end)
-- ))

signalwidget = widget({ type = "imagebox" })
signalwidget.image = image(awful.util.getdir("config") .. "/icons/signal.png")
signalwidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () awful.util.spawn(os.getenv("HOME") .. "/bin/signal") end)
))

whatsappwidget = widget({ type = "imagebox" })
whatsappwidget.image = image(awful.util.getdir("config") .. "/icons/face-monkey.png")
whatsappwidget:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () awful.util.spawn(os.getenv("HOME") .. "/bin/whatsapp") end)
))

orgsyncwidget = widget({ type = "imagebox" })
orgsyncwidget.image = image(awful.util.getdir("config") .. "/icons/orgzly.png")
orgsyncwidget:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () awful.util.spawn(os.getenv("HOME") .. "/bin/sync_org.sh") end)
))

fbmesswidget = widget({ type = "imagebox" })
fbmesswidget.image = image(awful.util.getdir("config") .. "/icons/messengerfordesktop.png")
fbmesswidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () awful.util.spawn(os.getenv("HOME") .. "/bin/messy") end)

))

emacswidget = widget({ type = "imagebox" })
emacswidget.image = image(awful.util.getdir("config") .. "/icons/emacs22.png")
emacswidget:buttons(awful.util.table.join(
                      awful.button({ }, 1, function () awful.util.spawn("emacsclient -c") end)
))

-- vbwidget = widget({ type = "imagebox" })
-- vbwidget.image = image(awful.util.getdir("config") .. "/icons/virtualbox.png")
-- vbwidget:buttons(awful.util.table.join(
--                    awful.button({ }, 1, function () awful.util.spawn("VirtualBox") end)
-- ))

zoterowidget = widget({ type = "imagebox" })
zoterowidget.image = image(awful.util.getdir("config") .. "/icons/zotero.png")
zoterowidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function ()
                           awful.util.spawn(os.getenv("HOME") .. "/bin/zotero") end)
))

syncwidget = widget({ type = "imagebox" })
syncwidget.image = image(awful.util.getdir("config") .. "/icons/text-x-script.png")
syncwidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.util.spawn("xfce4-terminal --command " .. os.getenv("HOME") .. "/bin/.backup_file.sh") end)
))

phonewidget = widget({ type = "imagebox" })
phonewidget.image = image(awful.util.getdir("config") .. "/icons/stock_cell-phone.png")
phonewidget:buttons(awful.util.table.join(
                      awful.button({ }, 1, function () awful.util.spawn("xfce4-terminal --command " .. os.getenv("HOME") .. "/bin/.sync_phone.sh") end)
))

-- htopwidget = widget({ type = "imagebox" })
-- htopwidget.image = image(awful.util.getdir("config") .. "/icons/htop.png")
-- htopwidget:buttons(awful.util.table.join(
-- 		      awful.button({ }, 1, function () awful.util.spawn("xfce4-terminal --command htop --title htop --geometry 120x32+66+66") end)
-- ))



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Oops, there were errors during startup!",
                   text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.add_signal("debug::error", function (err)
                       -- Make sure we don't go into an endless error loop
                       if in_error then return end
                       in_error = true

                       naughty.notify({ preset = naughty.config.presets.critical,
                                        title = "Oops, an error happened!",
                                        text = err })
                       in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey  = "Mod4"
modkey2 = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
  {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
  }
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
  -- Each screen has its own tag table.
  tags[s] = awful.tag({ 1 }, s, layouts[8])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

-- local consolkit = [[dbus-send --print-reply --system \
--          --dest="org.freedesktop.ConsoleKit" \
--          /org/freedesktop/ConsoleKit/Manager \
--          org.freedesktop.ConsoleKit.Manager.]]
-- local upower = [[dbus-send --print-reply --system \
--          --dest=org.freedesktop.UPower \
--          /org/freedesktop/UPower \
--          org.freedesktop.UPower.]]
-- systemmenu = {
--    { "Shutdown", consolkit.."Stop" },
--    { "Restart", consolkit.."Restart" },
--    { "Suspend", function() awful.util.spawn(upower.."Suspend") end },
--    { "Hibernate", function () awful.util.spawn(upower.."Hibernate") end }
-- }


systemmenu = {
  { "Shutdown", function() awful.util.spawn("systemctl poweroff") end },
  { "Restart", function() awful.util.spawn("systemctl reboot") end },
  { "Suspend", function() awful.util.spawn("systemctl suspend") end },
  { "Hibernate", function () awful.util.spawn("systemctl hibernate") end },
  { "Logout", function () awful.util.spawn("xfce4-session-logout") end }
}


mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                            { "Debian", debian.menu.Debian_menu.Debian },
                            { "System", systemmenu },
                            { "open terminal", terminal }
}
                       })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}


-- {{{ Wibox
-- Create a textclock widget
-- mytextclock = awful.widget.textclock({ align = "right" })

-- create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
      if c == client.focus then
        c.minimized = true
      else
        if not c:isvisible() then
          awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
      end
  end),
  awful.button({ }, 3, function (c) c:kill()
  end),
  awful.button({ }, 2,
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
  end),
  -- awful.button({ }, 3, function ()
  -- 	 if instance then
  -- 	    instance:hide()
  -- 	    instance = nil
  -- 	 else
  -- 	    instance = awful.menu.clients({ width=250 })
  -- 	 end
  -- end),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(function(c)
      return awful.widget.tasklist.label.currenttags(c, s)
                                        end, mytasklist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({ position = "top", screen = s })
  -- Add widgets to the wibox - order matters
  mywibox[s].widgets = {
    {
      mylauncher,
      mytaglist[s],
      mypromptbox[s],
      layout = awful.widget.layout.horizontal.leftright
    },
    mylayoutbox[s],
    datewidget,
    volumewidget,
    batterywidget,
    -- htopwidget,
    phonewidget,
    syncwidget,
    -- vbwidget,
    zoterowidget,
    filewidget,
    emacswidget,
    orgsyncwidget,
    mailwidget,
    webwidget,
    ffwidget,
    cwebwidget,
    fbmesswidget,
    whatsappwidget,
    signalwidget,
    -- telegramwidget,
    s == 1 and mysystray or nil,
    mytasklist[s],
    layout = awful.widget.layout.horizontal.rightleft
  }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
               awful.button({ }, 3, function () mymainmenu:toggle() end),
               awful.button({ }, 4, awful.tag.viewnext),
               awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
  awful.key({ }, "XF86AudioRaiseVolume", function () vicious.contrib.pulse.add(5,sink) end),
  awful.key({ }, "XF86AudioLowerVolume", function () vicious.contrib.pulse.add(-5,sink) end),
  awful.key({ }, "XF86AudioMute", function() vicious.contrib.pulse.toggle(sink) end),
  awful.key({ "Mod1",     }, "Tab",
    function ()
      awful.client.focus.byidx( 1)
      if client.focus then client.focus:raise() end
  end),
  awful.key({ "Mod1",     }, "Escape",
    function ()
      awful.menu.menu_keys.down = { "Mod1", "Tab", "Down" }
      local cmenu = awful.menu.clients({width=400}, {keygrabber=true, coords={x=300, y=300}})
  end),
  awful.key({ modkey,           }, "j",
    function ()
      awful.client.focus.byidx( 1)
      if client.focus then client.focus:raise() end
  end),
  -- awful.key({ "Mod1",           }, "Tab",
  --     function ()
  --         awful.client.focus.byidx(-1)
  --         if client.focus then client.focus:raise() end
  --     end),
  -- awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modkey,           }, "u", awful.client.jumpto),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
  end),
  -- Standard program
  awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit),

  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
  -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
  awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
  awful.key({ modkey, "Control" }, "n", awful.client.restore),
  -- Prompt
  awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
  end)
)

clientkeys = awful.util.table.join(
  -- awful.key({ "F11"           }, ,      function (c) c.fullscreen = not c.fullscreen  end),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
  awful.key({ "Mod1",           }, "F4",      function (c) c:kill()                         end),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
  awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ modkey,           }, "s",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
  end),
  -- awful.key({ modkey,           }, "b",      function (c) c.fullscreen = not c.fullscreen  end)
  awful.key({ modkey,           }, "b",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- -- Compute the maximum number of digit we need, limited to 9
-- keynumber = 0
-- for s = 1, screen.count() do
--   keynumber = math.min(9, math.max(#tags[s], keynumber));
-- end

-- -- Bind all key numbers to tags.
-- -- Be careful: we use keycodes to make it works on any keyboard layout.
-- -- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, keynumber do
--   globalkeys = awful.util.table.join(globalkeys,
--                                      awful.key({ modkey }, "#" .. i + 9,
--                                        function ()
--                                          local screen = mouse.screen
--                                          if tags[screen][i] then
--                                            awful.tag.viewonly(tags[screen][i])
--                                          end
--                                      end),
--                                      awful.key({ modkey, "Control" }, "#" .. i + 9,
--                                        function ()
--                                          local screen = mouse.screen
--                                          if tags[screen][i] then
--                                            awful.tag.viewtoggle(tags[screen][i])
--                                          end
--                                      end),
--                                      awful.key({ modkey, "Shift" }, "#" .. i + 9,
--                                        function ()
--                                          if client.focus and tags[client.focus.screen][i] then
--                                            awful.client.movetotag(tags[client.focus.screen][i])
--                                          end
--                                      end),
--                                      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--                                        function ()
--                                          if client.focus and tags[client.focus.screen][i] then
--                                            awful.client.toggletag(tags[client.focus.screen][i])
--                                          end
--   end))
-- end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = true,
                   keys = clientkeys,
                   buttons = clientbuttons } },
  { rule = { class = "xfce4-appfinder" },
    properties = { floating = true } },
  { rule = { class = "Xfce4-appfinder" },
    properties = { floating = true } },
  { rule = { instance = "plugin-container" },
    properties = { floating = true } },
  { rule = { instance = "Plugin-container" },
    properties = { floating = true } },
  { rule = { class = "anamnesis" },
    properties = { floating = true } },
  { rule = { name = "htop" },
    properties = { floating = true } },
  -- { rule = { class = "MPlayer" },
  --   properties = { floating = true } },
  -- { rule = { name = "MPlayer" },
  --   properties = { tag = tags[1][2] } },
  { rule = { class = "pinentry" },
    properties = { floating = true } },
  -- -- Set Firefox to always map on tags number 2 of screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { tag = tags[1][2] } },
  -- { rule = { class = "Iceweasel" },
  --   properties = { tag = tags[1][2] } }
  { rule = { class = "gimp" },
    properties = { floating = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
                    -- Add a titlebar
                    -- awful.titlebar.add(c, { modkey = modkey })

                    -- Enable sloppy focus
                    c:add_signal("mouse::enter", function(c)
                                   if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                                   and awful.client.focus.filter(c) then
                                     client.focus = c
                                   end
                    end)

                    if not startup then
                      -- Set the windows at the slave,
                      -- i.e. put it at the end of others instead of setting it master.
                      -- awful.client.setslave(c)

                      -- Put windows in a smart way, only if they does not set an initial position.
                      if not c.size_hints.user_position and not c.size_hints.program_position then
                        awful.placement.no_overlap(c)
                        awful.placement.no_offscreen(c)
                      end
                    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
