-- mpv script to play lbry:// in mpv

function play_lbry()
        local url = mp.get_property("stream-open-filename")

        -- find if the url is lbry
        if (url:find("lbry://") == 1) then
		converted_url = url:gsub("lbry://", "https://www.lbry.tv/")
                mp.set_property("stream-open-filename", converted_url)
        end
end


mp.add_hook("on_load", 50, play_lbry)
