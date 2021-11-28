require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/findfarmplant"

local STOP_RUN_DIST = 0
local SEE_PLAYER_DIST = 1

local AVOID_PLAYER_DIST = 1
local AVOID_PLAYER_STOP = 1

local AVOID_MONSTER_DIST = 4
local AVOID_MONSTER_STOP = 5

local MIN_FOLLOW = 0 -- 1
local MAX_FOLLOW = 9 -- 5
local MED_FOLLOW = 5 -- 3

local MAX_WANDER_DIST = 5

local MAX_CHASE_DIST = 7
local MAX_CHASE_TIME = 8

local KEEP_CHOPPING_DIST = 10
local SEE_TREE_DIST = 15

local KEEP_PICKING_DIST = 10
local SEE_PLANT_DIST = 15

local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30

local SEE_SMALLFIRE_DIST = 1.5
local RUN_SMALLFIRE_DIST = 2

local SEE_MEDFIRE_DIST = 2
local RUN_MEDFIRE_DIST = 2.75

local SEE_BIGFIRE_DIST = 4
local RUN_BIGFIRE_DIST = 4.75

-- [[ - CHOPPING - ]] --

local function IsDeciduousTreeMonster(guy)
    return guy.monster and guy.prefab == "deciduoustree"
end

local CHOP_MUST_TAGS = { "CHOP_workable" }
local function FindDeciduousTreeMonster(inst)
    return FindEntity(inst, SEE_TREE_DIST / 3, IsDeciduousTreeMonster, CHOP_MUST_TAGS)
end

local function KeepChoppingAction(inst)
    return inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_CHOPPING_DIST))
        or FindDeciduousTreeMonster(inst) ~= nil
end

local function StartChoppingCondition(inst)
    return inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("chopping"))
        or FindDeciduousTreeMonster(inst) ~= nil
end

local function FindTreeToChopAction(inst)
    local target = FindEntity(inst, SEE_TREE_DIST, nil, CHOP_MUST_TAGS)
    if target ~= nil then
        if inst.tree_target ~= nil then
            target = inst.tree_target
            inst.tree_target = nil
        else
            target = FindDeciduousTreeMonster(inst) or target
        end
		return BufferedAction(inst, target, ACTIONS.CHOP)
    end
end

-- [[ - MINING - ]] --
local MINE_MUST_TAGS = { "MINE_workable" }

local function KeepMiningAction(inst)
    return inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_CHOPPING_DIST))
end

local function StartMiningCondition(inst)
    return inst.tree_target ~= nil
		or (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
			(inst.components.follower.leader.sg:HasStateTag("mining") or
		    inst.components.follower.leader.sg:HasStateTag("mine") or
		    inst.components.follower.leader.sg:HasStateTag("mine_start")))
end

local function FindRockToMineAction(inst)
    local target = FindEntity(inst, SEE_TREE_DIST, nil, MINE_MUST_TAGS)
    if target ~= nil then
        if inst.tree_target ~= nil then
            target = inst.tree_target
            inst.tree_target = nil
        end
		return BufferedAction(inst, target, ACTIONS.MINE)
    end
end

-- [[ - GRASS / TWIG PICKING - ]] --

local PICK_MUST_TAGS = { "pickable", "plant" }
local PICK_CANNOT_TAGS = { "barren", "withered" }

local function KeepPickingAction(inst)
    return inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_PICKING_DIST))
end

local function StartPickingCondition(inst)
	local leader = inst.components.follower.leader ~= nil and inst.components.follower.leader or nil
	
	local picks_plant = inst.tree_target ~= nil
		or leader ~= nil and
            leader.bufferedaction ~= nil and
			leader.bufferedaction.action ~= nil and
		    leader.bufferedaction.action == ACTIONS.PICK and
			leader.bufferedaction.target ~= nil and
			leader.bufferedaction.target:HasTag("plant")
		or inst.should_start_picking ~= nil and inst.loot_to_pick_up == nil -- This is for forced picking suggestion from player's "dojostleaction" state
		or inst.continue_picking_after ~= nil and inst.loot_to_pick_up == nil -- This is for forced picking suggestion after juicy berry pickup from berrybush_juicy
	
	inst.should_start_picking = nil
	inst.continue_picking_after = nil
	
    return picks_plant
end

local function filter_pickable_plants(inst, target)
	return target ~= nil and target.components.pickable and target.components.pickable.canbepicked and true or false
end

local function NOTIsTargetSameAsLeaders(inst, target)
	return inst.components.follower.leader ~= nil and
	(inst.components.follower.leader.bufferedaction == nil or
	inst.components.follower.leader.bufferedaction ~= nil and
	(inst.components.follower.leader.bufferedaction.target == nil or
	inst.components.follower.leader.bufferedaction.target ~= nil and
	inst.components.follower.leader.bufferedaction.target ~= target))
end

