_G['FEEDPET_LOG_FIRSTPERSON'] = 'Your pet begins eating the %s.'
_G.QuestDifficultyColors = {
    ["impossible"] = { r = 1.00, g = 0.10, b = 0.10, font = "QuestDifficulty_Impossible" };
    ["verydifficult"] = { r = 1.00, g = 0.50, b = 0.25, font = "QuestDifficulty_VeryDifficult" };
    ["difficult"] = { r = 1.00, g = 0.82, b = 0.00, font = "QuestDifficulty_Difficult" };
    ["standard"] = { r = 0.25, g = 0.75, b = 0.25, font = "QuestDifficulty_Standard" };
    ["trivial"] = { r = 0.50, g = 0.50, b = 0.50, font = "QuestDifficulty_Trivial" };
    ["header"] = { r = 0.70, g = 0.70, b = 0.70, font = "QuestDifficulty_Header" };
    ["disabled"] = { r = 0.498, g = 0.498, b = 0.498, font = "QuestDifficulty_Impossible" };
};

_G.C_AddOns = {}
function C_AddOns.GetAddOnMetadata(name, variable)
    local variables = {
        Title = "Fizzwidget Feed-O-Matic",
        Version = "1.0",
    }
    return variables[variable]

end

GetAddOnMetadata = C_AddOns.GetAddOnMetadata
_G.SPELLDISMISSPETSELF = "Your %s is dismissed."

function GetItemInfo(item)
    print('itemInf', item)
    if item == "Tiger Meat" then
        return "Tiger Meat", "|cffffffff|Hitem:12202::::::::80:::::|h[Tiger Meat]|h|r\");", 1, 30, 0
    end
end

