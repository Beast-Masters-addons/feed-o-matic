local addon = _G.GFW_FeedOMatic
---@class FOM_PetInfo
local lib = addon:NewModule("FOM_PetInfo", "AceEvent-3.0")
---@type BMUtils
local utils = _G.LibStub('BMUtils')
---@type FOM_Food
local food
---@type feedButtonHelper
local feedButton = addon:GetModule("feedButtonHelper")

function lib:OnEnable()
    self:RegisterEvent("UNIT_PET")
    self:RegisterEvent("CHAT_MSG_PET_INFO")
    self:RegisterEvent("UNIT_NAME_UPDATE")
    self:RegisterEvent("UI_ERROR_MESSAGE")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("BAG_UPDATE_DELAYED")
    ---@type FOM_FoodLogger
    self.foodLog = addon:GetModule("FOM_FoodLogger")
    food = addon:GetModule("FOM_Food")
end

function lib:PLAYER_REGEN_DISABLED()
    self:UnregisterEvent("BAG_UPDATE_DELAYED")
end

function lib:PLAYER_REGEN_ENABLED()
    self:RegisterEvent("BAG_UPDATE_DELAYED")
end

function lib:BAG_UPDATE_DELAYED()
    if self.petLevel then
        feedButton:updateFood()
    end
end

function lib:UNIT_PET(event, unit)
    if unit ~= "player" then
        return
    end
    self:updatePetInfo()
    if _G.UnitExists("pet") then
        feedButton:updateFood()
        feedButton.button:Show()
        --@debug@
        print(('%s level %d summoned'):format(self.petName, self.petLevel))
        --@end-debug@
    else
        --@debug@
        print('Pet dismissed')
        --@end-debug@
        feedButton.button:Hide()
    end

end

function lib:updatePetInfo()
    if _G.UnitExists("pet") then
        self.petName = _G.UnitName("pet")
        ---@type number Pet level
        self.petLevel = _G.UnitLevel("pet")
        self.petGender = _G.UnitSex("pet")
        self.petFamily = _G.UnitCreatureFamily("pet");
        self.petDiet = { _G.GetPetFoodTypes() }
        self.petDietEn = {}
        local petDietLocalized = _G.GetPetFoodTypes()
        if petDietLocalized then
            for _, dietLocale in ipairs({ _G.GetPetFoodTypes() }) do
                table.insert(self.petDietEn, food.unLocalizeDiet(dietLocale))
            end
        end
    else
        self.petName = nil
        self.petLevel = nil
        self.petGender = nil
        self.petFamily = nil
        self.petDiet = nil
    end
end

function lib:UNIT_NAME_UPDATE(event, unit)
    if unit == "pet" then
        self.petName = _G.UnitName("pet")
    end
end

function lib:CHAT_MSG_PET_INFO(event, message)
    local match_dismissed = message:match(_G['SPELLDISMISSPETSELF']:gsub("%%s", "(.*)"))
    local feed_log_string = _G['FEEDPET_LOG_FIRSTPERSON']:gsub("%%s", "(.+)"):gsub("%%1$s", ("(.+)"))
    local match_feed = message:match(feed_log_string)

    if match_dismissed then
        self:updatePetInfo()
        --@debug@
        print('Pet dismissed', match_dismissed)
        --@end-debug@
    elseif match_feed then
        local itemName, itemLink, _, itemLevel = _G.GetItemInfo(match_feed)
        local itemId = utils.itemIdFromLink(itemLink)
        self.foodLog.save(self.petFamily, itemId, itemName, 'good')
        --@debug@
        print(('%s eats %s delta %d'):format(self.petFamily, itemLink, self.petLevel - itemLevel))
        --@end-debug@
    else
        --@debug@
        print('Pet info', message)
        --@end-debug@
    end
end

function lib:UI_ERROR_MESSAGE(event, errorType, message)
    if not message then
        message = errorType
    end
    if not _G['FOMButtonPressed'] then
        return
    end

    if message == _G['SPELL_FAILED_WRONG_PET_FOOD'] then
        if _G['FOMButtonPressed'] == true then
            local itemName = _G.GetItemInfo(_G['FOMFeedItemId'])

            _G['FOMButtonPressed'] = false
            self.foodLog.save(self.petFamily, _G['FOMFeedItemId'], itemName, 'bad')
            feedButton:updateFood()

            --@debug@
            print(('%s does not like %s'):format(self.petFamily, _G['FOMFeedItemLink']))
        else
            print('Bad food, button not pressed')
            --@end-debug@
        end

    end
end