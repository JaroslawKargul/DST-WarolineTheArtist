require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local STOP_RUN_DIST = 0
local SEE_PLAYER_DIST = 1

local STOP_MONSTER_RUN_DIST = 5
local SEE_MONSTER_DIST = 6

local AVOID_PLAYER_DIST = 1
local AVOID_PLAYER_STOP = 1

local AVOID_MONSTER_DIST = 3
local AVOID_MONSTER_STOP = 4

local MIN_FOLLOW = 0 -- 1
local MAX_FOLLOW = 5 -- 5
local MED_FOLLOW = 3 -- 3

local MAX_WANDER_DIST = 5

local MAX_CHASE_DIST = 7
local MAX_CHASE_TIME = 8

local SpiderDrawingBrain_Boat = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
	self.name = "spiderdrawingbrain_boat"
end)

function SpiderDrawingBrain_Boat:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME)),
		Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true), -- follow us
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST, {minwalktime=.7, randwalktime=.8, minwaittime=2, randwaittime=4}),
    }, .25)
    self.bt = BT(self.inst, root)
end

return SpiderDrawingBrain_Boat
