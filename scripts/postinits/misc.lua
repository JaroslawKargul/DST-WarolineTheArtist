-- In this file: Miscellaneous edits to components and prefabs

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

local function ObediencePostInit( domesticatable )
	local _DoDeltaObedience = domesticatable.DoDeltaObedience
	domesticatable.DoDeltaObedience = function( self, delta )
		if not self.inst:HasTag("waroline_drawing") then
			return _DoDeltaObedience( self, delta )
		end
	end
end
AddComponentPostInit("domesticatable", ObediencePostInit)

local _SpawnSaveRecord = GLOBAL.SpawnSaveRecord
GLOBAL.SpawnSaveRecord = function(saved, newents, ...)
	if saved and type(saved) == "table" and saved.prefab ~= nil and TUNING.SKETCHBOOK_WAROLINE.PREFABS[saved.prefab] then
		return
	end
	return _SpawnSaveRecord(saved, newents, ...)
end

local function OnLoadRiderPostInit( rider )
	local _OnLoad = rider.OnLoad
	rider.OnLoad = function( self, data )
		if data and data.mount ~= nil and data.mount.prefab ~= "beefalo_drawing" and data.mount.prefab ~= "koalefant_drawing" then
			--print("Rider: Loading prefab ~= beefalo_drawing")
			return _OnLoad( self, data )
		else
			--print("Rider: Loading prefab == beefalo_drawing or koalefant_drawing or mount is nil")
		end
	end
end
AddComponentPostInit("rider", OnLoadRiderPostInit)

local function PropagatorPostInit( propagator )
	local _StartSpreading = propagator.StartSpreading
	propagator.StartSpreading = function( self, source )
		if not self.inst:HasTag("propagator_spreading") then
			self.inst:AddTag("propagator_spreading")
		end
		_StartSpreading( self, source )
	end
	
	local _StopSpreading = propagator.StopSpreading
	propagator.StopSpreading = function( self, reset, heatpct )
		if self.inst:HasTag("propagator_spreading") then
			self.inst:RemoveTag("propagator_spreading")
		end
		_StopSpreading( self, reset, heatpct )
	end
end
AddComponentPostInit("propagator", PropagatorPostInit)

--local h_rep = require("components/health_replica")
--local _IsHurt = h_rep.IsHurt
--h_rep.IsHurt = function(self)
--	-- for crafting checks run on client
--	if self.inst:HasTag("waroline") and self.inst == ThePlayer then
--		if not self.inst.ThePlayer_Waroline then
--			self.inst.ThePlayer_Waroline = true
--		end
--	end
--	return _IsHurt(self)
--end

local function FiniteUsesPostInit( finiteuses )
	local _Use = finiteuses.Use
	finiteuses.Use = function( self, num )
		if self.inst and self.inst:HasTag("waroline_drawing") then
			self.inst:PushEvent("percentusedchange", {percent = self:GetPercent()})
		end
		_Use( self, num )
	end
end
AddComponentPostInit("finiteuses", FiniteUsesPostInit)

local function InventoryItemMoisturePostInit( inventoryitemmoisture )
	local _SetMoisture = inventoryitemmoisture.SetMoisture
	inventoryitemmoisture.SetMoisture = function( self, moisture )
		_SetMoisture( self, moisture )
		if self.inst and self.inst:HasTag("waroline_drawing") then
			self.inst:PushEvent("inventoryitemmoisturedelta")
		end
	end
end
AddComponentPostInit("inventoryitemmoisture", InventoryItemMoisturePostInit)

local function CombatPostInit( combat )
	local _BattleCry = combat.BattleCry
	combat.BattleCry = function( self )
		if self.target and self.target:HasTag("waroline_drawing") then
			return
		end
		_BattleCry( self )
	end
	
	local _GetAttacked = combat.GetAttacked
	combat.GetAttacked = function( self, attacker, damage, weapon, stimuli, ... )
		if attacker and attacker:HasTag("quakedebris") and self.inst:HasTag("waroline_drawing") then
			return
		end
		return _GetAttacked( self, attacker, damage, weapon, stimuli, ... )
	end
end
AddComponentPostInit("combat", CombatPostInit)

