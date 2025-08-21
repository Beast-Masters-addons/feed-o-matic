local lu = require('luaunit')

loadfile('build_utils/utils/load_toc.lua')('./test.toc')
loadfile('build_utils/utils/load_toc.lua')('../GFW_FeedOMatic.toc')
local addon = _G.GFW_FeedOMatic
---@type FOM_PetInfo
local info = addon:GetModule('FOM_PetInfo')
---@type FOM_FoodLogger
local foodLog = addon:GetModule("FOM_FoodLogger")
---@type FOM_Food
local food = addon:GetModule("FOM_Food")

_G['test'] = {}
local test = _G['test']

function test:testSaveFood()
    local message = 'Your pet begins eating the Tiger Meat.'
    local item = foodLog.get('Bear', 12202)
    lu.assertNil(item)
    info:OnEnable()
    info.petFamily = "Bear"
    info.petLevel = 70
    info:CHAT_MSG_PET_INFO('CHAT_MSG_PET_INFO', message)
    local item2 = foodLog.get('Bear', 12202)
    lu.assertTrue(foodLog.is_good(12202, 'Bear'))
end

function test:testIsKnownFood()
    lu.assertEquals(food.isKnownFood(12202), "Meat")
    lu.assertEquals(food.isKnownFood(13546), "Fish")
    lu.assertNil(food.isKnownFood(99999))
end

os.exit(lu.LuaUnit.run())