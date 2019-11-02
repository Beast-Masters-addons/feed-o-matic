------------------------------------------------------
-- FOM_CookingScan.lua
------------------------------------------------------

local profession = LibStub("LibCurrentProfession-1.0")
local profession_api = LibStub("LibProfessionAPI-1.0")

FOM_Cooking = {};

local DifficultyToNum = {
	["optimal"]	= 4,
	["orange"]	= 4,
	["medium"]	= 3,
	["yellow"]	= 3,
	["easy"]	= 2,
	["green"]	= 2,
	["trivial"]	= 1,
	["gray"]	= 1,
	["grey"]	= 1,
}

function FOM_ScanTradeSkill()
	if not profession_api:IsReady()
	  or profession_api:GetName() ~= "Cooking" then
		return -- should just get called again when ready
	end

	for recipeID, recipeInfo in pairs(profession:GetRecipes()) do

		local difficulty = DifficultyToNum[recipeInfo["difficulty"]];

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
