_G['FOMEvents'] = {}
local events = _G['FOMEvents']
local fom_utils = _G['FOMUtils']
local utils = _G.LibStub('BM-utils-1', 5)

local frame = _G.CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, ...)
    if _G['FOMEvents'][event] == nil then
        error(utils:sprintf('No event handler for %s', event))
    end
    events[event](self, ...)
end)

function events:ADDON_LOADED(addonName)
    if addonName == 'GFW_FeedOMatic' then
        --@debug@
        utils:printf("%s loaded", addonName)
        --@end-debug@
        self:RegisterEvent("CHAT_MSG_PET_INFO")
        self:RegisterEvent('UI_ERROR_MESSAGE')
    end
end

function events:CHAT_MSG_PET_INFO(arg1)
    local itemName = fom_utils.get_feed_item(arg1)
    if itemName == nil then
        return
    end
    local itemName2, itemLink = _G.GetItemInfo(itemName)
    local itemId = utils:ItemIdFromLink(itemLink)

    local creatureFamily = _G.UnitCreatureFamily("pet");
    _G['FOMFoodLogger'].save(creatureFamily, itemId, itemName2, 'good')
    --@debug@
    utils:printf('%s eats %s', creatureFamily, itemId)
    --@end-debug@
    _G['FOMButtonPressed'] = false
end

function events:UI_ERROR_MESSAGE(arg1, arg2)
    --Retail includes a trailing . in the message, strip that
    if arg2:sub(1,31) == 'Your pet doesn\'t like that food' then
        if _G['FOMButtonPressed'] == true then
            local itemName = _G.GetItemInfo(_G['FOMFeedItemId'])

            local creatureFamily = _G.UnitCreatureFamily("pet");
            _G['FOMButtonPressed'] = false
            _G['FOMFoodLogger'].save(creatureFamily, _G['FOMFeedItemId'], itemName, 'bad')
            _G.FOM_PickFoodForButton(); --Update button with new food

            --@debug@
            utils:printf('%s does not like %s', creatureFamily, _G['FOMFeedItemLink'])
        else
            print('Bad food, button not pressed')
            --@end-debug@
        end
    end
end