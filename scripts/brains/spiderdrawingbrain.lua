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

local MAX_WANDER_DIST = 5

local MAX_CHASE_DIST = 7
local MAX_CHASE_TIME = 8

local SEE_SMALLFIRE_DIST = 1.25
local RUN_SMALLFIRE_DIST = 1.75

local SEE_MEDFIRE_DIST = 1.75
local RUN_MEDFIRE_DIST = 2.5

local SEE_BIGFIRE_DIST = 3.5
local RUN_BIGFIRE_DIST = 4.5

local SpiderDrawingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
	self.name = "spiderdrawingbrain"
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

function SpiderDrawingBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME)),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true), -- follow us
		RunAway(self.inst, ShouldRunAway, AVOID_MONSTER_DIST, AVOID_MONSTER_STOP), -- avoid anything that could kill me (unless it's a target)
        RunAway(self.inst, KeepDistFromFireSmall, SEE_SMALLFIRE_DIST, RUN_SMALLFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireMed, SEE_MEDFIRE_DIST, RUN_MEDFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireBig, SEE_BIGFIRE_DIST, RUN_BIGFIRE_DIST),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST, {minwalktime=.7, randwalktime=.8, minwaittime=2, randwaittime=4}),
    }, .25)
    self.bt = BT(self.inst, root)
end

return SpiderDrawingBrain
