-- Wrath of the Lich King 3.3.5a build identity and presentation palette.
LeaPlusBuild = {
	name = "WotLK",
	interface = 30300,
	version = "3.3.5a-allinone.4",
	theme = {
		normal = {0.12, 0.24, 0.38, 0.98},
		hover = {0.14, 0.38, 0.62, 1},
		border = {0.28, 0.62, 0.90, 1},
		active = {0.16, 0.45, 0.72, 1},
		text = {0.90, 0.96, 1, 1},
		accent = {0.45, 0.78, 1, 1}
	}
}

-- The edit box was renamed before Wrath.  Keeping the old alias lets the
-- shared option implementation operate without changing Blizzard globals.
if not ChatFrameEditBox and ChatFrame1EditBox then
	ChatFrameEditBox = ChatFrame1EditBox
end
