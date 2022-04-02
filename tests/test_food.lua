local lu = require('luaunit')
loadfile('wow_constants.lua')()
loadfile('../addon/utils.lua')()

_G['test'] = {}
local test = _G['test']

function test:testParseFood()
    local message = 'Your pet begins eating the Tiger Meat.'
    local food = _G['FOMUtils'].get_feed_item(message)
    lu.assertEquals(food, 'Tiger Meat')
end

os.exit(lu.LuaUnit.run())