-- In this file: Stategraph edits for drawing creatures + new creature-specific actions

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

-- GENERIC
local DRAWINGTRANSFERINV = GLOBAL.Action({ priority = 1})	
DRAWINGTRANSFERINV.str = "Transfer Inventory"
DRAWINGTRANSFERINV.id = "DRAWINGTRANSFERINV"
DRAWINGTRANSFERINV.fn = function(act)
	local tar = act.target
	if tar ~= nil and
        tar.components.inventory ~= nil and
        act.doer and
		act.doer.components.inventory then
			--act.doer.components.inventory:TransferInventory(tar)
			
			local inv = tar.components.inventory

			for k,v in pairs(act.doer.components.inventory.itemslots) do
				inv:GiveItem(act.doer.components.inventory:RemoveItemBySlot(k))
			end
			
			return true
    end
end
AddAction(DRAWINGTRANSFERINV)

AddComponentAction("SCENE", "inventory", function(inst, doer, actions, right)
    if doer:HasTag("waroline_drawing") and inst.replica.inventory then
        table.insert(actions, ACTIONS.DRAWINGTRANSFERINV)
    end
end)

-- OLD CODE, BEFORE DRAWING STATEGRAPHS WERE SPLIT INTO SEPARATE FILES FROM THE ORIGINAL MOBS
--[[
-- RABBIT_DRAWING
local function SGrabbitPostInit(sg)
	-- RUN
	local _run_onenter = sg.states["run"].onenter
	
	sg.states["run"].onenter = function(inst)
		if inst.prefab == "rabbit_drawing" then
            inst.AnimState:PlayAnimation("run_pre")
            inst.AnimState:PushAnimation("run", true)
            inst.components.locomotor:RunForward()
		else
			_run_onenter(inst)
		end
	end
	
	-- DEATH
	local _death_onenter = sg.states["death"].onenter
	
	sg.states["death"].onenter = function(inst)
		if inst.prefab == "rabbit_drawing" then
            inst.SoundEmitter:PlaySound(inst.sounds.scream)
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst) 
		else
			_death_onenter(inst)
		end
	end
	
	-- EAT
	local _eat_onenter = sg.states["eat"].onenter
	
	sg.states["eat"].onenter = function(inst)
		if inst.prefab == "rabbit_drawing" then
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("rabbit_eat_pre", false)
            inst.AnimState:PushAnimation("rabbit_eat_loop", true)
			
			if inst.bufferedaction and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.DRAWINGTRANSFERINV then
				inst.sg:SetTimeout(0.25)
			else
				inst.sg:SetTimeout(0.8)
			end
		else
			_eat_onenter(inst)
		end
	end
	
	local _eat_ontimeout = sg.states["eat"].ontimeout
	
	sg.states["eat"].ontimeout = function(inst)
		if inst.prefab == "rabbit_drawing" and inst.bufferedaction ~= nil and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.PICK then
            inst:PerformBufferedAction()
			local all_items = inst.components.inventory:ReferenceAllItems()
			local can_be_displayed_in_mouth_item = nil
			
			for i,v in ipairs(all_items) do
				if v ~= nil and v.prefab ~= nil and table.contains(TUNING.RABBIT_DRAWING_SUPPORTED_VEGGIES, v.prefab) then
					can_be_displayed_in_mouth_item = v
					break
				end
			end
			
			if inst.components.inventory and #(all_items) > 0 then
				if can_be_displayed_in_mouth_item then
					inst.HaveCarrot(inst, can_be_displayed_in_mouth_item)
				else
					inst.components.inventory:DropEverything()
					inst.RemoveCarrot(inst)
				end
			else
				if inst.components.hauntable then
					inst.components.hauntable:Panic(1.5)
				end
				inst.RemoveCarrot(inst)
			end
            inst.sg:GoToState("idle", "rabbit_eat_pst")
		
		elseif inst.prefab == "rabbit_drawing" and inst.bufferedaction ~= nil and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.DRAWINGTRANSFERINV then
			if inst:HasTag("carrot_searching") then
				inst:RemoveTag("carrot_searching")
			end
			
			inst:PerformBufferedAction()
			inst.RemoveCarrot(inst)
			inst.sg:GoToState("idle", "rabbit_eat_pst")
			
		else
			_eat_ontimeout(inst)
		end
	end
	
	-- HOP (Don't hesitate, baby! Get that carrot!)
	local _hop_onenter = sg.states["hop"].onenter
	
	sg.states["hop"].onenter = function(inst)
		if inst.prefab == "rabbit_drawing" and inst:HasTag("carrot_searching") then
            inst.AnimState:PlayAnimation("walk")
            inst.components.locomotor:WalkForward()
            inst.sg:SetTimeout(0.6)
		else
			_hop_onenter(inst)
		end
	end
	
end
AddStategraphPostInit("rabbit", SGrabbitPostInit)

local rabbit_pickhandler = ActionHandler(ACTIONS.PICK, "eat")
AddStategraphActionHandler("rabbit", rabbit_pickhandler)

local rabbit_transferhandler = ActionHandler(ACTIONS.DRAWINGTRANSFERINV, "eat")
AddStategraphActionHandler("rabbit", rabbit_transferhandler)

-- PIGMAN_DRAWING
local function SGpigPostInit(sg)
	-- FUNNYIDLE
	if sg.states["funnyidle"] then -- check first for compatibility with some other mods
		local _funnyidle_onenter = sg.states["funnyidle"].onenter
		
		sg.states["funnyidle"].onenter = function(inst)
			if inst.prefab == "pigman_drawing" then
				inst.Physics:Stop()
				inst.SoundEmitter:PlaySound("dontstarve/pig/oink")
				if math.random() > 0.5 then
					inst.AnimState:PlayAnimation("idle_happy")
				else
					inst.AnimState:PlayAnimation("idle_creepy")
				end
			else
				_funnyidle_onenter(inst)
			end
		end
	end
	
	-- DEATH
	local _death_onenter = sg.states["death"].onenter
	
	sg.states["death"].onenter = function(inst)
		if inst.prefab == "pigman_drawing" then
            inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
		else
			_death_onenter(inst)
		end
	end
end
AddStategraphPostInit("pig", SGpigPostInit)

-- SPIDER_DRAWING
local function SGspiderPostInit(sg)
	-- DEATH
	local _death_onenter = sg.states["death"].onenter
	
	local function SoundPath(inst, event)
		local creature = "spider"

		if inst:HasTag("spider_moon") then
			return "turnoftides/creatures/together/spider_moon/" .. event
		elseif inst:HasTag("spider_warrior") then
			creature = "spiderwarrior"
		elseif inst:HasTag("spider_hider") or inst:HasTag("spider_spitter") then
			creature = "cavespider"
		else
			creature = "spider"
		end
		return "dontstarve/creatures/" .. creature .. "/" .. event
	end
	
	sg.states["death"].onenter = function(inst)
		if inst.prefab == "spider_drawing" then
            inst.SoundEmitter:PlaySound(SoundPath(inst, "die"))
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
		else
			_death_onenter(inst)
		end
	end
end
AddStategraphPostInit("spider", SGspiderPostInit)

-- SMALLBIRD_DRAWING
local function SGsmallbirdPostInit(sg)
	-- ATTACK
	sg.states["attack"].tags = {"attack", "busy"}
	
	local _attack_onenter = sg.states["attack"].onenter
	
	sg.states["attack"].onenter = function(inst)
		if inst.prefab == "smallbird_drawing" then
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("atk", false)
		else
			_attack_onenter(inst)
		end
	end
end
AddStategraphPostInit("smallbird", SGsmallbirdPostInit)

-- BEEFALO_DRAWING
local function SGbeefaloPostInit(sg)
	-- IDLE
	local _idle_ontimeout = sg.states["idle"].ontimeout
	
	sg.states["idle"].ontimeout = function(inst)
		if inst.prefab == "beefalo_drawing" then
			if math.random() >= 0.5 then
				inst.sg:GoToState("shake")
			else
				inst.sg:GoToState("idle", true)
			end
		else
			_idle_ontimeout(inst)
		end
	end

	-- DEATH
	local _death_onenter = sg.states["death"].onenter
	
	sg.states["death"].onenter = function(inst)
		if inst.prefab == "beefalo_drawing" then
            inst.SoundEmitter:PlaySound(inst.sounds.yell)
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
			
            inst:DoTaskInTime(2, GLOBAL.ErodeAway)
		else
			_death_onenter(inst)
		end
	end
	
end
AddStategraphPostInit("beefalo", SGbeefaloPostInit)

-- KOALEFANT_DRAWING
local function SGkoalefantPostInit(sg)
	-- IDLE
	local _idle_ontimeout = sg.states["idle"].ontimeout
	
	sg.states["idle"].ontimeout = function(inst)
		if inst.prefab == "koalefant_drawing" then
			if math.random() >= 0.5 then
				inst.sg:GoToState("shake")
			else
				inst.sg:GoToState("idle", true)
			end
		else
			_idle_ontimeout(inst)
		end
	end

	-- DEATH
	local _death_onenter = sg.states["death"].onenter
	
	sg.states["death"].onenter = function(inst)
		if inst.prefab == "koalefant_drawing" then
            inst.SoundEmitter:PlaySound("dontstarve/creatures/koalefant/yell")
            inst.AnimState:PlayAnimation("death")
            inst.components.locomotor:StopMoving()
		else
			_death_onenter(inst)
		end
	end
end
AddStategraphPostInit("koalefant", SGkoalefantPostInit)

-- MONKEY_DRAWING
local function SGmonkeyPostInit(sg)
	-- Sketch Monkey does not have a ranged attack - redirect all attack attempts to "attack" state
	local _EventHandlerDoAttack = sg.events["doattack"].fn
	sg.events["doattack"].fn = function(inst, data)
		if inst.prefab == "monkey_drawing" and not (inst.components.health:IsDead() or inst.sg:HasStateTag("busy")) then
            inst.sg:GoToState("attack")
		else
			_EventHandlerDoAttack(inst, data)
        end
	end

	-- THROW (re-used for mining/chopping in monkey_drawing)
	local _throw_onenter = sg.states["throw"].onenter
	
	sg.states["throw"].onenter = function(inst)
		if inst.prefab == "monkey_drawing" then
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("throw")
		else
			_throw_onenter(inst)
		end
	end
	
	local _timeline1_fn = sg.states["throw"].timeline[1].fn
	sg.states["throw"].timeline[1].fn = function(inst)
		if inst.prefab == "monkey_drawing" then
			if inst.bufferedaction then
				if inst.bufferedaction.action ~= nil and inst.bufferedaction.action == ACTIONS.MINE and inst.bufferedaction.target then
					local target = inst.bufferedaction.target ~= nil and inst.bufferedaction.target or nil
					local frozen = target ~= nil and inst.bufferedaction.target:HasTag("frozen")
					local moonglass = target ~= nil and target:HasTag("moonglass")
					if target ~= nil and target.Transform ~= nil then
						local pos_x, pos_y, pos_z = target.Transform:GetWorldPosition()
						local fx = GLOBAL.SpawnPrefab(frozen and "mining_ice_fx" or "mining_fx")
						if fx ~= nil and fx:IsValid() and pos_x ~= nil then
							fx.Transform:SetPosition(pos_x, pos_y, pos_z)
						elseif fx ~= nil then
							fx:Remove()
						end
                    end
					inst.SoundEmitter:PlaySound((frozen and "dontstarve_DLC001/common/iceboulder_hit") or (moonglass and "turnoftides/common/together/moon_glass/mine") or "dontstarve/wilson/use_pick_rock")
				else
					inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/throw")
				end
				inst:PerformBufferedAction()
			end
		else
			_timeline1_fn(inst)
		end
	end
	
	-- ACTION
	if not sg.states["action"].timeline then
		sg.states["action"].timeline = {}
	end
	
	sg.states["action"].timeline[1] = GLOBAL.TimeEvent(10*FRAMES, function(inst)
		if inst.bufferedaction and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.DRAWINGTRANSFERINV and inst.prefab == "monkey_drawing" then
			inst:PerformBufferedAction()
			inst.sg:GoToState("idle")
		end
	end)
	
	sg.states["action"].timeline[2] = GLOBAL.TimeEvent(21*FRAMES, function(inst)
		if inst.bufferedaction and inst.prefab == "monkey_drawing" then
			inst:PerformBufferedAction()
		end
	end)
	
	-- DIFFERENTIATE JOSTLEPICK FROM REGULAR PICKING
	local _ActionHandlerPICK = sg.actionhandlers[ACTIONS.PICK].deststate
	sg.actionhandlers[ACTIONS.PICK].deststate = function(inst, action)
		return inst:HasTag("waroline_drawing") and action and action.target and action.target:HasTag("jostlepick") and "throw" or _ActionHandlerPICK(inst, action)
	end
end
AddStategraphPostInit("monkey", SGmonkeyPostInit)

local monkey_chophandler = ActionHandler(ACTIONS.CHOP, "throw")
AddStategraphActionHandler("monkey", monkey_chophandler)

local monkey_minehandler = ActionHandler(ACTIONS.MINE, "throw")
AddStategraphActionHandler("monkey", monkey_minehandler)

local monkey_unpinhandler = ActionHandler(ACTIONS.UNPIN, "action")
AddStategraphActionHandler("monkey", monkey_unpinhandler)

local monkey_interactwithhandler = ActionHandler(ACTIONS.INTERACT_WITH, "action")
AddStategraphActionHandler("monkey", monkey_interactwithhandler)

local monkey_transferhandler = ActionHandler(ACTIONS.DRAWINGTRANSFERINV, "action")
AddStategraphActionHandler("monkey", monkey_transferhandler)
]]--

