-- In this file:
-- Long sleeves are not handled in base skins in Klei's skin system at the moment, so I'm handling it myself.
-- New base skin variables to handle - base skins with long sleeves and arm_lower_cuff which is a part of long sleeve.

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local TUNING = GLOBAL.TUNING
local CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT
local CHARACTER_INGREDIENT_SEG = GLOBAL.CHARACTER_INGREDIENT_SEG
local AllRecipes = GLOBAL.AllRecipes
local SpawnPrefab = GLOBAL.SpawnPrefab
local ACTIONS = GLOBAL.ACTIONS
local RemovePhysicsColliders = GLOBAL.RemovePhysicsColliders
local FRAMES = GLOBAL.FRAMES
local ActionHandler = GLOBAL.ActionHandler
local EventHandler = GLOBAL.EventHandler
local State = GLOBAL.State
local TimeEvent = GLOBAL.TimeEvent
local GetValidRecipe = GLOBAL.GetValidRecipe
local FOODTYPE = GLOBAL.FOODTYPE
local GetGameModeProperty = GLOBAL.GetGameModeProperty

local _CreatePrefabSkin = GLOBAL.CreatePrefabSkin
GLOBAL.CreatePrefabSkin = function(name, info, ...)
	local prefab_skin = _CreatePrefabSkin(name, info, ...)
	
	prefab_skin.hide_arm_lower_cuff_with_arm_skins = info.hide_arm_lower_cuff_with_arm_skins or false
	prefab_skin.has_arm_lower_skin_symbol = info.has_arm_lower_skin_symbol or false
	prefab_skin.hide_long_sleeves_with_arm_skins = info.hide_long_sleeves_with_arm_skins or false
	
	return prefab_skin
end

-- Internal check functions for SkinsPuppet and Skinner
local function CheckIfShouldHideArmLowerCuff(base_item, prefabname)
	local base_item = base_item or (prefabname .."_none")
	local skindata = GLOBAL.GetSkinData(base_item)
	local skindata_skins = skindata.skins
	return skindata.hide_arm_lower_cuff_with_arm_skins and true or false
end

local function CheckIfShouldHideLongSleeves(base_item, prefabname)
	local base_item = base_item or (prefabname .."_none")
	local skindata = GLOBAL.GetSkinData(base_item)
	local skindata_skins = skindata.skins
	return skindata.has_arm_lower_skin_symbol and skindata.hide_long_sleeves_with_arm_skins and true or false
end

-- Skins fix:
local SkinsPuppet = require("widgets/skinspuppet")
local CLOTHING = GLOBAL.CLOTHING
local _oldSetSkins = SkinsPuppet.SetSkins
function SkinsPuppet:SetSkins(prefabname, base_item, clothing_names, skip_change_emote, skinmode)
	local isghostskin = skinmode ~= nil and skinmode.type ~= nil and skinmode.type == "ghost_skin" and true or false

	if not isghostskin then
		self.animstate:ClearOverrideSymbol("arm_lower")
		self.animstate:ClearOverrideSymbol("arm_upper")
		self.animstate:ClearOverrideSymbol("arm_lower_cuff")
	end

	_oldSetSkins(self, prefabname, base_item, clothing_names, skip_change_emote, skinmode)
	
	local ShouldHideArmLowerCuff = CheckIfShouldHideArmLowerCuff(base_item, prefabname)
	local ShouldHideLongSleeves = CheckIfShouldHideLongSleeves(base_item, prefabname)
	
	if not isghostskin and (ShouldHideLongSleeves or ShouldHideArmLowerCuff) then
	
		local covers_arm_lower = nil
		local covers_arm_upper = nil
		local covers_arm_lower_cuff = nil
		local base_skin_mod = base_item or prefabname
		
		if clothing_names ~= nil then
		
			if clothing_names.body ~= nil and clothing_names.body ~= "" then
				for k,v in pairs (CLOTHING[clothing_names.body].symbol_overrides) do
					if v == "arm_lower" then
						covers_arm_lower = true
					end
					if v == "arm_upper" then
						covers_arm_upper = true
					end
				end
			end
			
			if clothing_names.hand ~= nil and clothing_names.hand ~= "" then
				for k,v in pairs (CLOTHING[clothing_names.hand].symbol_overrides) do
					if v == "arm_lower_cuff" then
						covers_arm_lower_cuff = true
					end
				end
			end
			
			if clothing_names.body ~= nil and clothing_names.body ~= "" then
				if covers_arm_lower == nil and clothing_names.body ~= "" and ShouldHideLongSleeves then
					self.animstate:OverrideSymbol("arm_lower", base_skin_mod, "arm_lower_skin")
				elseif covers_arm_lower == nil and clothing_names.body == "" and ShouldHideLongSleeves then
					self.animstate:OverrideSymbol("arm_lower", base_skin_mod, "arm_lower")
				end
				
				if covers_arm_upper == nil and clothing_names.body ~= "" and ShouldHideLongSleeves then
					self.animstate:OverrideSymbol("arm_upper", base_skin_mod, "missingtex")
				elseif covers_arm_upper == nil and clothing_names.body == "" and ShouldHideLongSleeves then
					self.animstate:OverrideSymbol("arm_upper", base_skin_mod, "arm_upper")
				end
			end
			
			if clothing_names.body ~= nil and clothing_names.body ~= "" or clothing_names.hand ~= nil and clothing_names.hand ~= "" then
				if covers_arm_lower_cuff == nil and (clothing_names.body ~= "" or clothing_names.hand ~= "") and ShouldHideArmLowerCuff then
					self.animstate:OverrideSymbol("arm_lower_cuff", base_skin_mod, "missingtex")
				elseif covers_arm_lower_cuff == nil and (clothing_names.body == "" or clothing_names.hand == "") and ShouldHideArmLowerCuff then
					self.animstate:OverrideSymbol("arm_lower_cuff", base_skin_mod, "arm_lower_cuff")
				end
			end
			
		end
	end
