local addon = _G.GFW_FeedOMatic
---@class FOM_Food
local lib = addon:NewModule("FOM_Food", "AceEvent-3.0")
---@type FOM_PetInfo
local petInfo = _G.GFW_FeedOMatic:GetModule("FOM_PetInfo")

local WOW_MAJOR = math.floor(tonumber(select(4, _G.GetBuildInfo()) / 10000))
local locale = _G.GetLocale()
local food_locale = _G.FOM_FoodLocale[locale]
local food_locale_reverse = {}

function lib:OnInitialize()
    for eng, loc in pairs(food_locale) do
        food_locale_reverse[loc] = eng
    end
end

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
    assert(food_locale[diet], ("Unable to localize diet %s"):format(diet))
    return food_locale[diet]
end

function lib.unLocalizeDiet(diet)
    if locale == 'enUS' then
        return diet
    end
    assert(food_locale_reverse[diet], ("Unable to unlocalize diet %s"):format(diet))
    return food_locale_reverse[diet]
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
---@return string Diet name in english or false if the item is not food
function lib.isKnownFood(itemID)
    if _G.FOM_FoodInfo[itemID] == nil then
        return false
    end
    return _G.FOM_FoodInfo[itemID]["diet"]
end