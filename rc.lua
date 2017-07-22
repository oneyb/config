-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Load Debian menu entries
require("debian.menu")
-- local vicious = require("vicious")
require("vicious")
require("vicious.contrib")
-- vicious.suspend()
-- vicious.widgets.org

-- Register widget and attach calendar widget to the textclock

-- Volume
local sink = "alsa_output.pci-0000_00_1b.0.analog-stereo"
local volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.contrib.pulse, "Vol: $1%", 2, sink)
volumewidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () awful.spawn("pavucontrol") end),
                       awful.button({ }, 3, function () vicious.contrib.pulse.toggle(sink) end),
                       awful.button({ }, 4, function () vicious.contrib.pulse.add(5,sink) end),
                       awful.button({ }, 5, function () vicious.contrib.pulse.add(-5,sink) end)
))

-- {{{ Battery state Widget

-- Create an ACPI widget
local batterywidget = wibox.widget.textbox()
batterywidget.text = " Bat:"
batterywidget:buttons(awful.util.table.join(
                        awful.button({ }, 1, function () awful.spawn("xfce4-power-manager-settings") end)
))
-- batterywidgettimer = wibox.widget.timer()
-- batterywidgettimer:add_signal("timeout",
--                               function()
--                                 fh = assert(io.popen("acpi | sed -r 's/^.+ ([0-9]+%).*$/\\1/'", "r"))
--                                 batterywidget.text = " Bat: " .. fh:read("*l") .. " "
--                                 fh:close()
--                               end
-- )
-- batterywidgettimer:start()

gears.timer.start_new ( 69,
                        function()
                          fh = io.popen("acpi | sed -r 's/^.+ ([0-9]+%).*$/\\1/'", "r")
                          batterywidget.text = "Bat:" .. fh:read() .. " "
                        end
)

-- Create a widget and update its content using the output of a shell
-- command every 10 seconds:
-- local batterywidget = wibox.widget {
--     {
--         min_value        = 0,
--         max_value        = 100,
--         value            = 0,
--         paddings         = 1,
--         border_width     = 1,
--         forced_width     = 30,
--         border_color     = "#3F3F3F",
--         foreground_color = "#000111",
--         background_color = "#000000",
--         id               = "mypb",
--         widget           = wibox.widget.progressbar,
--     },
--     {
--         id           = "mytb",
--         text         = "100%",
--         widget       = wibox.widget.textbox,
--     },
--     buttons = awful.util.table.join(
--       awful.button({ }, 1, function () awful.spawn("xfce4-power-manager-settings") end)
--     ),
--     layout      = wibox.layout.stack,
--     set_battery = function(self, val)
--         self.mytb.text  = tonumber(val).."%"
--         self.mypb.value = tonumber(val)
--     end,
-- }

-- gears.timer {
--     timeout   = 10,
--     autostart = true,
--     callback  = function()
--         -- You should read it from `/sys/class/power_supply/` (on Linux)
--         -- instead of spawning a shell. This is only an example.
--         awful.spawn.easy_async(
--             {"sh", "-c", "acpi | sed -n 's/^.*, \([0-9]*\)%/\1/p'"},
--             function(out)
--                 batterywidget.text = out
--             end
--         )
--     end
-- }
-- }}}

local mailwidget = wibox.widget.imagebox()
mailwidget.image = awful.util.get_configuration_dir() .. "/icons/icedove.png"
mailwidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.spawn(os.getenv("HOME") .. "/bin/tb") end)
))

local filewidget = wibox.widget.imagebox()
filewidget.image = awful.util.get_configuration_dir() .. "/icons/file-manager.png"
filewidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.spawn("pcmanfm") end)
))

local ffwidget = wibox.widget.imagebox()
ffwidget.image = awful.util.get_configuration_dir() .. "/icons/firefox.png"
ffwidget:buttons(awful.util.table.join(
                   awful.button({ }, 1, function () awful.spawn("firefox") end)
))

local webwidget = wibox.widget.imagebox()
webwidget.image = awful.util.get_configuration_dir() .. "/icons/web-browser.png"
webwidget:buttons(awful.util.table.join(
                    awful.button({ }, 1, function () awful.spawn("epiphany-browser") end)
))

local cwebwidget = wibox.widget.imagebox()
cwebwidget.image = awful.util.get_configuration_dir() .. "/icons/chromium.png"
cwebwidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.spawn("chromium") end)
))

local signalwidget = wibox.widget.imagebox()
signalwidget.image = awful.util.get_configuration_dir() .. "/icons/signal.png"
signalwidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () awful.spawn(os.getenv("HOME") .. "/bin/signal") end)
))

