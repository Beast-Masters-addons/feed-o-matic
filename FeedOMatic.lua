------------------------------------------------------
-- FeedOMatic.lua
------------------------------------------------------
---@type FeedOMatic
local addonName, addon = ...
_G['FeedOMatic'] = {}

local tableUtils = addon.tableUtils
---@type BMUtils
local utils = addon.utils
local is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE

local C_Container = _G.C_Container

---@type feedButtonHelper
local feedButton = _G.GFW_FeedOMatic:GetModule("feedButtonHelper")

-- letting these be global inside Ace callbacks causes bugs
local FOM_Config, FOM_CategoryNames, FOM_FoodsUIList
---@type FOMOptions
local FOMOptions = _G.GFW_FeedOMatic:GetModule("FOMOptions")
---@type FOM_FoodLogger
local foodLogger = _G.GFW_FeedOMatic:GetModule("FOM_FoodLogger")
---@type FOM_ItemTooltip
local itemTooltip = _G.GFW_FeedOMatic:GetModule("FOM_ItemTooltip")
---@type FOM_PetInfo
local petInfo = _G.GFW_FeedOMatic:GetModule("FOM_PetInfo")
---@type FOM_Food
local FOM_Food =  _G.GFW_FeedOMatic:GetModule("FOM_Food")

-- Food quality by itemLevel
--
-- levelDelta = petLevel - foodItemLevel
-- levelDelta > 30 = won't eat
FOM_DELTA_EATS = 30;	-- 30 >= levelDelta > 20 = 8 happiness per tick
FOM_DELTA_LIKES = 20;   -- 20 >= levelDelta > 10 = 17 happiness per tick
FOM_DELTA_LOVES = 10;   -- 10 >= levelDelta = 35 happiness per tick

-- constants
MAX_KEEPOPEN_SLOTS = 150;
FOM_FEED_PET_SPELL_ID = 6991;
addon.utils:SetDefaultFontColor {0.25, 1.0, 1.0};

-- Variables
FOM_LastPetName = nil;
local foodBag, foodSlot, foodIcon;
local FOM_Foods = FOM_Food.getFoodList()

if utils:empty(FOM_Foods) then
	error('Food list empty')
end

function FOM_FeedButton_PreClick(self)
	local bag = self:GetAttribute('target-bag')
	local slot = self:GetAttribute('target-slot')
	if bag == nil or slot == nil then
		return
	end
	local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
	_G['FOMFeedItemId'] = itemInfo['itemID']
	_G['FOMFeedItemLink'] = itemInfo['hyperlink']
	_G['FOMButtonPressed'] = true
end

function FOM_FeedButton_PostClick(self, button, down)
	if (not FOM_GetFeedPetSpellName()) then
		local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata
		local version = GetAddOnMetadata(addonName, "Version");
		local level = GetSpellLevelLearned(slotID);
		local diagnostic = "";
		if ( level and level > UnitLevel("player") ) then
			diagnostic = "This spell requires level "..level..".";
		end
		GFWUtils.PrintOnce(GFWUtils.Red("Feed-O-Matic v."..version.." error:").."Can't find Feed Pet spell. "..diagnostic);
		return;
	end
	if (not down) then
		if (button == "RightButton") then
			GFW_FeedOMatic:ShowConfig();
		elseif (FOM_NextFoodLink and not FOM_NoFoodError and not InCombatLockdown()) then
			-- successful feed, messages are produced elsewhere
		elseif (FOM_NoFoodError and not IsAltKeyDown()) then
			if (FOM_NextFoodLink) then
				GFWUtils.Note(FOM_NoFoodError.."\n"..string.format(FOM_FALLBACK_MESSAGE, FOM_NextFoodLink));
			else
				GFWUtils.Note(FOM_NoFoodError);
			end
		end
	end
end

function FOM_GetColoredDiet()
	local dietList = petInfo.petDiet;
	local coloredDiets = {};
	for _, dietName in pairs(dietList) do
		local color = FOM_DietColors[dietName];
		local coloredText = CreateColor(color.r, color.g, color.b):WrapTextInColorCode(dietName);
		table.insert(coloredDiets, coloredText);
	end
	return table.concat(coloredDiets, ", ");
end

