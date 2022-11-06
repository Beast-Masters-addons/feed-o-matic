------------------------------------------------------
-- FOM_CookingScan.lua
------------------------------------------------------

---@type FeedOMatic
local _, addon = ...

FOM_Cooking = {};

function FOM_ScanTradeSkill()
	if not addon.professions then
		return nil
	end

	if not addon.professions.api:IsReady()
	  or addon.professions.api:GetName() ~= "Cooking" then
		return nil -- should just get called again when ready
	end

	for recipeID, recipeInfo in pairs(addon.professions.currentProfession:GetRecipes()) do

		local difficulty = addon.utils:DifficultyToNum(recipeInfo["difficulty"]);

		local createdItemLink = recipeInfo["link"]
		local _, _, id = string.find(createdItemLink, "item:(%d+)");
		local createdItemID = tonumber(id);

		local reagents = addon.professions.currentProfession:GetReagents(recipeID)

			for _, reagent in pairs(reagents) do
				local reagentLink = reagent["reagentLink"]
				if reagentLink then
					local _, _, itemID = string.find(reagentLink, "item:(%d+)");
					local reagentItemID = tonumber(itemID);
					if FOM_Cooking[reagentItemID] == nil then
						FOM_Cooking[reagentItemID] = {};
					end
					FOM_Cooking[reagentItemID][createdItemID] = difficulty;
				end
			end
	end
end
