_G['FOMFoodLogger'] = {}
local log = _G['FOMFoodLogger']

function log.get(species, itemId)
    local statuses = {}
    for status, items in pairs(_G['FOM_FoodLog'][species]) do
        for itemId_iter, itemName in pairs(items) do
            if itemId_iter == itemId then
                statuses:insert(status)
            end
        end
    end
    return statuses
end

---Check if the food is known good for the given species
---@param itemId number Food item ID
---@param species string Pet species
function log.is_good(itemId, species)
    if species == nil then
        species = _G.UnitCreatureFamily("pet")
    end
    if _G['FOM_FoodLog'] == nil or _G['FOM_FoodLog'][species] == nil then
        return
    end

    for status, items in pairs(_G['FOM_FoodLog'][species]) do
        for itemId_iter, _ in pairs(items) do
            if itemId_iter == itemId then
                if status == 'good' then
                    --@debug@
                    print(('%d is known good for %s'):format(itemId, species))
                    --@end-debug@
                    return true
                elseif status == 'bad' then
                    --@debug@
                    print(('%d is known bad for %s'):format(itemId, species))
                    --@end-debug@
                    return false
                end
            end
        end
    end
end

function log.save(species, itemId, itemName, status)

    if _G['FOM_FoodLog'] == nil then
        _G['FOM_FoodLog'] = {}
    end
    if _G['FOM_FoodLog'][species] == nil then
        _G['FOM_FoodLog'][species] = {}
    end
    if _G['FOM_FoodLog'][species][status] == nil then
        _G['FOM_FoodLog'][species][status] = {}
    end
    if _G['FOM_FoodLog'][species][status][itemId] == nil then
        _G['FOM_FoodLog'][species][status][itemId] = itemName
    end
    --@debug@
    print(('Saved food %d with status %s for %s'):format(itemId, status, species))
    --@end-debug@
end