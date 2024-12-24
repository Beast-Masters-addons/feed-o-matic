---@class FOM_ItemTooltip
---Item tooltip food preference
local lib = _G.GFW_FeedOMatic:NewModule("FOM_ItemTooltip", "AceEvent-3.0")

local addon = _G.GFW_FeedOMatic
local CreateColor = _G.CreateColor

---@type FOM_Food
local FOM_Food = _G.GFW_FeedOMatic:GetModule("FOM_Food")
---@type FOM_PetInfo
local petInfo = _G.GFW_FeedOMatic:GetModule("FOM_PetInfo")

local utils, minor = _G.LibStub("BM-utils-1")
local QuestDifficultyColors = _G.QuestDifficultyColors

local function FOM_TooltipAddFoodQuality(self, itemID)
    local color
    local _, _, _, itemLevel = GetItemInfo(itemID);
    if (itemLevel) then
        local levelDelta = petInfo.petLevel - itemLevel;
        local petName = petInfo.petName
        if (levelDelta >= FOM_DELTA_EATS) then
            color = QuestDifficultyColors["trivial"];
            self:AddLine(string.format(FOM_QUALITY_UNDER, petName), color.r, color.g, color.b);
            return true;
        elseif (levelDelta >= FOM_DELTA_LIKES and levelDelta < FOM_DELTA_EATS) then
            color = QuestDifficultyColors["standard"];
            self:AddLine(string.format(FOM_QUALITY_WILL, petName), color.r, color.g, color.b);
            return true;
        elseif (levelDelta >= FOM_DELTA_LOVES and levelDelta < FOM_DELTA_LIKES) then
            color = QuestDifficultyColors["difficult"];
            self:AddLine(string.format(FOM_QUALITY_LIKE, petName), color.r, color.g, color.b);
            return true;
        elseif (levelDelta < FOM_DELTA_LOVES) then
            color = QuestDifficultyColors["verydifficult"];
            self:AddLine(string.format(FOM_QUALITY_LOVE, petName), color.r, color.g, color.b);
            return true;
        end
    end
end

local function tooltipText(self, itemId)
    local foodDiet = FOM_Food.isKnownFood(itemId);
    if not foodDiet then
        return false;
    end

    -- if edible at all, label diet in tooltip
    local color = FOM_DietColors[foodDiet];
    local coloredText = CreateColor(color.r, color.g, color.b):WrapTextInColorCode(foodDiet);
    local label = _G[self:GetName() .. "TextRight1"]
    label:SetText(coloredText);
    label:Show();

    -- if edible by current pet, add line for quality
    if (itemId and UnitExists("pet")) then
        for _, petDiet in pairs(petInfo.petDiet) do
            if petDiet == foodDiet then
                return FOM_TooltipAddFoodQuality(self, itemId);
            end
        end
        return true;
    end
end

---@param self Frame
---Add pet preference to food item tooltips (pet loves to eat this/pet does not like this)
local function FOM_OnTooltipSetItem(self)
    if addon.db.profile.Tooltip then
        local _, link = self:GetItem();
        if not link then
            return false;
        end

        local itemID = utils:ItemIdFromLink(link);
        return tooltipText(self, itemID)
    else
        return false
    end

end

---@param self Frame
local function FOM_OnTooltipSetItem_new(self, data)
    if addon.db.profile.Tooltip then
        return tooltipText(self, data['id'])
    else
        return false
    end
end

function lib:hook(frame)
    --Use new tooltip API for WoW 10+
    if _G.WOW_MAJOR >= 10 then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
            if tooltip == frame then
                FOM_OnTooltipSetItem_new(tooltip, data)
            end
        end)
    else
        if (frame:GetScript("OnTooltipSetItem")) then
            frame:HookScript("OnTooltipSetItem", FOM_OnTooltipSetItem);
        else
            frame:SetScript("OnTooltipSetItem", FOM_OnTooltipSetItem);
        end
    end
end
