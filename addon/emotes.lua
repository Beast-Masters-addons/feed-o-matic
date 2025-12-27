local addonName = ...
local addon = _G.LibStub("AceAddon-3.0"):GetAddon(addonName)
---@class FOM_Emotes
local emotes = addon:NewModule("FOM_Emotes")
---@type TableUtils
local tableUtils = addon:GetModule("TableUtils")
---@type BMUtils
local utils = _G.LibStub("BMUtils")
---@type BMUtilsBasic
local basic = _G.LibStub("BMUtilsBasic")
---@type FOM_Food
local FOM_Food = _G.GFW_FeedOMatic:GetModule("FOM_Food")

local L = _G.LibStub("AceLocale-3.0"):GetLocale("GFW_FeedOMatic")

emotes.emotes = {

    ["any"] = {    -- emotes for any pet (don't localize this line!)
        L["Yum!"],
        L["Mmm, good stuff."],
        L["Hey! Watch the fingers!"],
        L["Om nom nom nom…"],
        L["One gulp and it's gone!"],
        L["Mmm, delicious."],
        L["Burp!"],
        L["Yay, bag space!"],
    },

    ["male"] = { -- emotes for any male pet (don't localize this line!)
        L["Good boy!"],
        L["Atta boy!"],
        L["No more Mister Grumpy!"],
    },
    ["female"] = { -- emotes for any female pet (don't localize this line!)
        L["Good girl!"],
        L["Atta girl!"],
        L["No more Miss Grumpy!"],
    },

    -- emotes for when eating specific foods
    -- number on first line is itemID (use an addon or Wowhead to find it)
    [7974] = {    -- Zesty Clam Meat
        L["Mmm, zesty!"],
    },
    [12037] = {    -- Mystery Meat
        L["Tastes like chicken."],
        L["Tastes like tallstrider!"],
        L["Tastes like well-aged gnome."],
        L["Tastes like… spider?"],
    },
    [44072] = {    -- Roasted Mystery Beast
        L["Tastes like chicken."],
        L["Tastes like tallstrider!"],
        L["Tastes like well-aged gnome."],
        L["Tastes like… spider?"],
    },
    [59232] = {    -- Unidentifiable Meat Dish
        L["Tastes like chicken."],
        L["Tastes like tallstrider!"],
        L["Tastes like well-aged gnome."],
        L["Tastes like… spider?"],
    },
    [12217] = { -- Dragonbreath Chili
        L["Yow, spicy!"],
    },
    [4538] = { -- Snapvine Watermelon
        L["What a big mouth!"],
    },
    [8950] = { -- Homemade Cherry Pie
        L["Tastes so good, makes a grown man cry."],
    },
    [27659] = { -- Warp Burger
        L["Now how about some Nether Ray Fries?"],
    },
    [41808] = { -- Bonescale Snapper
        L["Crunchy!"],
    },
    [41814] = { -- Glassfin Minnnow
        L["Can has bigger fish?"],
    },
    [43647] = { -- Shimmering Minnow
        L["Can has bigger fish?"],
    },

    -- emotes for categories of items
    -- use keys from LibPeriodicTable's Consumable.Food section
    -- TODO: need a PT-less way to key on both food diet and what we now call food type
    ["Consumable.Food.Edible.Bread.Conjured"] = {
        L["Tastes great, less filling!"],
    },
    ["Consumable.Food.Edible.Bread.Combo.Conjured"] = {
        L["Tastes great, less filling!"],
    },
    ["Consumable.Food.Inedible.Fish"] = {
        L["Mmm, sashimi!"],
    },

    -- emotes for entire diets
    ["Fungus"] = {
        L["Trippy…"],
    },

    -- emotes for specific pet families
    -- use keys from localization.lua
    ["Boar"] = {
        L["Good piggy!"],
    },
    ["Cat"] = {
        L["Nice kitty!"],
    },
    ["Hyena"] = {
        L["Good dog!"],
    },
    ["Wolf"] = {
        L["Good dog!"],
    },
    ["Spider"] = {
        L["Do you really have to wrap it up before eating it?"],
    },
    ["Raptor"] = {
        L["Down, dino!"],
    },
    ["Devilsaur"] = {
        L["Down, dino!"],
    },
    ["Crocolisk"] = {
        L["Crikey, it snapped that up fast!"],
    },
    ["Core Hound"] = {
        L["What a good little puppy!"],
        L["Aww, they're sharing."],
        L["Hey, don't fight over it!"],
    },
    ["Chimaera"] = {
        L["Hey, don't fight over it!"],
    },

};

function emotes:getRandomEmote(foodLink)
    local genericEmotes = self.emotes["any"]
    local petGender = UnitSex("pet")
    if petGender == 1 then
        petGender = UnitSex("player")
    end

    if petGender == 2 then
        genericEmotes = tableUtils:Merge(genericEmotes, self.emotes["male"])
    elseif petGender == 3 then
        genericEmotes = tableUtils:Merge(genericEmotes, self.emotes["female"])
    end

    local itemID = utils.itemIdFromLink(foodLink)
    local specificEmotes = {}
    if (itemID) then
        specificEmotes = tableUtils:Merge(specificEmotes, self.emotes[itemID])

        local diet = FOM_Food.isInDiet(itemID)
        specificEmotes = tableUtils:Merge(specificEmotes, self.emotes[diet])
    end

    specificEmotes = tableUtils:Merge(specificEmotes, self.emotes[UnitCreatureFamily("pet")])

    local randomEmotes
    if not basic.empty(specificEmotes) then
        randomEmotes = specificEmotes
    else
        randomEmotes = genericEmotes
    end
    return randomEmotes[math.random(table.getn(randomEmotes))]

end