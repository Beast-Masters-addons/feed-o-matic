WOW_MAJOR = math.floor(tonumber(select(4, _G.GetBuildInfo()) / 10000))

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
