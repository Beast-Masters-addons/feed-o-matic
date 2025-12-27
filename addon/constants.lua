local addonName = ...
local addon = _G.LibStub("AceAddon-3.0"):GetAddon(addonName)
---@class FOM_Constants
local const = addon:NewModule("FOM_Constants")
local L = _G.LibStub("AceLocale-3.0"):GetLocale("GFW_FeedOMatic")

WOW_MAJOR = math.floor(tonumber(select(4, _G.GetBuildInfo()) / 10000))


-- Food quality by itemLevel
--
-- levelDelta = petLevel - foodItemLevel
-- levelDelta > 30 = won't eat
FOM_DELTA_EATS = 30;    -- 30 >= levelDelta > 20 = 8 happiness per tick
FOM_DELTA_LIKES = 20;   -- 20 >= levelDelta > 10 = 17 happiness per tick
FOM_DELTA_LOVES = 10;   -- 10 >= levelDelta = 35 happiness per tick

-- constants
MAX_KEEPOPEN_SLOTS = 150;
FOM_FEED_PET_SPELL_ID = 6991;

FOM_DifficultyColors = {
    QuestDifficultyColors["trivial"],
    QuestDifficultyColors["standard"],
    QuestDifficultyColors["difficult"],
    QuestDifficultyColors["verydifficult"],
    QuestDifficultyColors["impossible"],
};

const.FOM_CategoryNames = { -- localized keys for FOM_FoodTypes indexes
    L["Conjured Foods"],
    L["Basic Foods"],
    L["“Well Fed” Foods"],
    L["Raw Foods"],
};

FOM_DietColors = { -- convenient reuse of familiar colors?
    ["Meat"]		= RAID_CLASS_COLORS.DEATHKNIGHT,
    ["Raw Meat"] = RAID_CLASS_COLORS.DEATHKNIGHT,
    ["Fish"]		= RAID_CLASS_COLORS.PALADIN,
    ["Raw Fish"]	= RAID_CLASS_COLORS.PALADIN,
    ["Bread"]	= RAID_CLASS_COLORS.ROGUE,
    ["Cheese"]	= RAID_CLASS_COLORS.WARRIOR,
    ["Fruit"]	= RAID_CLASS_COLORS.DRUID,
    ["Fungus"]	= RAID_CLASS_COLORS.WARLOCK,
    ["Mechanical Bits"]		= RAID_CLASS_COLORS.PRIEST,
};

FOM_DIFFICULTY_1   				= L["Trivial"]
FOM_DIFFICULTY_2   				= L["Easy"]
FOM_DIFFICULTY_3				= L["Medium"]
FOM_DIFFICULTY_4				= L["Difficult"]
FOM_DIFFICULTY_5	   			= L["Unknown"]