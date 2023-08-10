---@class FeedOMatic
local addonName, addon = ...

local minor
---@type string Addon name
addon.name = addonName
addon.version = '@project-version@'
---@type BMUtils
addon.utils, minor = _G.LibStub("BM-utils-1")
assert(minor >= 8, ('BMUtils 1.8 or higher is required, found 1.%d'):format(minor))
---@type LibProfessions
addon.professions, minor = _G.LibStub('LibProfessions-0')
assert(minor >= 10, ('LibProfessions 0.10 or higher is required, found 0.%d'):format(minor))
addon.is_classic = addon.utils:IsWoWClassic()
---@type TableUtils
addon.tableUtils = {}
