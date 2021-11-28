require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local STOP_RUN_DIST = 0
local SEE_PLAYER_DIST = 1

local AVOID_PLAYER_DIST = 1
local AVOID_PLAYER_STOP = 1

local AVOID_MONSTER_DIST = 4
local AVOID_MONSTER_STOP = 5

local MIN_FOLLOW = 0 -- 1
local MAX_FOLLOW = 8 -- 5
local MED_FOLLOW = 4 -- 3

local SEE_CARROT_DIST = 7
local MAX_WANDER_DIST = 5

-- Slightly smaller fire distance from the rest of sketches
local SEE_SMALLFIRE_DIST = 1
local RUN_SMALLFIRE_DIST = 1.5

local SEE_MEDFIRE_DIST = 1.5
local RUN_MEDFIRE_DIST = 2

local SEE_BIGFIRE_DIST = 3.5
local RUN_BIGFIRE_DIST = 4.5

local RabbitDrawingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
	self.name = "rabbitdrawingbrain"
end)

local function ShouldRunAway(guy)
    return not (guy:HasTag("character") or
                guy:HasTag("notarget") or
				guy:HasTag("nightmarecreature") or
				guy:HasTag("waroline_drawing"))
        and (guy:HasTag("scarytoprey") or
			guy:HasTag("merm") or
			guy:HasTag("monkey") or
			guy:HasTag("catcoon"))
end

local function IsCarrot(thing)
    return thing.prefab == "carrot_planted" or thing.prefab == "carrat_planted"
end

local function GetNearbyCarrot(inst)
	if inst:HasTag("has_carrot") then
		return false
	end
	
	local leader = inst.components.follower and inst.components.follower.leader ~= nil and inst.components.follower.leader
	local carrot = FindEntity(inst, SEE_CARROT_DIST, IsCarrot)
	
	if not carrot and leader then
		-- No carrot was found near the rabbit - try searching for one nearby leader instead
		carrot = FindEntity(leader, SEE_CARROT_DIST, IsCarrot)
	end
	
	if carrot then
		if not inst:HasTag("carrot_searching") then
			inst:AddTag("carrot_searching")
		end
		inst.carrot_to_pick_up = carrot
		return true
	else
		return false
	end
end

local function PickUpCarrot(inst)
	if not inst.bufferedaction and inst.carrot_to_pick_up and not inst:HasTag("has_carrot") then
		return BufferedAction(inst, inst.carrot_to_pick_up, ACTIONS.PICK)
	end
end

--

local function KeepHarvesting(inst)
	--print("Checking if we should keep harvesting...")
    return inst.carrot_to_pick_up == nil and not inst:HasTag("has_carrot")
        and (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, MAX_FOLLOW))
end

local function StartHarvestCondition(inst)
	--print("Checking if we can start harvesting...")
    return inst.carrot_to_pick_up == nil and not inst:HasTag("has_carrot")
		and (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.bufferedaction ~= nil and
			inst.components.follower.leader.bufferedaction.target ~= nil and
			(table.contains(TUNING.RABBIT_DRAWING_SUPPORTED_CROPS, inst.components.follower.leader.bufferedaction.target.prefab) or
			inst.components.follower.leader.bufferedaction.target.components.pickable ~= nil and inst.components.follower.leader.bufferedaction.target.components.pickable.canbepicked))
end

local function ValidatePlant(plant)
	return plant.prefab ~= nil and (table.contains(TUNING.RABBIT_DRAWING_SUPPORTED_CROPS, plant.prefab) or
			plant.components.growable ~= nil and plant.components.pickable ~= nil and plant.components.pickable.canbepicked and
			plant.components.pickable.product ~= nil and not string.find(plant.components.pickable.product, "_oversized"))
end

local function NOTIsTargetSameAsLeaders(inst, target)
	return inst.components.follower.leader ~= nil and
	(inst.components.follower.leader.bufferedaction == nil or
	inst.components.follower.leader.bufferedaction ~= nil and
	(inst.components.follower.leader.bufferedaction.target == nil or
	inst.components.follower.leader.bufferedaction.target ~= nil and
	inst.components.follower.leader.bufferedaction.target ~= target))
end

local function FindPlantToHarvest(inst)
	--print("Trying to find plant to harvest...")
	local x, y, z = inst.Transform:GetWorldPosition()
	local targets = TheSim:FindEntities(x, y, z, MAX_FOLLOW)
	local target = nil
	
	for i,v in ipairs(targets) do
		if v ~= nil and v.entity and v.entity:IsVisible() and v:IsValid() and ValidatePlant(v) and NOTIsTargetSameAsLeaders(inst, v) then
			target = v
			break
		end
	end
	
	if target ~= nil then
		if not inst:HasTag("carrot_searching") then
			inst:AddTag("carrot_searching")
		end
	
		if inst.carrot_to_pick_up ~= nil then
			target = inst.carrot_to_pick_up
			inst.carrot_to_pick_up = target
		end
		--print("Target found! Target prefab: " .. target.prefab)
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

-- [[ - FIRE! - ]] --

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

function RabbitDrawingBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true), -- follow us
		RunAway(self.inst, ShouldRunAway, AVOID_MONSTER_DIST, AVOID_MONSTER_STOP), -- avoid anything that could kill me
		RunAway(self.inst, KeepDistFromFireSmall, SEE_SMALLFIRE_DIST, RUN_SMALLFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireMed, SEE_MEDFIRE_DIST, RUN_MEDFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireBig, SEE_BIGFIRE_DIST, RUN_BIGFIRE_DIST),
		WhileNode( function() return GetNearbyCarrot(self.inst) end, "CarrotFind", 
            DoAction(self.inst, PickUpCarrot)),
		IfNode(function() return StartHarvestCondition(self.inst) end, "Harvest", 
                WhileNode(function() return KeepHarvesting(self.inst) end, "Keep Harvesting",
                    LoopNode{DoAction(self.inst, FindPlantToHarvest )})),
		WhileNode( function() return ShouldGiveInventoryToLeader(self.inst) end, "TransferInv", 
            DoAction(self.inst, GiveInventoryToLeader)),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST, {minwalktime=.65, randwalktime=.75, minwaittime=3, randwaittime=2}),
    }, .25)
    self.bt = BT(self.inst, root)
end

return RabbitDrawingBrain