end

local function SkinnerPostInit(skinner)
	local _oldSetSkinMode = skinner.SetSkinMode
    skinner.SetSkinMode = function(self, skintype, default_build)
	
		_oldSetSkinMode(self, skintype, default_build)
		
		--print("Skinner: Running postinit!")
		
		local xXskin_nameXx = (self.skin_name == nil or self.skin_name == "") and nil or self.skin_name
		local ShouldHideArmLowerCuff = xXskin_nameXx and self.inst.prefab and CheckIfShouldHideArmLowerCuff(xXskin_nameXx, self.inst.prefab) or false
		local ShouldHideLongSleeves = xXskin_nameXx and self.inst.prefab and CheckIfShouldHideLongSleeves(xXskin_nameXx, self.inst.prefab) or false
		
		if (skintype == nil or skintype ~= "ghost_skin") and (ShouldHideArmLowerCuff or ShouldHideLongSleeves) then
			--print("Skinner: Prefab is " .. self.inst.prefab)
			local covers_arm_lower = nil
			local covers_arm_upper = nil
			local actual_skin_build = xXskin_nameXx ~= nil and xXskin_nameXx ~= self.inst.prefab .. "_none" and xXskin_nameXx or self.inst.prefab
			
			local has_body_clothing = self.clothing ~= nil and self.clothing["body"] ~= nil and self.clothing["body"] ~= "" and true or false
			local has_hand_clothing = self.clothing ~= nil and self.clothing["hand"] ~= nil and self.clothing["hand"] ~= "" and true or false
			
			if has_body_clothing then
				for k,v in pairs (CLOTHING[self.clothing["body"]].symbol_overrides) do
					if v == "arm_lower" then
						covers_arm_lower = true
					end
					if v == "arm_upper" then
						covers_arm_upper = true
					end
				end
				
				if covers_arm_lower == nil and self.clothing["body"] ~= "" and ShouldHideLongSleeves then
					self.inst.AnimState:OverrideSymbol("arm_lower", actual_skin_build, "arm_lower_skin")
				elseif covers_arm_lower == nil and self.clothing["body"] == "" and ShouldHideLongSleeves then
					self.inst.AnimState:OverrideSymbol("arm_lower", actual_skin_build, "arm_lower")
				end
				
				if covers_arm_upper == nil and self.clothing["body"] ~= "" and ShouldHideLongSleeves then
					self.inst.AnimState:OverrideSymbol("arm_upper", actual_skin_build, "missingtex")
				elseif covers_arm_upper == nil and self.clothing["body"] == "" and ShouldHideLongSleeves then
					self.inst.AnimState:OverrideSymbol("arm_upper", actual_skin_build, "arm_upper")
				end
			end
			
			if has_hand_clothing or has_body_clothing then
				if covers_arm_lower_cuff == nil and (self.clothing["body"] ~= "" or self.clothing["hand"] ~= "") and ShouldHideArmLowerCuff then
					self.inst.AnimState:OverrideSymbol("arm_lower_cuff", actual_skin_build, "missingtex")
				elseif covers_arm_lower_cuff == nil and (self.clothing["body"] == "" or self.clothing["hand"] == "") and ShouldHideArmLowerCuff then
					self.inst.AnimState:OverrideSymbol("arm_lower_cuff", actual_skin_build, "arm_lower_cuff")
				end
			end
			
			if not has_body_clothing and ShouldHideLongSleeves then
				--print("Skinner: Replacing arm symbols with the regular parts.")
				self.inst.AnimState:OverrideSymbol("arm_lower", actual_skin_build, "arm_lower")
				self.inst.AnimState:OverrideSymbol("arm_upper", actual_skin_build, "arm_upper")
			end
			
			if (not has_body_clothing and not has_hand_clothing) and ShouldHideArmLowerCuff then
				--print("Skinner: Replacing arm_lower_cuff with the regular one.")
				self.inst.AnimState:OverrideSymbol("arm_lower_cuff", actual_skin_build, "arm_lower_cuff")
			end
			
		end
	end
end
AddComponentPostInit("skinner", SkinnerPostInit)
