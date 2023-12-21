---@class FOMOptions
local options = _G.GFW_FeedOMatic:NewModule("FOMOptions", "AceEvent-3.0")
---@type feedButtonHelper
local feedButton = _G.GFW_FeedOMatic:GetModule("feedButtonHelper")
local reg = _G.LibStub("AceConfigRegistry-3.0")

local titleText = 'Feed-O-Matic'
local addon = _G.GFW_FeedOMatic

local function getProfileOption(info)
    --print('Get option', info.arg, addon.db.profile[info.arg])
    if info.type == 'input' and type(addon.db.profile[info.arg]) == 'number' then
        return tostring(addon.db.profile[info.arg])
    end
    return addon.db.profile[info.arg]
end

local function setProfileOption(info, value)
    addon.db.profile[info.arg] = value

    if (_G.FOM_FoodListBorder and _G.FOM_FoodListBorder:IsVisible()) then
        _G.FOM_FoodListUI_UpdateList();
    end
    if (_G.InCombatLockdown()) then
        _G.FOM_PickFoodQueued = true;
    else
        _G.FOM_PickFoodForButton();
    end
end

function options.notifyChange()
    reg:NotifyChange('Feed Button')
end

options.options = {
    type = 'group',
    get = getProfileOption,
    set = setProfileOption,
    name = titleText,
    args = {
        general = {
            type = 'group',
            order = -1,
            name = _G.FOM_OPTIONS_GENERAL,
            desc = "foo",
            args = {
                tips = {
                    type = "description",
                    name = _G.FOM_OPTIONS_SUBTEXT,
                    order = 1,
                },
                tooltip = {
                    type = 'toggle',
                    order = 2,
                    width = "double",
                    name = _G.FOM_OPTIONS_TOOLTIP,
                    desc = _G.FOM_OPTIONS_TOOLTIP_TIP,
                    arg = "Tooltip",
                },
                useLowLevelFirst = {
                    type = 'toggle',
                    order = 3,
                    width = "double",
                    name = _G.FOM_OPTIONS_LOW_LVL_1ST,
                    desc = _G.FOM_OPTIONS_LOW_LVL_1ST_TIP,
                    arg = "UseLowLevelFirst",
                },
                avoidQuestFood = {
                    type = 'toggle',
                    order = 4,
                    width = "double",
                    name = _G.FOM_OPTIONS_AVOID_QUEST,
                    desc = _G.FOM_OPTIONS_AVOID_QUEST_TIP,
                    arg = "AvoidQuestFood",
                },
                alertType = {
                    type = 'select',
                    order = 5,
                    name = _G.FOM_OPTIONS_FEED_NOTIFY,
                    values = {
                        [1] = _G.FOM_OPTIONS_NOTIFY_EMOTE,
                        [2] = _G.FOM_OPTIONS_NOTIFY_TEXT,
                        [3] = _G.FOM_OPTIONS_NOTIFY_NONE,
                    },
                    arg = "AlertType",
                },
                noButton = {
                    type = 'toggle',
                    order = 6,
                    width = "double",
                    name = _G.FOM_OPTIONS_NO_BUTTON,
                    desc = _G.FOM_OPTIONS_NO_BUTTON_TIP,
                    arg = "NoButton",
                    set = function(self, value)
                        setProfileOption(self, value)
                        if (addon.db.profile.NoButton) then
                            _G.FOM_FeedButton:Hide();
                        else
                            _G.FOM_FeedButton:Show();
                        end
                    end
                },
                blank = {
                    type = "header",
                    name = _G.FOM_OPTIONS_FOODS_TITLE,
                    order = 10,
                },
                tipsFoods = {
                    type = "description",
                    name = _G.FOM_OPTIONS_FOODS_TEXT,
                    order = 11,
                },
                showOnlyPetFoods = {
                    type = 'toggle',
                    order = 12,
                    width = "double",
                    name = _G.FOM_OPTIONS_FOODS_ONLY_PET,
                    desc = function()
                        if (_G.UnitExists("pet")) then
                            return _G.format(_G.FOM_OPTIONS_FOODS_ONLY_PET_TIP,
                                    _G.UnitLevel("pet"),
                                    _G.UnitCreatureFamily("pet")) .. "\n(" .. _G.FOM_GetColoredDiet() .. ")";
                        else
                            return _G.format(_G.FOM_OPTIONS_FOODS_ONLY_LVL_TIP, _G.UnitLevel("player"));
                        end
                    end,
                    arg = "ShowOnlyPetFoods",
                },
                showOnlyInventory = {
                    type = 'toggle',
                    order = 13,
                    width = "double",
                    name = _G.FOM_OPTIONS_FOODS_ONLY_INV,
                    arg = "ShowOnlyInventory",
                },
            },
        },
    },
}

options.feedButtonOptions = {
    type = "group",
    set = setProfileOption,
    get = getProfileOption,
    name = "Feed Pet button",
    args = {
        noButton = {
            type = 'toggle',
            order = 6,
            width = "double",
            name = _G.FOM_OPTIONS_NO_BUTTON,
            desc = _G.FOM_OPTIONS_NO_BUTTON_TIP,
            arg = "NoButton",
            set = function()
                feedButton.toggle()
            end
        },
        buttonX = {
            type = "input",
            name = "Feed button X position",
            arg = 'buttonX',
            order = 10,
        },
        buttonY = {
            type = "input",
            name = "Feed button Y position",
            arg = 'buttonY',
            order = 11,
        },
        buttonH = {
            type = 'range',
            name = "Height",
            arg = 'buttonH',
            order = 20,
            min = 10,
            max = 60,
            step = 1,
            set = function(info, value)
                local width = addon.db.profile['buttonW']
                setProfileOption(info, value)
                feedButton.setSize(value, width)
            end
        },
        buttonW = {
            type = 'range',
            name = "Width",
            arg = 'buttonW',
            order = 21,
            min = 10,
            max = 60,
            step = 1,
            set = function(info, value)
                local height = addon.db.profile['buttonH']
                setProfileOption(info, value)
                feedButton.setSize(height, value)
            end
        },

        resetPosition = {
            type = 'execute',
            name = 'Reset button position',
            order = 30,
            func = function()
                feedButton.resetPosition()
                reg:NotifyChange('Feed Button')
            end
        },
        resetSize = {
            type = 'execute',
            name = 'Reset button size',
            order = 31,
            func = function()
                local default = feedButton.getDefaultPosition()
                feedButton.setSize(default['h'], default['w'])
                reg:NotifyChange('Feed Button')
            end
        }
    },
}