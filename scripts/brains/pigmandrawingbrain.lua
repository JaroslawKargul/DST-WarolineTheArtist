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

local SEE_BAIT_DIST = 3
local MAX_WANDER_DIST = 5

local KEEP_CHOPPING_DIST = 10
local SEE_TREE_DIST = 15

local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30

local SEE_SMALLFIRE_DIST = 1.5
local RUN_SMALLFIRE_DIST = 2

local SEE_MEDFIRE_DIST = 2
local RUN_MEDFIRE_DIST = 2.75

local SEE_BIGFIRE_DIST = 4
local RUN_BIGFIRE_DIST = 4.75

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

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function GetFaceTargetFn(inst)
    return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end

local function RescueLeaderAction(inst)
    return BufferedAction(inst, GetLeader(inst), ACTIONS.UNPIN)
end

local PigmanDrawingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
	self.name = "pigmandrawingbrain"
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

function PigmanDrawingBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		ChattyNode(self.inst, "PIG_TALK_RESCUE",
                WhileNode( function() return GetLeader(self.inst) and GetLeader(self.inst).components.pinnable and GetLeader(self.inst).components.pinnable:IsStuck() end, "Leader Phlegmed",
                    DoAction(self.inst, RescueLeaderAction, "Rescue Leader", true) )),
		ChattyNode(self.inst, "PIG_TALK_FIGHT",
                WhileNode( function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
                    ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST) )),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true), -- follow us
		IfNode(function() return StartChoppingCondition(self.inst) end, "chop", 
                WhileNode(function() return KeepChoppingAction(self.inst) end, "keep chopping",
                    LoopNode{ 
                        ChattyNode(self.inst, "PIG_TALK_HELP_CHOP_WOOD",
                            DoAction(self.inst, FindTreeToChopAction ))})),
		RunAway(self.inst, ShouldRunAway, AVOID_MONSTER_DIST, AVOID_MONSTER_STOP), -- avoid anything that could kill me
        ChattyNode(self.inst, "PIGDRAWING_TALK_SCARYFIRE",
			RunAway(self.inst, KeepDistFromFireSmall, SEE_SMALLFIRE_DIST, RUN_SMALLFIRE_DIST)),
		ChattyNode(self.inst, "PIGDRAWING_TALK_SCARYFIRE",
			RunAway(self.inst, KeepDistFromFireMed, SEE_MEDFIRE_DIST, RUN_MEDFIRE_DIST)),
		ChattyNode(self.inst, "PIGDRAWING_TALK_SCARYFIRE",
			RunAway(self.inst, KeepDistFromFireBig, SEE_BIGFIRE_DIST, RUN_BIGFIRE_DIST)),
        --Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST, {minwalktime=0.8, randwalktime=1.1, minwaittime=2, randwaittime=4}),
		ChattyNode(self.inst, "PIGDRAWING_TALK_ARTIST",
			WhileNode( function() return not self.inst.components.combat.target end, "No combat target",
			FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn))),
    }, .25)
    self.bt = BT(self.inst, root)
end

return PigmanDrawingBrain