function FOM_FeedButton_OnEnter()
	if (FOM_Config.NoFeedButtonTooltip) then return; end

	FOM_FeedTooltip:SetOwner(FOM_FeedButton, "ANCHOR_RIGHT");
	local blankLine = false;
	local linesAdded = 0;
	if (FOM_NextFoodLink) then

		-- food to be used on click
		local itemName = utils:ItemNameFromLink(FOM_NextFoodLink)
		FOM_FeedTooltip:SetBagItem(foodBag, foodSlot, itemName);

		if (FOM_NoFoodError) then
			-- fallback instructions
			FOM_FeedTooltipHeader:SetText(FOM_BUTTON_TOOLTIP1_FALLBACK);
			FOM_FeedTooltip:AddLine(" ");
			blankLine = true;
			FOM_FeedTooltip:AddLine(FOM_NoFoodError, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1);
			linesAdded = linesAdded + 1;
		else
			-- left click to feed
			FOM_FeedTooltipHeader:SetText(FOM_BUTTON_TOOLTIP1);
		end
	else
		-- no food
		FOM_FeedTooltipHeader:SetText(FOM_BUTTON_TOOLTIP_NOFOOD);
		blankLine = true;
		FOM_FeedTooltip:AddLine(FOM_NoFoodError, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1);
		linesAdded = linesAdded + 1;
	end
	if (not blankLine) then
		FOM_FeedTooltip:AddLine(" ");
	end

	-- diet summary
	FOM_FeedTooltip:AddDoubleLine(string.format(FOM_BUTTON_TOOLTIP_DIET, UnitName("pet")), FOM_GetColoredDiet());
	linesAdded = linesAdded + 1;

	-- right click for options
	FOM_FeedTooltip:AddLine(FOM_BUTTON_TOOLTIP2, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	linesAdded = linesAdded + 1;

	-- putting an item in the tooltip shrinks all further text
	-- set it back only if we've set an item
	if (FOM_NextFoodLink) then
		local numLines = FOM_FeedTooltip:NumLines();
		for lineNum = numLines - linesAdded + 1, numLines do
			local line = _G["FOM_FeedTooltipTextLeft"..lineNum];
			local r, g, b, a = line:GetTextColor();
			line:SetFontObject("GameFontNormal");
			line:SetTextColor(r, g, b, a);
		end
	end
	FOM_TooltipDebug();

	FOM_FeedTooltip:Show();

	-- muck with our special tooltip so it looks right
	FOM_FeedTooltip:SetHeight(FOM_FeedTooltip:GetHeight() + 12 + FOM_FeedTooltipHeader:GetHeight());
	FOM_FeedTooltipTextLeft1:SetFontObject("GameFontNormal");
	FOM_FeedTooltipTextLeft1:ClearAllPoints();
	FOM_FeedTooltipTextLeft1:SetPoint("TOPLEFT", FOM_FeedTooltipHeader, "BOTTOMLEFT", 0, -12);
	FOM_FeedTooltipTextLeft1:SetJustifyH("LEFT");
	FOM_FeedTooltipTextLeft2:SetJustifyH("LEFT");
	FOM_FeedTooltipTextLeft3:SetJustifyH("LEFT");
	FOM_FeedTooltipTextLeft4:SetJustifyH("LEFT");

end

function FOM_TooltipDebug()
	-- old
	if (FOM_Debug) then
		FOM_FeedTooltip:AddLine(" ");
		FOM_FeedTooltip:AddLine("Next Foods:");
		for _, foodInfo in pairs(SortedFoodList) do
			local line = string.format("%dx%s (bag %d, slot %d)", foodInfo.count, foodInfo.link, foodInfo.bag, foodInfo.slot);
			if (foodInfo.useful) then
				line = line .. " (useful)";
			end
			if (foodInfo.temp) then
				line = line .. " (temp)";
			end
			local color;
			if (foodInfo.delta > FOM_DELTA_EATS) then
				color = QuestDifficultyColors["trivial"];
			elseif (foodInfo.delta > FOM_DELTA_LIKES and foodInfo.delta <= FOM_DELTA_EATS) then
				color = QuestDifficultyColors["standard"];
			elseif (foodInfo.delta > FOM_DELTA_LOVES and foodInfo.delta <= FOM_DELTA_LIKES) then
				color = QuestDifficultyColors["difficult"];
			elseif (foodInfo.delta <= FOM_DELTA_LOVES) then
				color = QuestDifficultyColors["verydifficult"];
			end
			FOM_FeedTooltip:AddLine(line, color.r, color.g, color.b);
		end
	end
end

function FOM_FeedButton_OnLeave()
	FOM_FeedTooltip:Hide();
end

function FOM_OnLoad(self)

	-- Register for Events
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("SPELLS_CHANGED");

	-- Register Slash Commands
	SLASH_FEEDOMATIC1 = "/feedomatic";
	SLASH_FEEDOMATIC2 = "/fom";
	SLASH_FEEDOMATIC3 = "/feed";
	SLASH_FEEDOMATIC4 = "/petfeed"; -- Rauen's PetFeed compatibility
	SLASH_FEEDOMATIC5 = "/pf";
	SlashCmdList["FEEDOMATIC"] = function(msg)
		FOM_ChatCommandHandler(msg);
	end

	BINDING_HEADER_GFW_FEEDOMATIC = GetAddOnMetadata(addonName, "Title"); -- gets us the localized title if needed

	--@debug@
	GFWUtils.Debug = true;
	--@end-debug@

end

function FOM_HookTooltip(frame)
	if (frame:GetScript("OnTooltipSetItem")) then
		frame:HookScript("OnTooltipSetItem", FOM_OnTooltipSetItem);
	else
		frame:SetScript("OnTooltipSetItem", FOM_OnTooltipSetItem);
	end
end

---@param self Frame
function FOM_OnTooltipSetItem(self)

	if FOM_Config.Tooltip then
		local _, link = self:GetItem();
		if not link then return false; end

		local itemID = utils:ItemIdFromLink(link);
		local foodDiet = FOM_Food.isKnownFood(itemID);
		if not foodDiet then return false; end

		-- if edible at all, label diet in tooltip
		local color = FOM_DietColors[foodDiet];
		local coloredText = CreateColor(color.r, color.g, color.b):WrapTextInColorCode(foodDiet);
		local label = _G[self:GetName().."TextRight1"]
		label:SetText(coloredText);
		label:Show();

		-- if edible by current pet, add line for quality
		if (link and UnitExists("pet")) then
			for _, petDiet in pairs(petInfo.petDiet) do
				if petDiet == foodDiet then
					return FOM_TooltipAddFoodQuality(self, itemID);
				end
			end
			return true;
		end
	else
		return false;
	end

end

function FOM_TooltipAddFoodQuality(self, itemID)
	local _, _, _, itemLevel = GetItemInfo(itemID);
	if (itemLevel) then
		local levelDelta = petInfo.petLevel - itemLevel;
		local petName = petInfo.petName
		if (levelDelta >= FOM_DELTA_EATS) then
			color = QuestDifficultyColors["trivial"];
			self:AddLine(string.format(FOM_QUALITY_UNDER, petName), color.r, color.g, color.b);
			return true;
		elseif (levelDelta >= FOM_DELTA_LIKES and levelDelta < FOM_DELTA_EATS) then
			color = QuestDifficultyColors["standard"];
			self:AddLine(string.format(FOM_QUALITY_WILL, petName), color.r, color.g, color.b);
			return true;
		elseif (levelDelta >= FOM_DELTA_LOVES and levelDelta < FOM_DELTA_LIKES) then
			color = QuestDifficultyColors["difficult"];
			self:AddLine(string.format(FOM_QUALITY_LIKE, petName), color.r, color.g, color.b);
			return true;
		elseif (levelDelta < FOM_DELTA_LOVES) then
			color = QuestDifficultyColors["verydifficult"];
			self:AddLine(string.format(FOM_QUALITY_LOVE, petName), color.r, color.g, color.b);
			return true;
		end
	end
end

function FOM_GetFeedPetSpellName()
	-- we can get the spell name from the ID
	local _;
	FOM_FeedPetSpellName, _, FOM_FeedPetSpellIcon = GetSpellInfo(FOM_FEED_PET_SPELL_ID);

	BINDING_NAME_FOM_FEED = FOM_FeedPetSpellName;

	-- but we also want to know whether the player knows the spell
	if (IsPlayerSpell(FOM_FEED_PET_SPELL_ID)) then
		return FOM_FeedPetSpellName;
	end

	return nil;
end

function FOM_Initialize(self)

	local _, realClass = UnitClass("player");
	if (realClass ~= "HUNTER") then
		self:UnregisterAllEvents();
		return;
	end

	if (UnitLevel("player") < 10) then return; end

	-- track whether foods are useful for Cooking
	self:RegisterEvent("TRADE_SKILL_SHOW");
	self:RegisterEvent("TRADE_SKILL_DATA_SOURCE_CHANGED");
	self:RegisterEvent("TRADE_SKILL_LIST_UPDATE");
	self:RegisterEvent("TRADE_SKILL_DETAILS_UPDATE");

	-- Catch when feeding happened so we can notify/emote
	self:RegisterEvent("CHAT_MSG_PET_INFO");

	-- Only subscribe to inventory updates once we're in the world
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");

	-- Events for trying to catch when the pet needs feeding
	self:RegisterEvent("UNIT_PET");
	self:RegisterEvent("PET_BAR_SHOWGRID");
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("PET_BAR_UPDATE");
	self:RegisterEvent("PET_UI_UPDATE");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");

	-- events for managing feed button
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("SPELL_UPDATE_USABLE");


	local defaultPosition = feedButton.getDefaultPosition()
	local feedButtonParentFrame, feedButtonX, feedButtonY
	if FOM_Config.buttonX == nil or FOM_Config.buttonY == nil then
		feedButtonParentFrame = defaultPosition['frame']
		feedButtonX = defaultPosition['x']
		feedButtonY = defaultPosition['y']
	else
		feedButtonX = FOM_Config.buttonX
		feedButtonY = FOM_Config.buttonY
	end

	-- create feed button
	FOM_FeedButton = CreateFrame("Button", "FOM_FeedButton", nil, "ActionButtonTemplate,SecureActionButtonTemplate");
	FOM_FeedButton:SetMovable(true)
	FOM_FeedButton:EnableMouse(true)
	FOM_FeedButton:SetClampedToScreen(true)
	FOM_FeedButton:RegisterForDrag("LeftButton")
	FOM_FeedButton:SetScript("OnDragStart", function(self2)
		self2:StartMoving()
	end)
	FOM_FeedButton:SetScript("OnDragStop", function(self2)
        local offsetX, offsetY = feedButton.getPosition()
		FOM_Config.buttonX = offsetX
		FOM_Config.buttonY = offsetY
		FOM_Config['buttonRelative'] = 'absolute'
		self2:StopMovingOrSizing()
	end)

	FOM_FeedButtonNormalTexture:SetTexture("");
	FOM_FeedButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	FOM_FeedButton:SetScript("PreClick", FOM_FeedButton_PreClick)
	FOM_FeedButton:SetScript("PostClick", FOM_FeedButton_PostClick);
	FOM_FeedButton:SetScript("OnEnter", FOM_FeedButton_OnEnter);
	FOM_FeedButton:SetScript("OnLeave", FOM_FeedButton_OnLeave);
	if (FOM_Config.NoButton) then
		FOM_FeedButton:Hide();
	end

	feedButton.OnEnable()
	if FOM_Config['buttonRelative'] ~= 'absolute' then
		--Position relative to frame
		--@debug@
		print('Button position relative to', FOM_Config['buttonRelative'])
		--@end-debug@
		feedButton.setPosition(feedButtonX, feedButtonY, defaultPosition['frame'])
	else
		--Absolute position
		feedButton.setPosition(feedButtonX, feedButtonY)
	end

	if FOM_Config['buttonH'] ~= nil and FOM_Config['buttonW'] ~= nil then
		--Saved size
		--@debug@
		print('Set Feed Pet button size to saved size', FOM_Config['buttonH'], FOM_Config['buttonW'])
		--@end-debug@
		feedButton.setSize(FOM_Config['buttonH'], FOM_Config['buttonW'])
	else
		--Default size
		--@debug@
		print('Set Feed Pet button size to default size', defaultPosition['h'], defaultPosition['w'])
		--@end-debug@
		feedButton.setSize(defaultPosition['h'], defaultPosition['w'])
	end

	-- set key binding to click FOM_FeedButton
	FOM_UpdateBindings();
	self:RegisterEvent("UPDATE_BINDINGS");

	itemTooltip:hook(GameTooltip);
	itemTooltip:hook(ItemRefTooltip);
	itemTooltip:hook(FOM_FeedTooltip);

	Frame_GFW_FeedOMatic:SetScript("OnUpdate", FOM_OnUpdate);

	self:UnregisterEvent("VARIABLES_LOADED");
	self:UnregisterEvent("SPELLS_CHANGED");

	FOM_Initialized = true;

end

function FOM_OnEvent(self, event, arg1, arg2)
	--print(event)

	if ( event == "VARIABLES_LOADED" or event == "SPELLS_CHANGED") then

		if (not FOM_Initialized) then FOM_Initialize(self); end
		FOM_PickFoodQueued = true;

	elseif ( event == "UPDATE_BINDINGS" ) then

		FOM_UpdateBindings();
		return;

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then

		self:RegisterEvent("BAG_UPDATE");
		if (InCombatLockdown()) then
			FOM_PickFoodQueued = true;
		else
			FOM_PickFoodForButton();
		end
		return;

	elseif ( event == "PLAYER_LEAVING_WORLD" ) then

		self:UnregisterEvent("BAG_UPDATE");

	elseif (event == "BAG_UPDATE" ) then

		if (arg1 < 0 or arg1 > 4) then return; end	-- don't bother looking in keyring, bank, etc for food
		if (FOM_IsSpecialBag(arg1)) then return; end	-- don't look in bags that can't hold food, either

		FOM_PickFoodQueued = true;

	elseif ((event == "UNIT_NAME_UPDATE" and arg1 == "pet") or event == "PET_BAR_UPDATE" or event == "PLAYER_REGEN_ENABLED") then

		FOM_PickFoodQueued = true;

	elseif event == "TRADE_SKILL_SHOW"
	  or event == "TRADE_SKILL_DETAILS_UPDATE"
	  or event == "TRADE_SKILL_LIST_UPDATE"
	  or event == "TRADE_SKILL_DATA_SOURCE_CHANGED" then
		FOM_ScanTradeSkill();
		return;

	elseif (event == "CHAT_MSG_PET_INFO") then
		if (not FOM_FEEDPET_LOG_FIRSTPERSON) then
			FOM_FEEDPET_LOG_FIRSTPERSON = GFWUtils.FormatToPattern(FEEDPET_LOG_FIRSTPERSON);
		end
		local _, _, foodEaten = string.find(arg1, FOM_FEEDPET_LOG_FIRSTPERSON);
		if (foodEaten) then
			local foodName = foodEaten;
			if (FOM_NextFoodLink and utils:ItemNameFromLink(FOM_NextFoodLink) == foodEaten) then
				foodName = FOM_NextFoodLink;
			end
			local pet = UnitName("pet");
			if (pet) then
				if ( FOM_Config.AlertType == 2) then
					GFWUtils.Print(string.format(FOM_FEEDING_EAT, pet, foodName));
				elseif ( FOM_Config.AlertType == 1) then
					SendChatMessage(string.format(FOM_FEEDING_FEED, pet, foodName).. FOM_RandomEmote(foodName), "EMOTE");
				end
			end
		end
	elseif (event == "SPELL_UPDATE_COOLDOWN") then
		local start, duration, enable = GetSpellCooldown(FOM_FEED_PET_SPELL_ID);
		CooldownFrame_Set(FOM_FeedButtonCooldown, start, duration, enable);
	elseif (event == "SPELL_UPDATE_USABLE") then
		local isUsable, notEnoughtMana = IsUsableSpell(FOM_FEED_PET_SPELL_ID);
		if (not isUsable) then
			FOM_FeedButtonIcon:SetVertexColor(0.4, 0.4, 0.4);
		elseif (FOM_NoFoodError) then
			FOM_FeedButtonIcon:SetVertexColor(0.5, 0.5, 0.1);
		else
			FOM_FeedButtonIcon:SetVertexColor(1, 1, 1);
		end
	end

	if (FOM_PickFoodQueued and not InCombatLockdown()) then
		FOM_PickFoodForButton();
	end

	if (FOM_FoodListBorder and FOM_FoodListBorder:IsVisible()) then
		FOM_FoodListUI_UpdateList();
		FOM_FoodsPanel.refresh();
	end

end

function FOM_UpdateBindings()
	if (not InCombatLockdown()) then
		ClearOverrideBindings(FOM_FeedButton);
		local key = GetBindingKey("FOM_FEED");
		if (key) then
			SetOverrideBindingClick(FOM_FeedButton, nil, key, "FOM_FeedButton");
		end
	end
end

local function FOM_SetQuestFood(itemID, numRequired)
    if (FOM_QuestFood == nil) then
        FOM_QuestFood = { };
    end
    if (FOM_QuestFood[itemID] == nil) then
        FOM_QuestFood[itemID] = tonumber(numRequired);
    else
        FOM_QuestFood[itemID] = max(FOM_QuestFood[itemID], tonumber(numRequired));
    end
end

local function FOM_ScanQuests_retail()
    local _, numQuests = _G.C_QuestLog.GetNumQuestLogEntries()
    for questLogIndex = 1, numQuests do
        local questID = _G.C_QuestLog.GetQuestIDForLogIndex(questLogIndex)
        local objectives = _G.C_QuestLog.GetQuestObjectives(questID)
        if objectives then
            for _, objective in ipairs(objectives) do
                if objective['type'] == 'item' then
                    local _, _, _, numRequired, itemName = objective['text']:find("(%d+)/(%d+) (.+)");
                    local itemID, _, _, _, _, _, _ = _G.GetItemInfoInstant(itemName)
                    if itemID and FOM_Food.isKnownFood(itemID) then
                        FOM_SetQuestFood(itemID, numRequired)
                    end
                end
            end
        end
    end
end

-- Update our list of quest objectives so we can avoid consuming food we want to accumulate for a quest.
function FOM_ScanQuests()
	if not is_classic then
		return FOM_ScanQuests_retail()
	end

	for questNum = 1, GetNumQuestLogEntries() do
		local _, _, _, _, isHeader, isCollapsed, isComplete  = GetQuestLogTitle(questNum);
		if (not isHeader) then
			for objectiveNum = 1, GetNumQuestLeaderBoards(questNum) do
				local text, type, finished = GetQuestLogLeaderBoard(objectiveNum, questNum);
				if (text and strlen(text) > 0) then
					local _, _, objectiveName, numCurrent, numRequired = string.find(text, "(.*): (%d+)/(%d+)");
					if (objectiveName) then
						local _, link = GetItemInfo(objectiveName);
						-- not guaranteed to get us a link if we don't have the item,
						-- but we shouldn't be here unless we have the item anyway.
						local itemID = utils:ItemIdFromLink(link);
						if (itemID and FOM_Food.isKnownFood(itemID)) then
                            FOM_SetQuestFood(itemID, numRequired)
						end
					end
				end
			end
		end
	end
end

function FOM_ChatCommandHandler(msg)

	if ( msg == "" ) then
		GFW_FeedOMatic:ShowConfig();
		return;
	end

	-- Print Help
	if ( msg == "help" ) then
		local version = GetAddOnMetadata(addonName, "Version");
		GFWUtils.Print("Fizzwidget Feed-O-Matic "..version..":");
		GFWUtils.Print("/feedomatic /fom <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("reset").." - Reset to default settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("notooltip").." - Disable/enable feed button tooltip.");
		return;
	end

	if ( msg == "version" ) then
		local version = GetAddOnMetadata(addonName, "Version");
		GFWUtils.Print("Fizzwidget Feed-O-Matic "..version..":");
		return;
	end

	if ( msg == "debug" ) then
		FOM_Debug = not FOM_Debug;
		GFWUtils.Print((not FOM_Debug and "Not " or "").."Showing food list in feed button tooltip.");
	end

	if ( msg == "notooltip" ) then
		FOM_Config.NoFeedButtonTooltip = not FOM_Config.NoFeedButtonTooltip;
		GFWUtils.Print((FOM_Config.NoFeedButtonTooltip and "Not " or "").."Showing feed button tooltip.");
	end

	-- Reset Variables
	if ( msg == "reset" ) then
		GFW_FeedOMatic.db:ResetProfile();
		FOM_QuestFood = nil;
		GFWUtils.Print("Feed-O-Matic configuration reset.");
		return;
	end

	-- if we got down to here, we got bad input
	FOM_ChatCommandHandler("help");
end

---Find food and set variables foodBag, foodSlot, foodIcon and FOM_NextFoodLink
function FOM_PickFoodForButton()

	if (not FOM_GetFeedPetSpellName()) then
		return;
	end
	local pet = UnitName("pet");
	if (not pet) then
		FOM_PickFoodQueued = true;
		return;
	end
	local dietList = petInfo.petDiet
	if ( dietList == nil or #dietList == 0) then
		FOM_PickFoodQueued = true;
		FOM_FeedButton:Hide();
		return;
	elseif (not FOM_Config.NoButton) then
		FOM_FeedButton:Show();
	end

	foodBag, foodSlot, FOM_NextFoodLink, foodIcon = FOM_NewFindFood();
	FOM_SetupButton(foodBag, foodSlot);

	if ( foodBag == nil) then
		local fallbackBag, fallbackSlot;
		fallbackBag, fallbackSlot, FOM_NextFoodLink, foodIcon = FOM_NewFindFood(1);
		if (fallbackBag) then
			FOM_NoFoodError = string.format(FOM_ERROR_NO_FOOD_NO_FALLBACK, pet);
			FOM_SetupButton(fallbackBag, fallbackSlot, "alt");
			FOM_FeedButtonIcon:SetTexture(foodIcon);
			FOM_FeedButtonCount:SetText(GetItemCount(FOM_NextFoodLink))
		else
			-- No Food Could be Found
			FOM_NoFoodError = string.format(FOM_ERROR_NO_FOOD, pet);
			FOM_NextFoodLink = nil;
			FOM_FeedButtonIcon:SetTexture(FOM_FeedPetSpellIcon);
			--GFWUtils.Print("Can't feed? #SortedFoodList:"..#SortedFoodList);
			--DevTools_Dump(GetPetFoodTypes());
			FOM_FeedButtonCount:SetText("")

		end

		FOM_FeedButtonIcon:SetVertexColor(0.5, 0.5, 1);
	else
		FOM_NoFoodError = nil;
		FOM_FeedButtonIcon:SetVertexColor(1, 1, 1);
		FOM_FeedButtonIcon:SetTexture(foodIcon);
		FOM_FeedButtonCount:SetText(GetItemCount(FOM_NextFoodLink))

	end

	-- debug
	if (false and FOM_NextFoodLink) then
		if (FOM_NoFoodError) then
			GFWUtils.PrintOnce("Next food (fallback):"..FOM_NextFoodLink, 1);
		else
			GFWUtils.PrintOnce("Next food:"..FOM_NextFoodLink, 1);
		end
	end
end

function FOM_SetupButton(bag, slot, modifier)
	if (not FOM_GetFeedPetSpellName()) then
		return;
	end
	if not utils:empty(modifier) then
		modifier = modifier.."-";
	else
		modifier = "";
	end
	if (bag and slot) then
		FOM_FeedButton:SetAttribute(modifier.."type1", "spell");
		FOM_FeedButton:SetAttribute(modifier.."spell1", FOM_FeedPetSpellName);
		FOM_FeedButton:SetAttribute("target-bag", bag);
		FOM_FeedButton:SetAttribute("target-slot", slot);
	else
		FOM_FeedButton:SetAttribute(modifier.."type", ATTRIBUTE_NOOP);
		FOM_FeedButton:SetAttribute(modifier.."spell", ATTRIBUTE_NOOP);
		FOM_FeedButton:SetAttribute(modifier.."type1", ATTRIBUTE_NOOP);
		FOM_FeedButton:SetAttribute(modifier.."spell1", ATTRIBUTE_NOOP);
		FOM_FeedButton:SetAttribute("target-bag", nil);
		FOM_FeedButton:SetAttribute("target-slot", nil);
	end
	FOM_PickFoodQueued = nil;
end

function FOM_RandomEmote(foodLink)

	local localeEmotes = FOM_Emotes[GetLocale()];
	if (localeEmotes) then
		local randomEmotes = {};
		if (UnitSex("pet") == 2) then
			randomEmotes = tableUtils:Merge(randomEmotes, localeEmotes["male"]);
		elseif (UnitSex("pet") == 3) then
			randomEmotes = tableUtils.Merge(randomEmotes, localeEmotes["female"]);
		end

		local itemID = utils:ItemIdFromLink(foodLink);
		if (itemID) then
			randomEmotes = tableUtils.Merge(randomEmotes, localeEmotes[itemID]);

			local diet = FOM_Food.isInDiet(itemID);
			randomEmotes = tableUtils.Merge(randomEmotes, localeEmotes[diet]);
		end

		randomEmotes = tableUtils.Merge(randomEmotes, localeEmotes[UnitCreatureFamily("pet")]);
		randomEmotes = tableUtils.Merge(randomEmotes, localeEmotes["any"]);

		return randomEmotes[math.random(table.getn(randomEmotes))];
	else
		return "";
	end
end

function FOM_FlatFoodList(fallback)
	local foodList = {};
	local petLevel = petInfo.petLevel
	for bagNum = 0, 4 do
		if (not FOM_IsSpecialBag(bagNum)) then
		-- skip bags that can't contain food
			for itemNum = 1, C_Container.GetContainerNumSlots(bagNum) do
				local itemInfo = C_Container.GetContainerItemInfo(bagNum, itemNum);
				if not utils:empty(itemInfo) then
					local itemID = utils:ItemIdFromLink(itemInfo['hyperlink']);

					-- debug
					--if (bagNum == 0 and itemNum == 1) then itemCount = 10; end
					local _, _, _, level = GetItemInfo(itemID);
					if (not level) then
						-- how can we not have cached info for an item in your bags?
						-- make sure it's cached for future runs
						FOMTooltip:SetHyperlink("item:"..itemID);
					elseif (petLevel - level < FOM_DELTA_EATS) then
						local diet = FOM_Food.isInDiet(itemID);
						if ( diet ) then
							local avoid = FOM_ShouldAvoidFood(itemID, itemInfo['stackCount'], diet);
							if (fallback or not avoid) then
								local categoryIndex = FOM_Foods[diet][itemID];
								table.insert(foodList, {bag=bagNum, slot=itemNum, link=itemInfo['hyperlink'], count=itemInfo['stackCount'], delta=(petLevel - level), priority=categoryIndex, icon=itemInfo['iconFileID']});
							end
						end
					end
				end
			end
		end
	end
	return foodList;
end

function FOM_NewFindFood(fallback)
	SortedFoodList = FOM_FlatFoodList(fallback);

	-- if there are any conjured foods, drop everything else from the list
	local tempFoodsOnly = {};
	for _, foodInfo in pairs(SortedFoodList) do
		if (foodInfo.temp) then
			table.insert(tempFoodsOnly, foodInfo);
		end
	end
	if (table.getn(tempFoodsOnly) > 0) then
		SortedFoodList = tempFoodsOnly;
	end

	local function sortCount(a, b)
		return a.count < b.count;
	end
	local function sortPriority(a, b)
		return a.priority < b.priority;
	end
	local function sortQualityDescending(a, b)
		if (a.priority == b.priority) then
			return a.delta < b.delta;
		end
		return sortPriority(a, b)
	end
	local function sortQualityAscending(a, b)
		if (a.priority == b.priority) then
			return a.delta > b.delta;
		end
		return sortPriority(a, b)
	end
	table.sort(SortedFoodList, sortCount); -- small stacks first
	if (not FOM_Config.UseLowLevelFirst) then
		table.sort(SortedFoodList, sortQualityDescending); -- higher quality first
	else
		table.sort(SortedFoodList, sortQualityAscending); -- lower quality first
	end
	--table.sort(SortedFoodList, sortPriority); -- category priorities (conjured ahead of normal ahead of bonus etc)

	if (GFWUtils.Debug) then
		if (fallback) then
			GFWUtils.DebugLog("Food list (with fallback):")
		else
			GFWUtils.DebugLog("Food list:")
		end
		for num, foodInfo in pairs(SortedFoodList) do
			GFWUtils.DebugLog(string.format("%d: %dx%s, delta %d", num, foodInfo.count, foodInfo.link, foodInfo.delta));
		end
	end
	for _, foodInfo in pairs(SortedFoodList) do
		local foodItemID = utils:ItemIdFromLink(foodInfo.link)
		--Check if food item is logged as not eaten by current pet
		if foodLogger.is_good(foodItemID) ~= false then
			return foodInfo.bag, foodInfo.slot, foodInfo.link, foodInfo.icon;
		end
	end

	return nil;
end

function FOM_ShouldAvoidFood(itemID, quantity, diet)
	if (FOM_Config.excludedFoods[itemID]) then
		return true;
	end
	local foodName = GetItemInfo(itemID);
	if (foodName == nil) then
		GFWUtils.DebugLog("Can't get info for item ID "..itemID..", assuming it's OK to eat.");
		return false;
	end
	if (FOM_Config.AvoidQuestFood) then
		if (FOM_IsQuestFood(itemID, quantity)) then
			GFWUtils.DebugLog("Skipping "..quantity.."x "..foodName.."; is needed for quest.");
			return true;
		end
	end
	for category in pairs(FOM_Config.excludedCategories) do
		local foodCategory = FOM_Foods[diet][itemID];
		if (category == foodCategory ) then
			GFWUtils.DebugLog("Skipping "..quantity.."x "..foodName.."; is in category "..category..".");
			return true;
		end
	end
	--GFWUtils.DebugLog("Not skipping "..quantity.."x "..foodName.."; doesn't have other uses.");
	return false;
end

function FOM_IsQuestFood(itemID, quantity)
	FOM_ScanQuests();
	if (FOM_QuestFood and FOM_QuestFood[itemID]) then
		return GetItemCount(itemID) <= FOM_QuestFood[itemID];
	end
end

function FOM_IsSpecialBag(bagNum)
	-- this used to be for quivers, but they're obsolete (and gone?) now
	-- other special bags can't contain food, though, so we may as well skip 'em
	if (bagNum == 0) then return false; end
	local _, bagType = C_Container.GetContainerNumFreeSlots(bagNum);
	return bagType ~= 0;
end

------------------------------------------------------
-- foods list options pansl
------------------------------------------------------

local FOM_LIST_HEIGHT = 24;
local FOM_MAX_LIST_DISPLAYED = 10;
local MAX_COOKING_RESULTS = 6;

function FOM_BuildFoodsUI(panel)

	FOM_FoodsPanel = panel;

	local borderFrame = CreateFrame("Frame", "FOM_FoodListBorder", panel);
	borderFrame:SetHeight(273);
	borderFrame:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 15, 15);
	borderFrame:SetPoint("RIGHT", panel, -15, 0);
	borderFrame:Show();

	local headerBgLeft = panel:CreateTexture("FOM_FoodList_HeaderBGLeft", "ARTWORK");
	headerBgLeft:SetTexture("Interface\\TokenFrame\\UI-TokenFrame-CategoryButton");
	headerBgLeft:SetDesaturated(1);
	headerBgLeft:SetTexCoord(0, 1, 0, 0.28125);
	headerBgLeft:SetHeight(24);
	headerBgLeft:SetPoint("TOPLEFT",borderFrame,"TOPLEFT",5,-5);
	headerBgLeft:SetPoint("RIGHT",borderFrame,-66,0);
	headerBgLeft:Show();

	local headerBgRight = panel:CreateTexture("FOM_FoodList_HeaderBGRight", "ARTWORK");
	headerBgRight:SetTexture("Interface\\TokenFrame\\UI-TokenFrame-CategoryButton");
	headerBgRight:SetDesaturated(1);
	headerBgRight:SetTexCoord(0, 0.14453125, 0.296875, 0.578125);
	headerBgRight:SetWidth(61);
	headerBgRight:SetHeight(24);
	headerBgRight:SetPoint("TOPRIGHT",borderFrame,"TOPRIGHT",-5,-5);

	local s = panel:CreateFontString("FOM_FoodList_NameHeader", "OVERLAY", "GameFontNormalSmall");
	s:SetPoint("TOPLEFT", borderFrame, "TOPLEFT", 53, -12);
	s:SetText(FOM_OPTIONS_FOODS_NAME);

	s = panel:CreateFontString("FOM_FoodList_CookingHeader", "OVERLAY", "GameFontNormalSmall");
	s:SetPoint("TOPRIGHT", borderFrame, "TOPRIGHT", -26, -12);
	s:SetText(FOM_OPTIONS_FOODS_COOKING);

	local listItem = CreateFrame("Button", "FOM_FoodList1", panel, "FOM_FoodListItemTemplate");
	listItem:SetPoint("TOPLEFT", borderFrame, "TOPLEFT", 5, -29);
	listItem:SetPoint("TOPRIGHT", borderFrame, "TOPRIGHT", -24, -29);
	for i = 2, FOM_MAX_LIST_DISPLAYED do
		listItem = CreateFrame("Button", "FOM_FoodList" .. i, panel, "FOM_FoodListItemTemplate");
		listItem:SetPoint("TOPLEFT", "FOM_FoodList" .. (i - 1), "BOTTOMLEFT", 0, 0);
		listItem:SetPoint("TOPRIGHT", "FOM_FoodList" .. (i - 1), "BOTTOMRIGHT", 0, 0);
	end

	local scrollFrame = CreateFrame("ScrollFrame", "FOM_FoodListScrollFrame", panel, "FauxScrollFrameTemplate");
	scrollFrame:SetHeight(240);
	scrollFrame:SetPoint("TOPLEFT", borderFrame, "TOPLEFT", 5, -29);
	scrollFrame:SetPoint("RIGHT", borderFrame, -27, 0);
	scrollFrame:SetFrameLevel(scrollFrame:GetFrameLevel() + 5);
	scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, FOM_LIST_HEIGHT, FOM_FoodListUIUpdate);
	end);

