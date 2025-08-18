local addon = _G.GFW_FeedOMatic
---@class FOM_Food
local lib = addon:NewModule("FOM_Food", "AceEvent-3.0")
---@type FOM_PetInfo
local petInfo = _G.GFW_FeedOMatic:GetModule("FOM_PetInfo")

function lib.getFoodList()
    if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
        --@debug@
        print('WoW classic detected, using classic food list')
        --@end-debug@
        return _G.FOM_Foods_classic
    elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC then
        --@debug@
        print('WoW wrath classic detected, using wrath food list')
        --@end-debug@
        return _G.FOM_Foods_wrath
        --TODO: Add cataclysm foods
    else
        return _G.FOM_Foods
    end
end

local foodList = lib.getFoodList()

function lib.isInDiet(foodItemID, dietList)
    -- pass no dietList to query against current pet's diets
    if (dietList == nil) then
        dietList = petInfo.petDiet
    end
    -- no current pet means try again later
    if (dietList == nil or #dietList == 0) then
        _G.FOM_PickFoodQueued = true;
        return nil;
    end
    if (type(dietList) ~= "table") then
        dietList = { dietList };
    end

    for _, diet in pairs(dietList) do
        local table = foodList[diet];
        if (table and table[foodItemID] ~= nil) then
            return diet;
        end
    end

    return nil;

end

---Is the item a known eatable food item?
function lib.isKnownFood(itemID)
    return lib.isInDiet(itemID, { FOM_DIET_MEAT, FOM_DIET_FISH, FOM_DIET_BREAD,
                                  FOM_DIET_CHEESE, FOM_DIET_FRUIT, FOM_DIET_FUNGUS, FOM_DIET_MECH });
end