local franzwidget = wibox.widget.imagebox()
franzwidget.image = awful.util.get_configuration_dir() .. "/icons/franz.png"
franzwidget:buttons(awful.util.table.join(
                      awful.button({ }, 1, function () awful.spawn(os.getenv("HOME") .. "/bin/franz.sh") end)
))

local orgsyncwidget = wibox.widget.imagebox()
orgsyncwidget.image = awful.util.get_configuration_dir() .. "/icons/orgzly.png"
orgsyncwidget:buttons(awful.util.table.join(
                        awful.button({ }, 1, function () awful.spawn(os.getenv("HOME") .. "/bin/sync_org.sh") end)
))


local emacswidget = wibox.widget.imagebox()
emacswidget.image = awful.util.get_configuration_dir() .. "/icons/emacs22.png"
emacswidget:buttons(awful.util.table.join(
                      awful.button({ }, 1, function () awful.spawn("emacsclient -c") end)
))

-- vbwidget = wibox.widget.imagebox()
-- vbwidget.image = awful.util.get_configuration_dir() .. "/icons/virtualbox.png"
-- vbwidget:buttons(awful.util.table.join(
--                    awful.button({ }, 1, function () awful.spawn("VirtualBox") end)
-- ))

local zoterowidget = wibox.widget.imagebox()
zoterowidget.image = awful.util.get_configuration_dir() .. "/icons/zotero.png"
zoterowidget:buttons(awful.util.table.join(
                       awful.button({ }, 1, function ()
                           awful.spawn(os.getenv("HOME") .. "/bin/zotero") end)
))

local syncwidget = wibox.widget.imagebox()
syncwidget.image = awful.util.get_configuration_dir() .. "/icons/text-x-script.png"
syncwidget:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.spawn("xfce4-terminal --command " .. os.getenv("HOME") .. "/bin/.backup_file.sh") end)
))

local phonewidget = wibox.widget.imagebox()
phonewidget.image = awful.util.get_configuration_dir() .. "/icons/stock_cell-phone.png"
phonewidget:buttons(awful.util.table.join(
                      awful.button({ }, 1, function () awful.spawn("xfce4-terminal --command " .. os.getenv("HOME") .. "/bin/.sync_phone.sh") end)
))

-- local htopwidget = wibox.widget.imagebox()
-- htopwidget.image = awful.util.get_configuration_dir() .. "/icons/htop.png"
-- htopwidget:buttons(awful.util.table.join(
--                      awful.button({ }, 1, function () awful.spawn("xfce4-terminal --command htop --title htop --geometry 120x32+66+66") end)
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
  awesome.connect_signal("debug::error", function (err)
                           -- Make sure we don't go into an endless error loop
                           if in_error then return end
                           in_error = true

                           naughty.notify({ preset = naughty.config.presets.critical,
                                            title = "Oops, an error happened!",
                                            text = tostring(err) })
                           in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.get_themes_dir() .. "zenburn/theme.lua")

-- beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/zenburn/theme.lua")

-- beautiful.get().wallpaper = "/usr/share/awesome/themes/default/background.png"
beautiful.get().wallpaper = "/home/oney/pictures/backgrounds/gsl3.jpg"



-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() return false, hotkeys_popup.show_help end},
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end}
}
systemmenu = {
  { "Shutdown", function() awful.spawn("systemctl poweroff") end },
  { "Restart", function() awful.spawn("systemctl reboot") end },
  { "Suspend", function() awful.spawn("systemctl suspend") end },
  { "Hibernate", function () awful.spawn("systemctl hibernate") end },
  { "Logout", function () awful.spawn("xfce4-session-logout") end }
}

mymainmenu = awful.menu({ items = { 
                            { "awesome", myawesomemenu, beautiful.awesome_icon },
                            { "Debian", debian.menu.Debian_menu.Debian },
                            { "System", systemmenu },
                            { "open terminal", terminal }
}
                       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
      if c == client.focus then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
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
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
        client.focus = c
        c:raise()
      end
      -- This will also un-minimize
      -- the client, if needed
  end)
  -- awful.button({ }, 3, client_menu_toggle_fn()),
  -- awful.button({ }, 4, function ()
  --     awful.client.focus.byidx(1)
  -- end),
  -- awful.button({ }, 5, function ()
  --     awful.client.focus.byidx(-1)
  -- end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        -- mykeyboardlayout,
        wibox.widget.systray(),
        -- htopwidget,
        -- vbwidget,
        franzwidget,
        signalwidget,
        mailwidget,
        webwidget,
        ffwidget,
        cwebwidget,
        zoterowidget,
        filewidget,
        emacswidget,
        orgsyncwidget,
        phonewidget,
        syncwidget,
        batterywidget,
        volumewidget,
        mytextclock,
        s.mylayoutbox
      },
    }
