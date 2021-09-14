-- mpv script to temp fix twitch clips

function play_twitchclip()
        local url = mp.get_property("stream-open-filename")
	local oldurl = "https://production.assets.clips.twitchcdn.net/"
	local newurl = "https://clips-media-assets2.twitch.tv/"

        -- find if the url is a twitch clip
        if (url:find(oldurl) == 1) then
		converted_url = url:gsub(oldurl, newurl)
                mp.set_property("stream-open-filename", converted_url)
        end
end


mp.add_hook("on_load_fail", 50, play_twitchclip)
