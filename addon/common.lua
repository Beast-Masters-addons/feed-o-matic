---@class FeedOMatic
local addonName, addon = ...
---@type string Addon name
addon.name = addonName
addon.version = '@project-version@'
---@type BMUtils
addon.utils = _G.LibStub("BM-utils-1")
---@type LibProfessions
addon.professions = _G.LibStub('LibProfessions-0', 10)
addon.is_classic = addon.utils:IsWoWClassic()
---@type TableUtils
addon.tableUtils = {}
