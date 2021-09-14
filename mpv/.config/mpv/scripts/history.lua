-- Not my code: originally from https://redd.it/3t6s7k (author deleted; failed to ask for permission).
-- Only tested on Windows. Date is set to dd/mmm/yy and time to machine-wide format.
-- Save as "mpvhistory.lua" in your mpv scripts dir. Log will be saved to mpv default config directory.
-- Make sure to leave a comment if you make any improvements/changes to the script!

local HISTFILE = (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME").."/.config").."/mpv/history";

mp.register_event("file-loaded", function()
	local logfile;
	path = mp.get_property("path")
	if (path:find("https://") == 1) or (path:find("lbry://") == 1) or (path:find("magnet://") == 1) then
		logfile = io.open(HISTFILE, "a+");
		logfile:write(("%s\t%s\n"):format(path, mp.get_property("media-title")));
		logfile:close();
	end
end)
