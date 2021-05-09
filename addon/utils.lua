_G['FOMUtils'] = {}
local utils = _G['FOMUtils']

---Extract the item name from the message in CHAT_MSG_PET_INFO event
---@param message string Message from CHAT_MSG_PET_INFO event
function utils.get_feed_item(message)
    local pattern = _G['FEEDPET_LOG_FIRSTPERSON']:gsub("%%s", "(.+)"):gsub('%%1$s', '(.+)')
    return message:match(pattern)
end