end

function FOM_FoodListShowTooltip(button)
	if not button.item then return; end

	GameTooltip:SetHyperlink("item:"..button.item);
	if (button.recipe) then
		local c = FOM_DifficultyColors[button.difficulty];
		GameTooltip:AddDoubleLine(FOM_DIFFICULTY_HEADER, getglobal("FOM_DIFFICULTY_"..button.difficulty), c.r,c.g,c.b, c.r,c.g,c.b);
	end
	GameTooltip:Show();
end

function FOM_FoodListButton_OnLoad(self)
	local name = self:GetName();
	self.check = getglobal(name.."Check");
	self.icon = getglobal(name.."Icon");
	self.name = getglobal(name.."Name");
	self.categoryLeft = getglobal(name.."CategoryLeft");
	self.categoryRight = getglobal(name.."CategoryRight");
	self.cookingIcons = {};
	self.cookingItems = {};
	for i = 1, MAX_COOKING_RESULTS do
		self.cookingIcons[i] = getglobal(name.."CreatedIcon"..i);
		self.cookingItems[i] = getglobal(name.."CreatedItem"..i);
	end
end

function FOM_FoodListButton_OnClick(self)
	if (self.header and not self.item) then
		if (FOM_Config.excludedCategories[self.header]) then
			FOM_Config.excludedCategories[self.header] = nil;
		else
			FOM_Config.excludedCategories[self.header] = 1;
		end
	elseif (self.item and not FOM_Config.excludedCategories[self.header]) then
		if (FOM_Config.excludedFoods[self.item]) then
			FOM_Config.excludedFoods[self.item] = nil;
		else
			FOM_Config.excludedFoods[self.item] = 1;
		end
	end
	FOM_FoodListUIUpdate();
	if (InCombatLockdown()) then
		FOM_PickFoodQueued = true;
	else
		FOM_PickFoodForButton();
	end
