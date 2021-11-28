require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local STOP_RUN_DIST = 0
local SEE_PLAYER_DIST = 1

local STOP_MONSTER_RUN_DIST = 4
local SEE_MONSTER_DIST = 5

local AVOID_PLAYER_DIST = 1
local AVOID_PLAYER_STOP = 1

local MIN_FOLLOW = 0 -- 1
local MAX_FOLLOW = 9 -- 5
local MED_FOLLOW = 5.5 -- 3

local SEE_BAIT_DIST = 3
local MAX_WANDER_DIST = 5

local SEE_SMALLFIRE_DIST = 1.5
local RUN_SMALLFIRE_DIST = 2

local SEE_MEDFIRE_DIST = 2
local RUN_MEDFIRE_DIST = 2.75

local SEE_BIGFIRE_DIST = 4
local RUN_BIGFIRE_DIST = 4.75

local KoalefantDrawingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
	self.name = "koalefantdrawingbrain"
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

function KoalefantDrawingBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true), -- follow us
		RunAway(self.inst, ShouldRunAway, SEE_MONSTER_DIST, STOP_MONSTER_RUN_DIST), -- avoid anything that could kill me
        RunAway(self.inst, KeepDistFromFireSmall, SEE_SMALLFIRE_DIST, RUN_SMALLFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireMed, SEE_MEDFIRE_DIST, RUN_MEDFIRE_DIST),
		RunAway(self.inst, KeepDistFromFireBig, SEE_BIGFIRE_DIST, RUN_BIGFIRE_DIST),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST, {minwalktime=.6, randwalktime=.3, minwaittime=7, randwaittime=10}),
    }, .25)
    self.bt = BT(self.inst, root)
end

return KoalefantDrawingBrain
