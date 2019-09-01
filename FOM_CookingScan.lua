------------------------------------------------------
-- FOM_CookingScan.lua
------------------------------------------------------

local COOKING_SKILL_ID = "Cooking";

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

	local tradeSkillID, skillLineName, skillLineRank, skillLineMaxRank, skillLineModifier = GetTradeSkillLine();
	local num_recipes = GetNumTradeSkills()
	if num_recipes == 0
	  or tradeSkillID ~= COOKING_SKILL_ID then
		return -- should just get called again when ready
	end

	for recipeID = 1, num_recipes, 1 do

		local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(recipeID);

		if skillType == "header" or skillType == nil then -- skip header by increasing recipeID
			recipeID = recipeID +1
			skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(recipeID);
		end
		local difficulty;
		difficulty = DifficultyToNum[skillType];

		local createdItemLink = GetTradeSkillItemLink(recipeID);
		local _, _, id = string.find(createdItemLink, "item:(%d+)");
		local createdItemID = tonumber(id);

		local numReagents = GetTradeSkillNumReagents(recipeID);
		if numReagents > 0 then
			for reagent_Index = 1, numReagents, 1 do
				local reagentLink = GetTradeSkillReagentItemLink(recipeID, reagent_Index);
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(recipeID, reagent_Index);
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
end