end

function FOM_FoodListUI_UpdateList()
	FOM_FoodsUIList = {};
	for header = 1, #FOM_CategoryNames do
		local list = {};
		local uniqueList = {};
		-- build list of foods from matching criteria
		local petLevel = petInfo.petLevel
		local itemNamesCache = {};
		for diet, table in pairs(FOM_Foods) do
			for itemID, foodType in pairs(table) do
				local name, _, _, iLvl = GetItemInfo(itemID);
				local skip = false;
				if (name and header == foodType) then
					itemNamesCache[itemID] = name;
					local delta = petLevel - iLvl;
					if (FOM_Config.ShowOnlyInventory) then
						if (GetItemCount(itemID) == 0) then
							skip = true;
						end
					end
					-- TODO: invert diet check for efficiency now that we're inside a diet loop
					local dietChecked = false;
					if (not skip and FOM_Config.ShowOnlyPetFoods) then
						if (UnitExists("pet")) then
							if (not FOM_Food.isInDiet(itemID)) then
								skip = true;
							end
							dietChecked = true;
						end
						if (not skip and delta >= FOM_DELTA_EATS) then
							skip = true;
						end
					end

					if (not skip) then
						if (not uniqueList[itemID]) then
							tinsert(list, itemID);
						end
						if (delta >= FOM_DELTA_EATS) then
							uniqueList[itemID] = 3;
						elseif (delta >= FOM_DELTA_LIKES and delta < FOM_DELTA_EATS) then
							uniqueList[itemID] = 2;
						elseif (delta >= FOM_DELTA_LOVES and delta < FOM_DELTA_LIKES) then
							uniqueList[itemID] = 1;
						elseif (delta < FOM_DELTA_LOVES) then
							uniqueList[itemID] = 0;
						end
					end
				end
			end
		end

		-- sort list for display
		local function sortHigherQualityFirst(a,b)
			if (uniqueList[a] == uniqueList[b]) then
				return itemNamesCache[a] < itemNamesCache[b];
			else
				return uniqueList[a] < uniqueList[b];
			end
		end
		local function sortLowerQualityFirst(a,b)
			if (uniqueList[a] == uniqueList[b]) then
				return itemNamesCache[a] < itemNamesCache[b];
			else
				return uniqueList[a] > uniqueList[b];
			end
		end
		if (not FOM_Config.UseLowLevelFirst) then
			table.sort(list, sortHigherQualityFirst);
		else
			table.sort(list, sortLowerQualityFirst);
		end
		tinsert(FOM_FoodsUIList, header);
		for _, itemID in pairs(list) do
			tinsert(FOM_FoodsUIList, {id=itemID,header=header});
		end
	end
	FOM_List = FOM_FoodsUIList
	FOM_FoodListUIUpdate();
