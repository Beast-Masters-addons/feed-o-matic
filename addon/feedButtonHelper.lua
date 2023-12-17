---@class feedButtonHelper
local feedButtonHelper = _G.GFW_FeedOMatic:NewModule("feedButtonHelper", "AceEvent-3.0")

local FOM_FeedButton = _G.FOM_FeedButton

function feedButtonHelper.getDefaultPosition()
    if (_G.XPerl_Player_Pet ~= nil) then
        return {
            w = 27,
            h = 27,
            x = 20,
            y = -4,
            addon = 'Z-Perl',
            frame = _G.XPerl_Player_Pet
        }
    else
        return {
            w = 21,
            h = 20,
            x = -10,
            y = -15,
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
end

function feedButtonHelper.getSize()
    return FOM_FeedButton:GetWidth(), FOM_FeedButton:GetHeight()
end

function feedButtonHelper.setSize(height, width)
    FOM_FeedButton:SetHeight(height)
    FOM_FeedButton:SetWidth(width)
end