---@class FOMOptions
local options = _G.GFW_FeedOMatic:NewModule("FOMOptions", "AceEvent-3.0")
---@type feedButtonHelper
local feedButton = _G.GFW_FeedOMatic:GetModule("feedButtonHelper")
local reg = _G.LibStub("AceConfigRegistry-3.0")

local titleText = 'Feed-O-Matic'
local addon = _G.GFW_FeedOMatic
local L = _G.LibStub("AceLocale-3.0"):GetLocale("GFW_FeedOMatic")

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
    feedButton:updateFood()
end

local FOM_FOOD_QUALITY_INFO = L["Foods of a level closer to your pet's restore more health."] .. "\n"

options.options = {
    type = 'group',
    get = getProfileOption,
    set = setProfileOption,
    name = titleText,
    args = {
        general = {
            type = 'group',
            order = -1,
            name = L["General Options"],
            desc = "foo",
            args = {
                tips = {
                    type = "description",
                    name = L["To feed your pet with Feed-O-Matic, click the button next to your pet's health bar, bind a key to Feed Pet in the Key Bindings menu, or put '/click FOM_FeedButton' in a macro."],
                    order = 1,
                },
                tooltip = {
                    type = 'toggle',
                    order = 2,
                    width = "double",
                    name = L["Show food quality in tooltips"],
                    desc = FOM_FOOD_QUALITY_INFO .. L["If enabled, food item tooltips show a quick summary of how much the food will restore your pet's health."],
                    arg = "Tooltip",
                },
                useLowLevelFirst = {
                    type = 'toggle',
                    order = 3,
                    width = "double",
                    name = L["Prefer lower-level foods"],
                    desc = FOM_FOOD_QUALITY_INFO .. L["Enable this option and your pet will quickly dispose of lower-quality foods but require feeding more often.\nDisable it and your pet will require feeding less often, but your inventory may quickly fill with less-useful foods."],
                    arg = "UseLowLevelFirst",
                },
                avoidQuestFood = {
                    type = 'toggle',
                    order = 4,
                    width = "double",
                    name = L["Avoid foods needed for quests"],
                    desc = L["Some quests require collecting items which are also edible by pets. Enable this option to prevent your pet's appetite from interfering with your quest progress."],
                    arg = "AvoidQuestFood",
                },
                alertType = {
                    type = 'select',
                    order = 5,
                    name = L["Notify when feeding:"],
                    values = {
                        [1] = L["With an emote"],
                        [2] = L["In chat window"],
                        [3] = L["Don't notify"],
                    },
                    arg = "AlertType",
                },
                noButton = {
                    type = 'toggle',
                    order = 6,
                    width = "double",
                    name = L["Hide button"],
                    desc = L["Don't show the button Feed-O-Matic normally puts next to your pet's health bar.\n(You might find this option useful if using a UI that changes/hides the default pet frame.)"],
                    arg = "NoButton",
                    set = function(info, value)
                        if value then
                            feedButton.button:Hide()
                        else
                            feedButton.button:Show()
                        end
                        setProfileOption(info, value)
                    end
                },
                blank = {
                    type = "header",
                    name = L["Food Preferences"],
                    order = 10,
                },
                tipsFoods = {
                    type = "description",
                    name = L["Uncheck individual foods (or food categories) below to prevent Feed-O-Matic from feeding them to your pet.\nFeed-O-Matic will prefer to use foods from categories closer to the top of the list."],
                    order = 11,
                },
                showOnlyPetFoods = {
                    type = 'toggle',
                    order = 12,
                    width = "double",
                    name = L["Only show foods for my pet"],
                    desc = function()
                        if (_G.UnitExists("pet")) then
                            return _G.format(L["Filters the list to show only foods a level %d %s will eat"],
                                    _G.UnitLevel("pet"),
                                    _G.UnitCreatureFamily("pet")) .. "\n(" .. _G.FOM_GetColoredDiet() .. ")";
                        else
                            return _G.format(L["Filters the list to show only foods a level %d pet can eat"], _G.UnitLevel("player"));
                        end
                    end,
                    arg = "ShowOnlyPetFoods",
                },
                showOnlyInventory = {
                    type = 'toggle',
                    order = 13,
                    width = "double",
                    name = L["Only show foods in my inventory"],
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
            name = L["Hide Feed Pet button"],
            desc = L["Don't show the button Feed-O-Matic normally puts next to your pet's health bar.\n(You might find this option useful if using a UI that changes/hides the default pet frame.)"],
            arg = "NoButton",
            set = function(info, value)
                if value then
                    feedButton.button:Hide()
                else
                    feedButton.button:Show()
                end
                setProfileOption(info, value)
            end
        },
        positionHeader = {
            type = "header",
            name = L["Button position"],
            order = 9,
        },
        buttonX = {
            type = "input",
            name = L["X position"],
            arg = 'buttonX',
            order = 10,
            set = function(info, value)
                feedButton:setPosition(value, addon.db.profile['buttonY'], _G[addon.db.profile['buttonRelative']])
                setProfileOption(info, value)
            end
        },
        buttonY = {
            type = "input",
            name = L["Y position"],
            arg = 'buttonY',
            order = 11,
            set = function(info, value)
                feedButton:setPosition(addon.db.profile['buttonX'], value, _G[addon.db.profile['buttonRelative']])
                setProfileOption(info, value)
            end
        },
--[[        buttonRelative = {
            type = "input",
            name = L["Relative to frame"],
            arg = "buttonRelative",
            order = 12,
            set = function(info, value)
                feedButton:setPosition(addon.db.profile['buttonX'], addon.db.profile['buttonY'], _G[value])
                setProfileOption(info, value)
            end
        },]]
        resetPosition = {
            type = 'execute',
            name = L["Reset position"],
            order = 13,
            func = function()
                feedButton:resetPosition()
                reg:NotifyChange('Feed Button')
            end
        },
        sizeHeader = {
            type = "header",
            name = L["Button size"],
            order = 19,
        },
        buttonH = {
            type = 'range',
            name = L["Height"],
            arg = 'buttonH',
            order = 20,
            min = 10,
            max = 64,
            step = 1,
            set = function(info, value)
                local width = addon.db.profile['buttonW']
                setProfileOption(info, value)
                feedButton:setSize(value, width)
            end
        },
        buttonW = {
            type = 'range',
            name = L["Width"],
            arg = 'buttonW',
            order = 21,
            min = 10,
            max = 64,
            step = 1,
            set = function(info, value)
                local height = addon.db.profile['buttonH']
                setProfileOption(info, value)
                feedButton:setSize(height, value)
            end
        },
        resetSize = {
            type = 'execute',
            name = L["Reset size"],
            order = 22,
            func = function()
                local default = feedButton:getDefaultPosition()
                feedButton:setSize(default['h'], default['w'])
                reg:NotifyChange('Feed Button')
            end
        }
    },
}