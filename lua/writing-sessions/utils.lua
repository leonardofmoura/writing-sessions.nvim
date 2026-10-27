local M = {}


function format_time(seconds)
  local hours = math.floor(seconds / 3600)
  local mins = math.floor((seconds % 3600) / 60)
  local secs = seconds % 60

  return string.format("%02d:%02d:%02d", hours, mins, secs)
end


function calculate_wph(total_words, seconds)
  local wph = 0

  if seconds > 0 then
    wph = math.floor((total_words / seconds) * 3600)
  end

  return wph
end


return M

