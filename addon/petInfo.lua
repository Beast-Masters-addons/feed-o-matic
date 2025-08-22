local addon = _G.GFW_FeedOMatic
---@class FOM_PetInfo
local lib = addon:NewModule("FOM_PetInfo", "AceEvent-3.0")
---@type BMUtils
local utils = _G.LibStub('BMUtils')

function lib:OnEnable()
    self:RegisterEvent("UNIT_PET")
    self:RegisterEvent("CHAT_MSG_PET_INFO")
    self:RegisterEvent("UNIT_NAME_UPDATE")
    self:RegisterEvent("UI_ERROR_MESSAGE")
    ---@type FOM_FoodLogger
    self.foodLog = addon:GetModule("FOM_FoodLogger")
end

function lib:UNIT_PET(event, unit)
    if unit ~= "player" then
        return
    end
    self:updatePetInfo()
    if _G.UnitExists("pet") then
        print(('%s level %d summoned'):format(self.petName, self.petLevel))
    else
        print('Pet dismissed')
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
    local match_feed = message:match(_G['FEEDPET_LOG_FIRSTPERSON']:gsub("%%s", "(.+)"))

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
            _G.FOM_PickFoodForButton(); --Update button with new food

            --@debug@
            print(('%s does not like %s'):format(self.petFamily, _G['FOMFeedItemLink']))
        else
            print('Bad food, button not pressed')
            --@end-debug@
        end

    end
end