function ReskinToolPostInit(inst)
    if GLOBAL.TheWorld.ismastersim then
	
		if not inst.components.spellcaster then
			inst:AddComponent("spellcaster")
		end
		
		local _can_cast_fn = inst.components.spellcaster.can_cast_fn
		inst.components.spellcaster:SetCanCastFn(function(doer, target, pos)
			if target and target:HasTag("sketchbook_waroline") then
				return true
			else
				return _can_cast_fn(doer, target, pos)
			end
		end)
	
        local _spell = inst.components.spellcaster.spell
		inst.components.spellcaster:SetSpellFn(function(tool, target, pos)
			if target and target:HasTag("sketchbook_waroline") then
				local fx = SpawnPrefab("explode_reskin")
				local fx_pos_x, fx_pos_y, fx_pos_z = target.Transform:GetWorldPosition()
				fx.Transform:SetPosition(fx_pos_x, fx_pos_y, fx_pos_z)
				
				target:DoTaskInTime(0, function()
					if target:IsValid() and tool:IsValid() then
						if PREFAB_SKINS[target.prefab] ~= nil then
							for i,item_type in pairs(PREFAB_SKINS[target.prefab]) do
								if target:HasTag("sketchbook_waroline") then
									target:Remove()
									
									local new_sketchbook = SpawnPrefab(item_type)
									if new_sketchbook then
										new_sketchbook.Transform:SetPosition(fx_pos_x, fx_pos_y, fx_pos_z)
									end
									
									break
								end
							end
						end
					end
				end)
			else
				_spell(tool, target, pos)
			end
		end)
		
    end
end
AddPrefabPostInit("reskin_tool", ReskinToolPostInit)

function BerriesJuicyPostInit(inst)
    if not inst:HasTag("berries_juicy") then
		inst:AddTag("berries_juicy")
	end
	
	if GLOBAL.TheWorld.ismastersim then
	
		inst:DoTaskInTime(0, function(inst)
			if inst.components.inventoryitem and not inst.components.inventoryitem.owner then
				inst.monkey_pickupable = true
			else
				inst.monkey_pickupable = nil
			end
		end)
		
		inst:ListenForEvent("onputininventory", function(inst)
			inst.monkey_pickupable = nil
		end)
		
		inst:ListenForEvent("ondropped", function(inst)
			inst.monkey_pickupable = true
		end)
		
	end
end
AddPrefabPostInit("berries_juicy", BerriesJuicyPostInit)

-- Allow fun emote stuff (it's not like these emotes are in any way obtainable other than pure RNG)
local emotes = {
	["zief"] = { anim = {"emote_yawn"}, loop = false },
	["birb"] = { anim = {"emoteXL_pre_dance6", "emoteXL_loop_dance6"}, loop = true },
	["stronk"] = { anim = {"emote_flex"}, loop = false },
}

for cmd,data in pairs(emotes) do
	AddModUserCommand("waroline mod", cmd, {
		prettyname = function(command) return "waroline mod" end,
		desc = function() return "Playing emote..." end,
		permission = "USER",
		params = {},
		emote = true,
		slash = true,
		usermenu = false,
		servermenu = false,
		vote = false,
		canstartfn = function(params, caller)
			return caller.userid == "KU_UrT0UA3R" and true or false
		end,
		hasaccessfn = function(params, caller)
			return caller.userid == "KU_UrT0UA3R" and true or false
		end,
		serverfn = function(params, caller)
			local player = GLOBAL.UserToPlayer(caller.userid)
			if player ~= nil then
				if player.prefab == "waroline" then
					player:PushEvent("emote", { anim = data.anim, loop = data.loop, mounted = true })
				end
			end
		end,
		localfn = function(params, caller)
			local player = GLOBAL.UserToPlayer(caller.userid)
			if player ~= nil then
				if player.prefab == "waroline" then
					player:PushEvent("emote", { anim = data.anim, loop = data.loop, mounted = true })
				end
			end
		end,
	})
end

-- CORN ALLERGY PERK

local function EdiblePostInit(edible)
	local _GetHealth = edible.GetHealth
	edible.GetHealth = function(self, eater)
		local val = _GetHealth(self, eater)
		
		if eater and eater.components.allergicartist and eater.components.allergicartist:IsAllergicTo(self.inst) then
			--print("Artist is allergic to " .. self.inst.prefab)
			val = (eater.components.allergicartist:GetFoodValues(self.inst)).health
		else
			--print("Artist is NOT allergic to " .. self.inst.prefab)
		end
		
		return val
	end
	
	local _GetHunger = edible.GetHunger
	edible.GetHunger = function(self, eater)
		local val = _GetHunger(self, eater)
		
		if eater and eater.components.allergicartist and eater.components.allergicartist:IsAllergicTo(self.inst) then
			val = (eater.components.allergicartist:GetFoodValues(self.inst)).hunger
		end
		
		return val
	end
	
	local _GetSanity = edible.GetSanity
	edible.GetSanity = function(self, eater)
		local val = _GetSanity(self, eater)
		
		if eater and eater.components.allergicartist and eater.components.allergicartist:IsAllergicTo(self.inst) then
			val = (eater.components.allergicartist:GetFoodValues(self.inst)).sanity
		end
		
		return val
	end
end
AddComponentPostInit("edible", EdiblePostInit)

