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

FOM_CategoryNames = { -- localized keys for FOM_FoodTypes indexes
    FOM_OPTIONS_FOODS_CONJURED,
    FOM_OPTIONS_FOODS_BASIC,
    FOM_OPTIONS_FOODS_BONUS,
    FOM_OPTIONS_FOODS_INEDIBLE,
};

FOM_DietColors = { -- convenient reuse of familiar colors?
    [FOM_DIET_MEAT]		= RAID_CLASS_COLORS.DEATHKNIGHT,
    [FOM_DIET_FISH]		= RAID_CLASS_COLORS.PALADIN,
    [FOM_DIET_BREAD]	= RAID_CLASS_COLORS.ROGUE,
    [FOM_DIET_CHEESE]	= RAID_CLASS_COLORS.WARRIOR,
    [FOM_DIET_FRUIT]	= RAID_CLASS_COLORS.DRUID,
    [FOM_DIET_FUNGUS]	= RAID_CLASS_COLORS.WARLOCK,
    [FOM_DIET_MECH]		= RAID_CLASS_COLORS.PRIEST,
};
