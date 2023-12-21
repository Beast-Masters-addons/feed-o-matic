---@class feedButtonHelper
local feedButtonHelper = _G.GFW_FeedOMatic:NewModule("feedButtonHelper", "AceEvent-3.0")
local addon = _G.GFW_FeedOMatic

local FOM_FeedButton

function feedButtonHelper.OnEnable()
    FOM_FeedButton = _G.FOM_FeedButton
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
    if _G.PetFrameHappiness ~= nil then
        --Classic with happiness
        return {
            w = _G.PetFrameHappiness:GetWidth(),
            h = _G.PetFrameHappiness:GetHeight(),
            x = 5,
            y = 0,
            frame = _G.PetFrameHappiness
        }
    else
        -- Retail without happiness
        return {
            w = 25,
            h = 25,
            x = 10,
            y = 0,
            frame = _G.PetFrame,
        }
    end
end

function feedButtonHelper.getPosition()
    local point, relativeTo, relativePoint, offsetX, offsetY = FOM_FeedButton:GetPoint(1)
    --@debug@
    print('Button position', point, relativeTo, relativePoint, offsetX, offsetY)
    --@end-debug@
    return ('%d'):format(offsetX), ('%d'):format(offsetY)
end

---setPosition
---@param x number
---@param y number
---@param relative Frame
function feedButtonHelper.setPosition(x, y, relative)
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
        print(('Set feed button to position X %d Y %d'):format(x, y))
        --@end-debug@
    end
    --FOM_FeedButton:SetPoint("LEFT", PetFrame, "RIGHT", -10, -15);

    FOM_FeedButton:ClearAllPoints()
    FOM_FeedButton:SetPoint(point, relative, relativeToPoint, x, y)

    addon.db.profile['buttonX'] = x
    addon.db.profile['buttonY'] = y
end

function feedButtonHelper.getSize()
    return FOM_FeedButton:GetWidth(), FOM_FeedButton:GetHeight()
end

function feedButtonHelper.setSize(height, width)
    FOM_FeedButton:SetHeight(height)
    FOM_FeedButton:SetWidth(width)
    addon.db.profile['buttonH'] = height
    addon.db.profile['buttonW'] = width
end