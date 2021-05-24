---@type FeedOMatic
local _, addon = ...
---@class TableUtils
local tableUtils = addon.tableUtils

-- Merge: returns the union of two tables (without repeated elements)
function tableUtils:Merge(table1, table2)
    local newTable = { };
    if (table1) then
        for i=1, table.getn(table1) do
            table.insert(newTable, table1[i]);
        end
    end
    if (table2) then
        for i=1, table.getn(table2) do
            if (self:IndexOf(newTable, table2[i]) == 0) then
                table.insert(newTable, table2[i]);
            end
        end
    end
    return newTable;
end

-- IndexOf: returns the index (1-based) of an item in a table
function tableUtils:IndexOf(aTable, item)
    return self:KeyOf(aTable, item) or 0;
end

-- KeyOf: returns the key to an item in a table with numeric or non-numeric keys, or nil if not found
function tableUtils:KeyOf(aTable, item)
    if (aTable == nil or type(aTable) ~= "table") then
        return nil; -- caller probably won't expect this, causing traceable error in their code
    end
    for key, value in pairs(aTable) do
        if (item == value) then
            return key;
        end
    end
    return nil;
end