-- GOBBLERS SHOULD INFORM SKETCH SPLUMONKEYS (AND PIGMEN) ABOUT THEM APPEARING
local function SGperdPostInit(sg)
	-- APPEAR
	local _appear_onenter = sg.states["appear"].onenter
	
	sg.states["appear"].onenter = function(inst)
		local function find_monkey(target, inst)
			return target ~= nil and target.components.warolinedrawing ~= nil and target.components.warolinedrawing:IsFighter() and true or false
		end
		local MONKEY_DIST = 10
		local _MUST_TAGS = { "waroline_drawing" }
		local _CANNOT_TAGS = { "INLIMBO" }
        local monkey = FindEntity(inst, MONKEY_DIST, find_monkey, _MUST_TAGS, _CANNOT_TAGS)
		
		if monkey and monkey.components.combat then
			monkey.components.combat:SuggestTarget(inst)
		end
		
		_appear_onenter(inst)
		
	end
end
AddStategraphPostInit("perd", SGperdPostInit)

local function GetBerries(inst)
	--print("Running GetBerries...")
	local BERRY_DIST = 4
	local function find_berry(target, inst)
		return target ~= nil and target.prefab ~= nil and target.prefab == "berries_juicy" and target.components.inventoryitem and not target.components.inventoryitem.owner and true or false
	end

	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, BERRY_DIST)
	
	local berries = {}
	for i, v in ipairs(ents) do
		if find_berry(v, inst) then
			table.insert(berries, v)
		end
	end
	
	if #berries > 0 then
		--print("Berry found!")
		inst.loot_to_pick_up = nil
		inst.loot_to_pick_up = berries
		inst.continue_picking_after = true
	else
		inst.loot_to_pick_up = nil
		inst.continue_picking_after = nil
	end
end

-- Get droppicked loot and store it in a variable. It will get accessed by the brain soon enough.
local _PickFn = ACTIONS.PICK.fn
ACTIONS.PICK.fn = function(act)
	local target = act.target
	local inst = act.doer

	local pick = _PickFn(act)
	
	if inst and inst:HasTag("waroline_drawing") and target and target.components.pickable and target.prefab == "berrybush_juicy" then
		--print("Monkey has picked!")
		
        inst:DoTaskInTime(.5, function(inst)
			GetBerries(inst)
		end)
    end
	
	return pick
end