end)
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
    end,
    {description = "focus next by index", group = "client"}
  ),
  -- awful.key({ modkey,           }, "k",
  --   function ()
  --     awful.client.focus.byidx(-1)
  --   end,
  --   {description = "focus previous by index", group = "client"}
  -- ),
  awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    {description = "show main menu", group = "awesome"}),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    {description = "swap with next client by index", group = "client"}),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    {description = "swap with previous client by index", group = "client"}),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    {description = "focus the previous screen", group = "screen"}),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}),

  -- Standard program
  awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  -- awful.key({ modkey, "Shift"   }, "q", awesome.quit,
  --   {description = "quit awesome", group = "awesome"}),

  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
    {description = "select next", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    {description = "select previous", group = "layout"}),

  awful.key({ modkey, "Control" }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    {description = "restore minimized", group = "client"}),

  -- Prompt
  awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    {description = "run prompt", group = "launcher"}),

  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}),
  -- Menubar
  awful.key({ modkey }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
  awful.key({ modkey,           }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
    {description = "close", group = "client"}),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
    {description = "toggle floating", group = "client"}),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),
  awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    {description = "move to screen", group = "client"}),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    {description = "toggle keep on top", group = "client"}),
  awful.key({ modkey,           }, "s",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end ,
    {description = "minimize", group = "client"}),
  awful.key({ "Mod1",           }, "F4",      function (c) c:kill()                         end),
  awful.key({ modkey,           }, "b",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
                                     -- View tag only.
                                     awful.key({ modkey }, "#" .. i + 9,
                                       function ()
                                         local screen = awful.screen.focused()
                                         local tag = screen.tags[i]
                                         if tag then
                                           tag:view_only()
                                         end
                                       end,
                                       {description = "view tag #"..i, group = "tag"}),
                                     -- Toggle tag display.
                                     awful.key({ modkey, "Control" }, "#" .. i + 9,
                                       function ()
                                         local screen = awful.screen.focused()
                                         local tag = screen.tags[i]
                                         if tag then
                                           awful.tag.viewtoggle(tag)
                                         end
                                       end,
                                       {description = "toggle tag #" .. i, group = "tag"}),
                                     -- Move client to tag.
                                     awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                       function ()
                                         if client.focus then
                                           local tag = client.focus.screen.tags[i]
                                           if tag then
                                             client.focus:move_to_tag(tag)
                                           end
                                         end
                                       end,
                                       {description = "move focused client to tag #"..i, group = "tag"}),
                                     -- Toggle tag on focused client.
                                     awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                       function ()
                                         if client.focus then
                                           local tag = client.focus.screen.tags[i]
                                           if tag then
                                             client.focus:toggle_tag(tag)
                                           end
                                         end
                                       end,
                                       {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   raise = true,
                   keys = clientkeys,
                   buttons = clientbuttons,
                   screen = awful.screen.preferred,
                   placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
      },
      class = {
        "Arandr",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Wpa_gui",
        "pinentry",
        "veromix",
        "xtightvncviewer"},

      name = {
        "Event Tester",  -- xev.
        "htop",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
  }, properties = { floating = true }},

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
               }, properties = { titlebars_enabled = true }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
                        -- Set the windows at the slave,
                        -- i.e. put it at the end of others instead of setting it master.
                        -- if not awesome.startup then awful.client.setslave(c) end

                        if awesome.startup and
                          not c.size_hints.user_position
                        and not c.size_hints.program_position then
                          -- Prevent clients from being unreachable after screen count changes.
                          awful.placement.no_offscreen(c)
                        end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
                        -- buttons for the titlebar
                        local buttons = awful.util.table.join(
                          awful.button({ }, 1, function()
                              client.focus = c
                              c:raise()
                              awful.mouse.client.move(c)
                          end),
                          awful.button({ }, 3, function()
                              client.focus = c
                              c:raise()
                              awful.mouse.client.resize(c)
                          end)
                        )

                        awful.titlebar(c) : setup {
                          { -- Left
                            awful.titlebar.widget.iconwidget(c),
                            buttons = buttons,
                            layout  = wibox.layout.fixed.horizontal
                          },
                          { -- Middle
                            { -- Title
                              align  = "center",
                              widget = awful.titlebar.widget.titlewidget(c)
                            },
                            buttons = buttons,
                            layout  = wibox.layout.flex.horizontal
                          },
                          { -- Right
                            awful.titlebar.widget.floatingbutton (c),
                            awful.titlebar.widget.maximizedbutton(c),
                            awful.titlebar.widget.stickybutton   (c),
                            awful.titlebar.widget.ontopbutton    (c),
                            awful.titlebar.widget.closebutton    (c),
                            layout = wibox.layout.fixed.horizontal()
                          },
                          layout = wibox.layout.align.horizontal
                                                  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
                        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                        and awful.client.focus.filter(c) then
                          client.focus = c
                        end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
