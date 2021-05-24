------------------------------------------------------
-- FOM_CookingScan.lua
------------------------------------------------------

---@type FeedOMatic
local _, addon = ...
local profession = addon.professions.currentProfession
local profession_api = addon.professions.api
local utils = addon.utils

FOM_Cooking = {};

function FOM_ScanTradeSkill()
	if not profession_api:IsReady()
	  or profession_api:GetName() ~= "Cooking" then
		return -- should just get called again when ready
	end

	for recipeID, recipeInfo in pairs(profession:GetRecipes()) do

		local difficulty = utils:DifficultyToNum(recipeInfo["difficulty"]);

		local createdItemLink = recipeInfo["link"]
		local _, _, id = string.find(createdItemLink, "item:(%d+)");
		local createdItemID = tonumber(id);

		local reagents = profession:GetReagents(recipeID)

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