local function FindPlantToPickAction(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local targets = TheSim:FindEntities(x, y, z, SEE_PLANT_DIST)
	local target = nil
	
	for i,v in ipairs(targets) do
		if v ~= nil and filter_pickable_plants(inst,v) and NOTIsTargetSameAsLeaders(inst,v) then
			target = v
			break
		end
	end
	
	if target ~= nil then
		if inst.tree_target ~= nil then
			target = inst.tree_target
			inst.tree_target = nil
		end
		return BufferedAction(inst, target, ACTIONS.PICK)
	end
end

-- [[ - GIVING ITEMS TO LEADER - ]] --

local function ShouldGiveInventoryToLeader(inst)
	local leader = inst.components.follower.leader ~= nil and inst.components.follower.leader or nil
	
    return inst.tree_target == nil and leader and leader.components.inventory and inst.components.inventory and
		inst.components.inventory:NumItems() > 0 and true or false
end

local function GiveInventoryToLeader(inst)
	local leader = inst.components.follower.leader ~= nil and inst.components.follower.leader or nil
	if leader then
		return ShouldGiveInventoryToLeader(inst) and BufferedAction(inst, leader, ACTIONS.DRAWINGTRANSFERINV)
	end
end

-- [[ - PICKUP OF DROPPICKED LOOT - ]] --

local function ShouldPickUpLoot(inst)
	return inst.loot_to_pick_up ~= nil and true or false
end

local function GetPickUpLoot(inst)
	if inst.loot_to_pick_up ~= nil then
		local loot = nil
		
		--print("Number of berries to pick up: " .. #inst.loot_to_pick_up)
		
		for i,v in ipairs(inst.loot_to_pick_up) do
			if v ~= nil and not v:IsInLimbo() and v:IsValid() and inst:IsValid() and v.components.inventoryitem and not v.components.inventoryitem.owner then
				local square_distance = math.sqrt(v:GetDistanceSqToInst(inst))
				if v.monkey_pickupable and square_distance <= 5 then
					loot = v
					break
				end
			end
		end
		
		if loot then
			return loot
		else
			inst.loot_to_pick_up = nil
		end
	end
	return nil
end

local function PickUpLoot(inst)
	local loot_to_pickup = GetPickUpLoot(inst)
	
	--if loot_to_pickup ~= nil then
		--print("PickUpLoot: Loot to pick up found!")
	--else
		--print("PickUpLoot: No loot to pick up!")
	--end
	
	return loot_to_pickup ~= nil and BufferedAction(inst, loot_to_pickup, ACTIONS.PICKUP)
end

-- [[ - OTHER - ]] --

local function GetFollowPos(inst)
    return inst.components.follower.leader and inst.components.follower.leader:GetPosition() or
        inst:GetPosition()
end

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end

local function RescueLeaderAction(inst)
    return BufferedAction(inst, GetLeader(inst), ACTIONS.UNPIN)
end

local MonkeyDrawingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
	self.name = "monkeydrawingbrain"
end)

local function ShouldRunAway(guy)
    return not (guy:HasTag("character") or
                guy:HasTag("notarget") or
				guy:HasTag("nightmarecreature") or
				guy:HasTag("waroline_drawing"))
        and (guy:HasTag("scarytoprey") or
			guy:HasTag("merm") or
			guy:HasTag("hostile"))
end

local function KeepDistFromFireBig(guy)
	return guy:HasTag("propagator_spreading") and
		guy.components.propagator ~= nil and
		guy.components.propagator.propagaterange >= 3
end

local function KeepDistFromFireMed(guy)
	return guy:HasTag("propagator_spreading") and
		guy.components.propagator ~= nil and
		guy.components.propagator.propagaterange >= 2 and
		guy.components.propagator.propagaterange < 3
end

local function KeepDistFromFireSmall(guy)
	return guy:HasTag("propagator_spreading") and
		guy.components.propagator ~= nil and
		guy.components.propagator.propagaterange < 2
end

function MonkeyDrawingBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		WhileNode( function() return GetLeader(self.inst) and GetLeader(self.inst).components.pinnable and GetLeader(self.inst).components.pinnable:IsStuck() end, "Leader Phlegmed",
                    DoAction(self.inst, RescueLeaderAction, "Rescue Leader", true)),
		ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME)),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true), -- follow us
		IfNode(function() return StartChoppingCondition(self.inst) end, "chop", 
                WhileNode(function() return KeepChoppingAction(self.inst) end, "keep chopping",
                    LoopNode{DoAction(self.inst, FindTreeToChopAction )})),
		IfNode(function() return StartMiningCondition(self.inst) end, "mine", 
                WhileNode(function() return KeepMiningAction(self.inst) end, "keep mining",
                    LoopNode{DoAction(self.inst, FindRockToMineAction )})),
		WhileNode( function() return ShouldPickUpLoot(self.inst) end, "GetLoot", 
            DoAction(self.inst, PickUpLoot)),
		IfNode(function() return StartPickingCondition(self.inst) end, "pick", 
                WhileNode(function() return KeepPickingAction(self.inst) end, "keep picking",
                    LoopNode{DoAction(self.inst, FindPlantToPickAction )})),
		WhileNode( function() return ShouldGiveInventoryToLeader(self.inst) end, "TransferInv", 
            DoAction(self.inst, GiveInventoryToLeader)),
		FindFarmPlant(self.inst, ACTIONS.INTERACT_WITH, true, GetFollowPos),
		RunAway(self.inst, ShouldRunAway, AVOID_MONSTER_DIST, AVOID_MONSTER_STOP), -- avoid anything that could kill me
		RunAway(self.inst, KeepDistFromFireSmall, SEE_SMALLFIRE_DIST, RUN_SMALLFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireMed, SEE_MEDFIRE_DIST, RUN_MEDFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireBig, SEE_BIGFIRE_DIST, RUN_BIGFIRE_DIST),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST, {minwalktime=.5, randwalktime=.6, minwaittime=4, randwaittime=4}),
    }, .25)
    self.bt = BT(self.inst, root)
end

return MonkeyDrawingBrain
