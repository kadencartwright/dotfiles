-- Converted from hyprland.conf to Hyprland's Lua config format.
-- See: https://wiki.hypr.land/Configuring/Start/

local home = os.getenv("HOME") or ""

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("wayle shell")
	-- SwayNC disabled; Wayle owns notifications.
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd(
		"slack --gtk-version=3 --enable-features=UseOzonePlatform --ozone-platform=wayland",
		{ workspace = "1 silent" }
	)
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("bitwarden-desktop", { workspace = "10 silent" })
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("WLR_DRM_DEVICES", home .. "/.config/hypr/card")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("TERMINAL", "ghostty")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "adwaita")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "adwaita-dark")
-- Do not force GTK_THEME globally: it overrides nwg-look/GTK settings and breaks GTK4 theming.
-- hl.env("GTK_THEME", "AtomOneDarkTheme")
hl.env("HYPRSHOT_DIR", home .. "/photos/screenshots")
hl.env("SSH_AUTH_SOCK", home .. "/.bitwarden-ssh-agent.sock")
-- toolkit-specific scale
hl.env("GDK_SCALE", "1")

------------------
---- MONITORS ----
------------------

-- monitor on lenovo z16
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "desc:Lenovo Group Limited 0x4146", mode = "preferred", position = "auto", scale = 2 })
hl.monitor({ output = "DP-10", mode = "3840x2160@60", position = "auto", scale = 1.5 })
hl.monitor({ output = "desc:ARZ ARZOPA-315", mode = "3840x2160@144", position = "auto", scale = 1.5 })
hl.monitor({
	output = "desc:Samsung Electric Company Odyssey G61SD HNAX901424",
	mode = "2560x1440@120",
	position = "auto",
	scale = 1,
})

require("monitors")

------------------------
---- CORE SETTINGS -----
------------------------

hl.config({
	cursor = {
		no_hardware_cursors = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},

	input = {
		kb_layout = "us",
		repeat_delay = 180,
		repeat_rate = 80,
		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},

	general = {
		gaps_in = 4,
		gaps_out = 4,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(98c379ff)", "rgba(61afefff)" }, angle = 45 },
			-- inactive_border = "rgba(595959aa)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding = 8,
		active_opacity = 0.96,
		inactive_opacity = 0.90,

		blur = {
			enabled = true,
			size = 12,
			passes = 2,
			new_optimizations = true,
		},

		shadow = {
			enabled = true,
			range = 4,
			color = "rgba(1a1a1aee)",
			render_power = 3,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		-- disable the stupid anime banner
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		enable_anr_dialog = false,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "workspaces", enabled = false })
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "myBezier", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6, bezier = "default", style = "popin 90%" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })

------------------
---- GESTURES ----
------------------

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT"
local secondaryMod = "SUPER"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty --working-directory=$HOME"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("CONTROL + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("bemoji -t"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("fuzzel --hide-before-typing"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("/usr/bin/matrix.sh"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprshot -z -m region"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd('wl-screenrec -g "$(slurp)"'))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("chromium"))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- workspace 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move active workspace to monitor
for monitor = 0, 2 do
	hl.bind(mainMod .. " + CTRL + " .. monitor, hl.dsp.workspace.move({ monitor = monitor }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Define Resize Submap
hl.bind("ALT + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	-- Set repeatable binds for resizing the active window.
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

	-- Use reset to go back to the global submap.
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("RETURN", hl.dsp.submap("reset"))
end)

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 4%+"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(secondaryMod .. " + L", hl.dsp.exec_cmd("hyprlock --grace 0"))

-- hyprwhspr - Toggle mode (added by hyprwhspr setup)
-- Press once to start, press again to stop
hl.bind("ALT + G", hl.dsp.exec_cmd("/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"), {
	description = "Speech-to-text",
})

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
	match = { float = true },
	opacity = "0.95 0.95",
})

hl.window_rule({
	match = { class = "^google-chrome$" },
	tile = true,
})