end

function FOM_FoodListUIUpdate()

	local numListItems = #FOM_FoodsUIList;
	local listOffset = FauxScrollFrame_GetOffset(FOM_FoodListScrollFrame);
	if (listOffset > numListItems - FOM_MAX_LIST_DISPLAYED) then
		listOffset = math.max(0, numListItems - FOM_MAX_LIST_DISPLAYED);
		FauxScrollFrame_SetOffset(FOM_FoodListScrollFrame, listOffset);
	end

	FauxScrollFrame_Update(FOM_FoodListScrollFrame, numListItems, FOM_MAX_LIST_DISPLAYED, FOM_LIST_HEIGHT);

	local petLevel = petInfo.petLevel
	for i=1, FOM_MAX_LIST_DISPLAYED, 1 do
		local listIndex = i + listOffset;
		local listItem = FOM_FoodsUIList[listIndex];
		local listButton = getglobal("FOM_FoodList"..i);

		if ( listIndex <= numListItems ) then
			-- Set button widths if scrollbar is shown or hidden
			if ( FOM_FoodListScrollFrame:IsShown() ) then
				listButton:SetWidth(350);
			else
				listButton:SetWidth(368);
			end

			listButton:SetID(listIndex);
			listButton:Show();

			if ( type(listItem) == "number" ) then
				-- it's a header
				listButton.header = listItem;
				listButton.item = nil;

				listButton.categoryRight:Show();
				listButton.categoryLeft:Show();
				listButton.icon:SetTexture("");
				listButton.name:SetText("");
				listButton:SetText(FOM_CategoryNames[listItem]);

				for iconIndex = 1, MAX_COOKING_RESULTS do
					listButton.cookingIcons[iconIndex]:SetTexture("");
					listButton.cookingItems[iconIndex]:Hide();
				end

				if (FOM_Config.excludedCategories[listItem]) then
					listButton.check:Hide();
				else
					listButton.check:Show();
				end
				listButton:SetAlpha(1);

			else
				listButton.header = listItem.header;
				listButton.item = listItem.id;

				listButton.categoryLeft:Hide();
				listButton.categoryRight:Hide();

				local name, _, _, iLvl, _, _, _, _, _, texture = GetItemInfo(listItem.id);
				listButton:SetText("");
				listButton.name:SetText(name);
				local color;
				local delta = petLevel - iLvl;
				if (delta > FOM_DELTA_EATS) then
					color = QuestDifficultyColors["trivial"];
				elseif (delta > FOM_DELTA_LIKES and delta <= FOM_DELTA_EATS) then
					color = QuestDifficultyColors["standard"];
				elseif (delta > FOM_DELTA_LOVES and delta <= FOM_DELTA_LIKES) then
					color = QuestDifficultyColors["difficult"];
				elseif (delta <= FOM_DELTA_LOVES) then
					color = QuestDifficultyColors["verydifficult"];
				end
				listButton.name:SetTextColor(color.r, color.g, color.b);
				listButton.icon:SetTexture(texture);

				-- show cooking results
				for iconIndex = 1, MAX_COOKING_RESULTS do
					listButton.cookingIcons[iconIndex]:SetTexture("");
					listButton.cookingItems[iconIndex]:Hide();
				end
				local recipes = FOM_Cooking[listItem.id];
				if (recipes) then
					local resultIndex = 1;
					for resultItemID, difficulty in pairs(recipes) do
						if (resultIndex > MAX_COOKING_RESULTS) then
							--print("too many recipes for item", listItem.id), resultIndex)
							break;
						end
						local icon = select(10, GetItemInfo(resultItemID));
						listButton.cookingIcons[resultIndex]:SetTexture(icon);
						listButton.cookingItems[resultIndex]:Show();
						listButton.cookingItems[resultIndex].item = resultItemID;
						listButton.cookingItems[resultIndex].recipe = true;
						listButton.cookingItems[resultIndex].difficulty = difficulty;

						if (difficulty < 5) then
							listButton.cookingIcons[resultIndex]:SetVertexColor(1, 1, 1);
						else
							listButton.cookingIcons[resultIndex]:SetVertexColor(0.4, 0.4, 0.4);
						end
						resultIndex = resultIndex + 1;
					end
				end

				if (FOM_Config.excludedFoods[listItem.id] or FOM_Config.excludedCategories[listItem.header]) then
					listButton.check:Hide();
				else
					listButton.check:Show();
				end

				if (FOM_Config.excludedCategories[listItem.header]) then
					listButton:SetAlpha(0.5);
				else
					listButton:SetAlpha(1);
				end
			end

		else
			listButton:Hide();
		end
	end

