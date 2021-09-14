function yankpath()
  local uri = mp.get_property("path")
  local pipe = io.popen("xclip -i -selection c", "w")
  pipe:write(uri)
  pipe:close()
  mp.osd_message("Path yanked to clipboard")
end

function yankstreampath()
  local uri = mp.get_property("stream-path")
  local pipe = io.popen("xclip -i -selection c", "w")
  pipe:write(uri)
  pipe:close()
  mp.osd_message("Stream-path yanked to clipboard")
end

mp.add_key_binding("y", "yank-path", yankpath)
mp.add_key_binding("shift+y", "yank-streampath", yankstreampath)
