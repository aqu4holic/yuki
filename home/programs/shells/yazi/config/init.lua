Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")

table.insert(bookmarks, {
    tag = "Download",
    path = home_path .. path_sep .. "Download" .. path_sep,
    key = "d",
})
table.insert(bookmarks, {
    tag = "code",
    path = home_path .. path_sep .. "code" .. path_sep,
    key = "c",
})
table.insert(bookmarks, {
    tag = "github",
    path = home_path .. path_sep .. "github" .. path_sep,
    key = "g",
})
table.insert(bookmarks, {
    tag = "Documents",
    path = home_path .. path_sep .. "Documents" .. path_sep,
    key = "D",
})
table.insert(bookmarks, {
    tag = "Pictures",
    path = home_path .. path_sep .. "Pictures" .. path_sep,
    key = "p",
})
table.insert(bookmarks, {
    tag = "Videos",
    path = home_path .. path_sep .. "Videos" .. path_sep,
    key = "v",
})

require("yamb"):setup({
    -- Optional, the path ending with path seperator represents folder.
    bookmarks = bookmarks,
    -- Optional, recieve notification everytime you jump.
    jump_notify = true,
    -- Optional, the cli of fzf.
    cli = "fzf",
    -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
    keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
    -- Optional, the path of bookmarks
    path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark") or
                (os.getenv("HOME") .. "/.config/yazi/bookmark"),
})

require("relative-motions"):setup(
    {
        show_numbers = "relative_absolute",
        show_motion = true
    }
)

require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

require("git"):setup()
