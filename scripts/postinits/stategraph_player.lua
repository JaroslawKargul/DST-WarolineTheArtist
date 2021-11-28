-- In this file: Stategraph edits for SGwilson and SGwilson_client

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

-- WILSON
local function SGWilsonPostInit(sg) 
	-- MOUNT
	local _timeline2_fn = sg.states["mount"].timeline[2].fn
	
	sg.states["mount"].timeline[2].fn = function(inst)
		if not inst.sg.statemem.heavy and inst.components.rider and inst.components.rider.mount and inst.components.rider.mount.prefab == "koalefant_drawing" then
			inst.SoundEmitter:PlaySound("dontstarve/creatures/koalefant/alert") 
		else
			_timeline2_fn(inst)
		end
	end
	
	-- TOOLBROKE
	local _toolbroke_onenter = sg.states["toolbroke"].onenter
	sg.states["toolbroke"].onenter = function(inst, tool)
		if tool and tool:HasTag("waroline_drawing") then
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
            inst.AnimState:Hide("ARM_carry")
            inst.AnimState:Show("ARM_normal")

            if tool == nil or not tool.nobrokentoolfx then
				SpawnPrefab("brokentool_drawing").Transform:SetPosition(inst.Transform:GetWorldPosition())
            end

            inst.sg.statemem.toolname = tool ~= nil and tool.prefab or nil

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.sg:SetTimeout(10 * FRAMES)
		else
			_toolbroke_onenter(inst, tool)
		end
	end
	
end
AddStategraphPostInit("wilson", SGWilsonPostInit)

--- SKETCHBOOK ANIMS ---

local waroline_sketchbook = State{
	name = "sketchbook_idle",
	tags = { "idle", "sketch_idle" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
		
		local INV = inst.replica.inventory ~= nil and inst.replica.inventory or inst.components.inventory ~= nil and inst.components.inventory
		local _sketchbook = INV and INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS):HasTag("sketchbook_waroline") and INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
		local sketchbook_build = _sketchbook and _sketchbook.WarolineSkinName ~= nil and "symbol_waroline_sketchbook" .. _sketchbook.WarolineSkinName or "symbol_waroline_sketchbook"
		inst.AnimState:OverrideSymbol("book_cook", sketchbook_build, "book_cook")
		
		if inst.sg.laststate == nil or inst.sg.laststate.name == "sketchbook_draw" then
			inst.AnimState:PlayAnimation("waroline_sketchbook_idle_loop", true)
		else
			inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close")
			inst.AnimState:PlayAnimation("waroline_sketchbook_idle_pre_pre", false)
			inst.AnimState:PushAnimation("waroline_sketchbook_idle_pre", false)
			inst.AnimState:PushAnimation("waroline_sketchbook_idle_loop", true)
		end
	end,

	events =
	{
		EventHandler("unequip", function(inst)
			inst.sg:GoToState("idle")
		end),
		
	},

	onexit = function(inst)
	end,
}

local waroline_draw = State{
	name = "sketchbook_draw",
	tags = { "busy", "doing", "sketch_draw" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
		
		inst.AnimState:SetDeltaTimeMultiplier(1)
		
		local INV = inst.replica.inventory ~= nil and inst.replica.inventory or inst.components.inventory ~= nil and inst.components.inventory
		local _sketchbook = INV and INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS):HasTag("sketchbook_waroline") and INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
		local sketchbook_build = _sketchbook and _sketchbook.WarolineSkinName ~= nil and "symbol_waroline_sketchbook" .. _sketchbook.WarolineSkinName or "symbol_waroline_sketchbook"
		inst.AnimState:OverrideSymbol("book_cook", sketchbook_build, "book_cook")
		
		local RIDING = inst.replica.rider ~= nil and inst.replica.rider or inst.components.rider ~= nil and inst.components.rider
		local IsNotRiding = not RIDING or RIDING and not RIDING:IsRiding()
		
		if IsNotRiding then
			inst.AnimState:PlayAnimation("waroline_sketchbook_draw", false)
		else
			inst.AnimState:PlayAnimation("waroline_sketchbook_draw_mount", false)
		end
		
		inst.sg.statemem.action = inst.bufferedaction
	end,

	timeline =
	{
		TimeEvent(8 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/waroline/drawing_sound") end),
		TimeEvent(23 * FRAMES, function(inst)
			inst:PerformBufferedAction()
		end),
		TimeEvent(25 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("busy")
		end),
	},

	events =
	{
		EventHandler("animqueueover", function(inst)
			local INV = inst.replica.inventory ~= nil and inst.replica.inventory or inst.components.inventory ~= nil and inst.components.inventory
			local RIDING = inst.replica.rider ~= nil and inst.replica.rider or inst.components.rider ~= nil and inst.components.rider
			
			local NotHasOneManBand = INV and (not INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY) or INV:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY).prefab ~= "onemanband")
			local IsNotRiding = not RIDING or RIDING and not RIDING:IsRiding()
			
			if NotHasOneManBand and IsNotRiding and inst.AnimState:AnimDone() and inst:HasTag("sketchbook_user") then
				inst.sg:GoToState("sketchbook_idle")
			else
				inst.sg:GoToState("idle")
			end
		end),
	},

	onexit = function(inst)
	end,
}

