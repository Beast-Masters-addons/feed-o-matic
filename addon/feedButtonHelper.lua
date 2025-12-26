---@class feedButtonHelper
local feedButtonHelper = _G.GFW_FeedOMatic:NewModule("feedButtonHelper", "AceEvent-3.0")
local addon = _G.GFW_FeedOMatic

local FOM_FEED_PET_SPELL_ID = 6991

function feedButtonHelper:OnInitialize()
    --[[    if not _G.IsPlayerSpell(FOM_FEED_PET_SPELL_ID) then
            return
        end]]
    local pos = self.getDefaultPosition()
    ---@type SpellButton
    self.button = _G.LibStub('LibSpellButton-1').CreateSpellButton(FOM_FEED_PET_SPELL_ID, "FeedPetButton", pos['h'], pos['w'])
    self.button:setPoint("LEFT", pos['frame'], "RIGHT", pos['x'], pos['y']);
    self.button:setScript("OnEnter", _G.FOM_FeedButton_OnEnter);
    self.button:setScript("OnLeave", _G.FOM_FeedButton_OnLeave);
end

function feedButtonHelper.getDefaultPosition()
    if (_G.XPerl_Player_Pet ~= nil) then
        return {
            w = 27,
            h = 27,
            x = 20,
            y = 0,
            addon = 'Z-Perl',
            frame = _G.XPerl_Player_Pet
        }
    end
    if _G.SUI_UF_pet ~= nil then
        return {
            w = 24,
            h = 24,
            x = 0,
            y = 0,
            addon = 'SpartanUI',
            frame = _G.SUI_UF_pet
        }
    end
    if _G.ElvUF_Pet ~= nil then
        return {
            w = 24,
            h = 24,
            x = 8,
            y = -1,
            addon = 'ElvUI',
            frame = _G.ElvUF_Pet
        }
    end
    if _G.PetFrameHappiness ~= nil then
        --Classic with happiness
        return {
            w = _G.PetFrameHappiness:GetWidth(),
            h = _G.PetFrameHappiness:GetHeight(),
            x = 5,
            y = 0,
            addon = 'Classic',
            frame = _G.PetFrameHappiness
        }
    else
        -- Retail without happiness
        return {
            w = 25,
            h = 25,
            x = 10,
            y = 0,
            addon = 'Retail',
            frame = _G.PetFrame,
        }
    end
end

function feedButtonHelper:getPosition()
    return self.button:getPosition()
end

---Set feed pet button position
---@param x number
---@param y number
---@param relative Frame
function feedButtonHelper:setPosition(x, y, relative)
    local point = 'TOPLEFT'
    local relativeToPoint = 'TOPLEFT'
    if relative ~= nil then
        point = 'LEFT'
        relativeToPoint = 'RIGHT'
        --@debug@
        print(('Set feed button to position X %d Y %d relative to %s'):format(x, y, relative:GetName()))
        --@end-debug@
    else
        --@debug@
        print(('Set feed button to absolute position X %d Y %d'):format(x, y))
        --@end-debug@
    end

    self.button.btn:ClearAllPoints()
    self.button:setPoint(point, relative, relativeToPoint, x, y)

    addon.db.profile['buttonX'] = x
    addon.db.profile['buttonY'] = y
end

---Reset button position
function feedButtonHelper:resetPosition()
    local default = self.getDefaultPosition()
    --@debug@
    print('Set Feed Pet button position to default', default['x'], default['y'], default['frame'])
    --@end-debug@
    self:setPosition(default['x'], default['y'], default['frame'])
    addon.db.profile['buttonRelative'] = default['frame']:GetName()
end

function feedButtonHelper:getSize()
    return self.button.btn:GetSize()
end

function feedButtonHelper:setSize(height, width)
    self.button.btn:SetSize(width, height)
    addon.db.profile['buttonH'] = height
    addon.db.profile['buttonW'] = width
end

function feedButtonHelper:resetSize()
    local default = self.getDefaultPosition()
    --@debug@
    print('Set Feed Pet button size to default', default['h'], default['w'])
    --@end-debug@
    self:setSize(default['h'], default['w'])
end

---Toggle feed button visibility
function feedButtonHelper:toggle()
    if (addon.db.profile.NoButton) then
        self.button:Hide();
        addon.db.profile.NoButton = true
    else
        self.button:Show();
        addon.db.profile.NoButton = false
    end
end

function feedButtonHelper:setFood(bag, slot, modifier)
    if bag == nil then
        self.button:setCount("")
    else
        self.button:setItem(bag, slot)
    end
end

function feedButtonHelper:updateFood()
    local foodBag, foodSlot, FOM_NextFoodLink, foodIcon = _G.FOM_NewFindFood();
    if foodBag == nil then
        foodBag, foodSlot, FOM_NextFoodLink, foodIcon = _G.FOM_NewFindFood(true);
        self:setFood(foodBag, foodSlot, "alt");
    else
        self:setFood(foodBag, foodSlot)
    end
end

function feedButtonHelper:SetScript(event, callback)
    self.button.btn:SetScript(event, callback)
end

function feedButtonHelper:SetVertexColor(r, g, b)
    self.button.icon:SetVertexColor(r, g, b)
end