end

------------------------------------------------------
-- Ace3 options panel stuff
------------------------------------------------------

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")


function GFW_FeedOMatic:OnProfileChanged(event, database, newProfileKey)
	-- this is called every time our profile changes (after the change)
	FOM_Config = database.profile

	if (FOM_FoodListBorder and FOM_FoodListBorder:IsVisible()) then
		FOM_FoodListUI_UpdateList();
	end
	if (InCombatLockdown()) then
		FOM_PickFoodQueued = true;
	else
		FOM_PickFoodForButton();
	end
end

local titleText = GetAddOnMetadata(addonName, "Title");
local version = GetAddOnMetadata(addonName, "Version");
titleText = titleText .. " " .. version;

local profileDefault = {
	Tooltip				= true,
	UseLowLevelFirst	= true,
	AvoidQuestFood		= true,
	AlertType			= 1,

	ShowOnlyPetFoods	= false,
	ShowOnlyInventory	= false,

	excludedCategories = {
		["Consumable.Food.Edible.Bonus"] = 1;
	},
	excludedFoods = {},
}
local defaults = {}
defaults.profile = profileDefault

function GFW_FeedOMatic:SetupOptions()
	local options = FOMOptions.options
	-- Inject profile options
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profile.order = -2

	-- Register options table
	AceConfig:RegisterOptionsTable(addonName, options)
	AceConfig:RegisterOptionsTable('Feed Button', FOMOptions.feedButtonOptions)

	local titleText = GetAddOnMetadata(addonName, "Title");
	titleText = string.gsub(titleText, "Fizzwidget", "GFW");		-- shorter so it fits in the list width

	-- Setup Blizzard option frames
	self.optionsFrames = {}
	-- The ordering here matters, it determines the order in the Blizzard Interface Options
	self.optionsFrames.general = AceConfigDialog:AddToBlizOptions(addonName, titleText, nil, "general")
	self.optionsFrames.button = AceConfigDialog:AddToBlizOptions('Feed Button', 'Feed Pet button', titleText)
	self.optionsFrames.profile = AceConfigDialog:AddToBlizOptions(addonName, options.args.profile.name, titleText, "profile")

	FOM_BuildFoodsUI(self.optionsFrames.general);
	local aceRefresh = self.optionsFrames.general.refresh;
	self.optionsFrames.general.refresh = function(...)
		if ... ~= nil then
			aceRefresh(...);
		end
		FOM_FoodListUI_UpdateList();
	end;
end

function GFW_FeedOMatic:OnInitialize()

	local _, realClass = UnitClass("player");
	if (realClass ~= "HUNTER") then
		return;
	end

	-- Create DB
	self.db = AceDB:New("GFW_FeedOMatic_DB", defaults, "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	FOM_Config = self.db.profile
	self:SetupOptions()
end

function GFW_FeedOMatic:ShowConfig()
	Settings.OpenToCategory(self.optionsFrames.general) --TODO: Does not work
	--Call a second time to work around bug: https://www.wowinterface.com/forums/showthread.php?t=54599
	Settings.OpenToCategory(self.optionsFrames.general)
end

