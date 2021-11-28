-- In this file: Edits to existing player actions + new player actions

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

--- [[[ -- ACTIONS -- ]]] ---

local _SaddleFn = ACTIONS.SADDLE.fn
ACTIONS.SADDLE.fn = function(act) 
	if act.target:HasTag("waroline_drawing") then
        return false, "WAROLINE_DRAWING"
    else
		return _SaddleFn(act)
    end
end

--- [[[ -- NEW ACTIONS -- ]]] ---

local DRAWINGTAKEHAT = GLOBAL.Action({ priority = 1})	
DRAWINGTAKEHAT.str = "Take Hat"
DRAWINGTAKEHAT.id = "DRAWINGTAKEHAT"
DRAWINGTAKEHAT.fn = function(act)
	local tar = act.target or act.invobject
	if tar ~= nil and
        tar.components.inventory ~= nil and
        tar.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HEAD) ~= nil and
        act.doer and
		act.doer.components.inventory then
			act.doer.components.inventory:GiveItem(tar.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HEAD))
			return true
    end
end
AddAction(DRAWINGTAKEHAT)

local retrievehat_handler = ActionHandler(ACTIONS.DRAWINGTAKEHAT, function(inst)
	return "doshortaction"
end)
AddStategraphActionHandler("wilson", retrievehat_handler)

local retrievehat_handler_client = ActionHandler(ACTIONS.DRAWINGTAKEHAT, "doshortaction")
AddStategraphActionHandler("wilson_client", retrievehat_handler_client)

--

local DRAWINGTAKECARROT = GLOBAL.Action({ priority = 1})	
DRAWINGTAKECARROT.str = "Take Item"
DRAWINGTAKECARROT.id = "DRAWINGTAKECARROT"
DRAWINGTAKECARROT.fn = function(act)
	local tar = act.target
	if tar ~= nil and
        tar.components.inventory ~= nil and
        tar:HasTag("has_carrot") and
        act.doer and
		act.doer.components.inventory then
			local carrot = tar.components.inventory:FindItem(function(item) return item ~= nil and item.prefab == "carrot" end)
			if carrot then
				tar.RemoveCarrot(tar, carrot)
			else
				tar.RemoveCarrot(tar)
			end
			tar.components.inventory:TransferInventory(act.doer)
			return true
    end
end
AddAction(DRAWINGTAKECARROT)

local takecarrot_handler = ActionHandler(ACTIONS.DRAWINGTAKECARROT, function(inst)
	return "doshortaction"
end)
AddStategraphActionHandler("wilson", takecarrot_handler)

local takecarrot_handler_client = ActionHandler(ACTIONS.DRAWINGTAKECARROT, "doshortaction")
AddStategraphActionHandler("wilson_client", takecarrot_handler_client)

--

AddComponentAction("SCENE", "warolinedrawingclient", function(inst, doer, actions, right)
    if right and doer and doer:HasTag("player") and inst:HasTag("waroline_drawing") then
		if inst:HasTag("has_hat") then
			table.insert(actions, ACTIONS.DRAWINGTAKEHAT)
		elseif inst:HasTag("has_carrot") then
			table.insert(actions, ACTIONS.DRAWINGTAKECARROT)
		end
    end
end)
