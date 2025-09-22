local addon = _G.GFW_FeedOMatic
---@class FOM_Food
local lib = addon:NewModule("FOM_Food", "AceEvent-3.0")
---@type FOM_PetInfo
local petInfo = _G.GFW_FeedOMatic:GetModule("FOM_PetInfo")

local WOW_MAJOR = math.floor(tonumber(select(4, _G.GetBuildInfo()) / 10000))

function lib.getFoodPriority(category)
    local foodTypes = { -- used to set priority
        ["conjured"] = 1, -- mage food etc, preferable because it's free!
        ["basic"] = 2, -- includes combo health/mana food, because hunters don't care about mana anymore
        ["wellfed"] = 3, -- food with "well fed" bonuses
        ["inedible"] = 4, -- usually cooking mats
    }
    assert(foodTypes[category], 'Invalid food category')
    return foodTypes[category]
end

function lib.localizeDiet(diet)
    local diets = {
        ["Meat"] = _G.FOM_DIET_MEAT,
        ["Fish"] = _G.FOM_DIET_FISH,
        ["Bread"] = _G.FOM_DIET_BREAD,
        ["Cheese"] = _G.FOM_DIET_CHEESE,
        ["Fruit"] = _G.FOM_DIET_FRUIT,
        ["Fungus"] = _G.FOM_DIET_FUNGUS,
        ["Mechanical Bits"] = _G.FOM_DIET_MECH,
    }
    assert(diets[diet], 'Invalid diet')
    return diets[diet]
end

function lib.getFoodList()
    local foods = {}
    for itemId, properties in pairs(_G.FOM_FoodInfo) do
        if properties['major'] <= WOW_MAJOR then
            local localizedDiet = lib.localizeDiet(properties['diet'])
            if foods[localizedDiet] == nil then
                foods[localizedDiet] = {}
            end
            foods[localizedDiet][itemId] = properties['priority']
        end
    end
    return foods
end

local foodList = lib.getFoodList()

---Check if the given foodItemID is in the given diet or the current pets diet if none is specified
---@param foodItemID number Food item ID
---@param dietList table Pass nil to query against current pet's diets
function lib.isInDiet(foodItemID, dietList)
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