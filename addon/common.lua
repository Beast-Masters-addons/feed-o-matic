---@class FeedOMatic
local addonName, addon = ...

local minor
---@type string Addon name
addon.name = addonName
addon.version = '@project-version@'
---@type LibProfessions
addon.professions, minor = _G.LibStub('LibProfessions-0')
assert(minor >= 10, ('LibProfessions 0.10 or higher is required, found 0.%d'):format(minor))

-- AceAddon Initialization
local ace_addon = _G.LibStub("AceAddon-3.0"):NewAddon(addonName)
ace_addon.title = _G.C_AddOns.GetAddOnMetadata(addonName, "Title")
ace_addon.version = _G.C_AddOns.GetAddOnMetadata(addonName, "Version")

local _, realClass = _G.UnitClass("player");
ace_addon.is_hunter = realClass == "HUNTER"

_G.GFW_FeedOMatic = ace_addon