local waroline_draw_client = State{
	name = "sketchbook_draw",
	tags = { "busy", "doing", "sketch_draw" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
		inst.components.locomotor:StopMoving()
		
		inst.AnimState:SetDeltaTimeMultiplier(1)
		
		--HACK: Let server animate
        inst.entity:SetIsPredictingMovement(false)
		
		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(2)
	end,

	timeline =
	{
		TimeEvent(8 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/characters/waroline/drawing_sound", "drawing_sound")
		end),
		TimeEvent(25 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("busy")
		end),
	},
	
	onupdate = function(inst)
		if inst:HasTag("doing") then
			if inst.entity:FlattenMovementPrediction() then
				inst.sg:GoToState("idle", "noanim")
			end
			
		elseif inst.bufferedaction == nil then
			inst.sg:GoToState("idle", true)
		end
	end,

	onexit = function(inst)
		inst.SoundEmitter:KillSound("drawing_sound")
		inst.entity:SetIsPredictingMovement(true)
	end,
}

-- QUICK EAT ANIM

local waroline_quickeat = State{
	name = "waroline_quickeat",
	tags = { "busy" },

	onenter = function(inst, foodinfo)
		inst.components.locomotor:Stop()

		local feed = foodinfo and foodinfo.feed
		if feed ~= nil then
			inst.components.locomotor:Clear()
			inst:ClearBufferedAction()
			inst.sg.statemem.feed = foodinfo.feed
			inst.sg.statemem.feeder = foodinfo.feeder
			inst.sg:AddStateTag("pausepredict")
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:RemotePausePrediction()
			end
		elseif inst:GetBufferedAction() then
			feed = inst:GetBufferedAction().invobject
		end

		if inst.components.inventory:IsHeavyLifting() and
			not inst.components.rider:IsRiding() then
			inst.AnimState:PlayAnimation("heavy_quick_eat")
		else
			inst.AnimState:PlayAnimation("quick_eat_pre")
			inst.AnimState:PushAnimation("quick_eat", false)
		end

		if inst.components.hunger then
			inst.components.hunger:Pause()
		end
	end,

	timeline =
	{
		TimeEvent(12 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/eat", "eating")
			inst.AnimState:SetDeltaTimeMultiplier(.55) -- slow down
		end),
		TimeEvent(24 * FRAMES, function(inst)
			inst.AnimState:SetDeltaTimeMultiplier(1)
			if inst.sg.statemem.feed ~= nil and inst.components.eater then
				inst.components.eater:Eat(inst.sg.statemem.feed, inst.sg.statemem.feeder)
			else
				inst:PerformBufferedAction()
			end
			inst.sg:RemoveStateTag("busy")
			inst.sg:RemoveStateTag("pausepredict")
		end),
	},

	events =
	{
		EventHandler("animqueueover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.AnimState:SetDeltaTimeMultiplier(1)
				inst.sg:GoToState("idle")
			end
		end),
	},

	onexit = function(inst)
		inst.SoundEmitter:KillSound("eating")
		if not GetGameModeProperty("no_hunger") and inst.components.hunger then
			inst.components.hunger:Resume()
		end
		if inst.sg.statemem.feed ~= nil and inst.sg.statemem.feed:IsValid() then
			inst.sg.statemem.feed:Remove()
		end
		inst.AnimState:SetDeltaTimeMultiplier(1)
	end,
}

local waroline_quickeat_client = State{
	name = "waroline_quickeat",
	tags = { "busy" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
		inst.AnimState:PlayAnimation("quick_eat_pre")
		inst.AnimState:PushAnimation("quick_eat_lag", false)

		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(TIMEOUT)
	end,

	onupdate = function(inst)
		if inst:HasTag("busy") then
			if inst.entity:FlattenMovementPrediction() then
				inst.sg:GoToState("idle", "noanim")
			end
		elseif inst.bufferedaction == nil then
			inst.sg:GoToState("idle")
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:GoToState("idle")
	end,
}

-- LONG EAT ANIM

local waroline_eat = State{
	name = "waroline_eat",
	tags = { "busy", "nodangle" },

	onenter = function(inst, foodinfo)
		inst.components.locomotor:Stop()

		inst.AnimState:SetDeltaTimeMultiplier(1)

		local feed = foodinfo and foodinfo.feed
		if feed ~= nil then
			inst.components.locomotor:Clear()
			inst:ClearBufferedAction()
			inst.sg.statemem.feed = foodinfo.feed
			inst.sg.statemem.feeder = foodinfo.feeder
			inst.sg:AddStateTag("pausepredict")
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:RemotePausePrediction()
			end
		elseif inst:GetBufferedAction() then
			feed = inst:GetBufferedAction().invobject
		end

		if inst.components.inventory:IsHeavyLifting() and
			not inst.components.rider:IsRiding() then
			inst.AnimState:PlayAnimation("heavy_eat")
		else
			inst.AnimState:PlayAnimation("eat_pre")
			inst.AnimState:PushAnimation("eat", false)
		end
		
		if inst.components.hunger then
			inst.components.hunger:Pause()
		end
	end,

	timeline =
	{
		TimeEvent(15 * FRAMES, function(inst)
			inst.AnimState:SetDeltaTimeMultiplier(.55) -- slow down
			inst.SoundEmitter:PlaySound("dontstarve/wilson/eat", "eating")
		end),
		
		TimeEvent(56 * FRAMES, function(inst)
			if inst.sg.statemem.feed == nil then
				inst:PerformBufferedAction()
			elseif inst.sg.statemem.feed.components.soul == nil and inst.components.eater then
				inst.components.eater:Eat(inst.sg.statemem.feed, inst.sg.statemem.feeder)
			end
		end),

		TimeEvent(60 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("busy")
			inst.sg:RemoveStateTag("pausepredict")
			inst.AnimState:SetDeltaTimeMultiplier(1)
		end),

		TimeEvent(90 * FRAMES, function(inst)
			inst.SoundEmitter:KillSound("eating")
		end),
	},

	events =
	{
		EventHandler("animqueueover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.AnimState:SetDeltaTimeMultiplier(1)
				inst.sg:GoToState("idle")
			end
		end),
	},

	onexit = function(inst)
		inst.AnimState:SetDeltaTimeMultiplier(1)
	
		inst.SoundEmitter:KillSound("eating")
		if not GetGameModeProperty("no_hunger") and inst.components.hunger then
			inst.components.hunger:Resume()
		end
		if inst.sg.statemem.feed ~= nil and inst.sg.statemem.feed:IsValid() then
			inst.sg.statemem.feed:Remove()
		end
	end,
}

local waroline_eat_client = State{
	name = "waroline_eat",
	tags = { "busy" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
		inst.AnimState:PlayAnimation("eat_pre")
		inst.AnimState:PushAnimation("eat_lag", false)
		
		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(TIMEOUT)
	end,

	onupdate = function(inst)
		if inst:HasTag("busy") then
			if inst.entity:FlattenMovementPrediction() then
				inst.sg:GoToState("idle", "noanim")
			end
		elseif inst.bufferedaction == nil then
			inst.sg:GoToState("idle")
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:GoToState("idle")
	end,
}


local function SGArtistServer_PostInit(sg)
    sg.states["sketchbook_idle"] = waroline_sketchbook
	sg.states["sketchbook_draw"] = waroline_draw
	
	-- SKETCH CRAFTING ANIM
	local _ActionHandlerBUILD = sg.actionhandlers[ACTIONS.BUILD].deststate
	sg.actionhandlers[ACTIONS.BUILD].deststate = function(inst, action)
		local rec = GetValidRecipe(action.recipe)
		return (rec ~= nil and rec.isdrawing and "sketchbook_draw") or _ActionHandlerBUILD(inst, action)
	end
	
	-- DOJOSTLEPICK SUGGESTION FOR SKETCH SPLUMONKEY PICKING
	local _dojostleaction_onenter = sg.states["dojostleaction"].onenter
	
	sg.states["dojostleaction"].onenter = function(inst)
		if inst:HasTag("waroline") and inst.components.warolineartist and inst.components.warolineartist:CurrentlyHasDrawings() and inst.components.warolineartist:HasDrawing("monkey_drawing") then
            local drawings = inst.components.warolineartist:GetDrawings("monkey_drawing")
			
			for i,drawing in ipairs(drawings) do
				if drawing then
					drawing.should_start_picking = true
					
					local buffaction = inst:GetBufferedAction()
					local target = buffaction ~= nil and buffaction.target or nil
					if target then
						drawing.target_to_ignore = target
					end
				end
			end
		end
		_dojostleaction_onenter(inst)
	end
end

local function SGArtistClient_PostInit(sg)
    sg.states["sketchbook_idle"] = waroline_sketchbook
	sg.states["sketchbook_draw"] = waroline_draw_client
	
	-- SKETCH CRAFTING ANIM
	local _ActionHandlerBUILD = sg.actionhandlers[ACTIONS.BUILD].deststate
	sg.actionhandlers[ACTIONS.BUILD].deststate = function(inst, action)
		local rec = GetValidRecipe(action.recipe)
		return (rec ~= nil and rec.isdrawing and "sketchbook_draw") or _ActionHandlerBUILD(inst, action)
	end
end

local function SG_SlowEaterServer_PostInit(sg)
	sg.states["waroline_quickeat"] = waroline_quickeat
	sg.states["waroline_eat"] = waroline_eat
	
	-- SLOW EATER PERK
	local _ActionHandlerEAT = sg.actionhandlers[ACTIONS.EAT].deststate
	sg.actionhandlers[ACTIONS.EAT].deststate = function(inst, action)
		if inst:HasTag("waroline") then
			if inst.sg:HasStateTag("busy") then
                return
            end
            local obj = action.target or action.invobject
            if obj == nil then
                return
            elseif obj.components.edible ~= nil then
                if not inst.components.eater:PrefersToEat(obj) then
                    inst:PushEvent("wonteatfood", { food = obj })
                    return
                end
            elseif obj.components.soul ~= nil then
                if inst.components.souleater == nil then
                    inst:PushEvent("wonteatfood", { food = obj })
                    return
                end
            else
                return
            end
            return (obj.components.soul ~= nil and "waroline_eat")
                or (obj.components.edible.foodtype == FOODTYPE.MEAT and "waroline_eat")
                or "waroline_quickeat"
		else
			return _ActionHandlerEAT(inst, action)
		end
	end
end

local function SG_SlowEaterClient_PostInit(sg)
	sg.states["waroline_quickeat"] = waroline_quickeat_client
	sg.states["waroline_eat"] = waroline_eat_client
	
	-- SLOW EATER PERK (client)
	local _ActionHandlerEAT = sg.actionhandlers[ACTIONS.EAT].deststate
	sg.actionhandlers[ACTIONS.EAT].deststate = function(inst, action)
		if inst:HasTag("waroline") then
			if inst.sg:HasStateTag("busy") or inst:HasTag("busy") then
				return
			end
			local obj = action.target or action.invobject
			if obj == nil then
				return
			elseif obj:HasTag("soul") then
				return "waroline_eat"
			end
			for k, v in pairs(FOODTYPE) do
				if obj:HasTag("edible_"..v) then
					return v == FOODTYPE.MEAT and "waroline_eat" or "waroline_quickeat"
				end
			end
		else
			return _ActionHandlerEAT(inst, action)
		end
	end
end

AddStategraphState("SGwilson", waroline_sketchbook)
AddStategraphState("SGwilson", waroline_draw)
AddStategraphState("SGwilson", waroline_quickeat)
AddStategraphState("SGwilson", waroline_eat)
AddStategraphPostInit("wilson", SGArtistServer_PostInit)
AddStategraphPostInit("wilson", SG_SlowEaterServer_PostInit)

AddStategraphState("SGwilson_client", waroline_sketchbook)
AddStategraphState("SGwilson_client", waroline_draw_client)
AddStategraphState("SGwilson_client", waroline_quickeat_client)
AddStategraphState("SGwilson_client", waroline_eat_client)
AddStategraphPostInit("wilson_client", SGArtistClient_PostInit)
AddStategraphPostInit("wilson_client", SG_SlowEaterClient_PostInit)
