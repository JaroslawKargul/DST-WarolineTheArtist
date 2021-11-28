local assets =
{
    Asset("ANIM", "anim/smallbird_drawing_1.zip"),
	Asset("ANIM", "anim/smallbird_drawing_2.zip"),
	Asset("ANIM", "anim/smallbird_drawing_placer.zip"),
}

local WAKE_TO_FOLLOW_DISTANCE = 10
local SLEEP_NEAR_LEADER_DISTANCE = 7

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE)
end

local function excludefollowers(guy)
	local is_player_follower = guy ~= nil and guy.components.follower ~= nil and guy.components.follower.leader ~= nil and guy.components.follower.leader:HasTag("player") and true or false
	local can_be_attacked = guy ~= nil and guy.components.combat ~= nil and guy.components.combat:CanBeAttacked() and true or false
	return guy ~= nil and guy:IsValid() and not is_player_follower and can_be_attacked
end

local function FindSomethingToHunt(inst)
	if not inst.components.combat or inst.components.combat and inst.components.combat.target ~= nil then
		return
	end

	local target = FindEntity(inst, 3, excludefollowers, {"smallcreature"}, {"companion"})
	if target then
		inst.components.combat:SetTarget(target)
	end
end

local function GetPeepChance(inst)
    return 0.2
end

local function FollowLeader(inst)
	return
end

local brain = require "brains/smallbirddrawingbrain"

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddDynamicShadow()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .25)

    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)

	inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("smallbird_drawing_1")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("smallcreature")
	inst:AddTag("animal")
    inst:AddTag("companion")
    inst:AddTag("character")
    inst:AddTag("smallbird")

    inst.DynamicShadow:SetSize(1.2, .2)

	inst:AddComponent("warolinedrawingclient")
	inst.components.warolinedrawingclient:SetUp("smallbird_drawing")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.userfunctions =
    {
        FollowLeader = FollowLeader,
        GetPeepChance = GetPeepChance,
    }

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 6

    inst:SetStateGraph("SGsmallbirddrawing")

	inst:AddComponent("inspectable")
	
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(1)
	
    inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "head"
	inst.components.combat:SetDefaultDamage(TUNING.DRAWING_ATTACK_DAMAGE)
	inst.components.combat:SetRange(1.7)
    inst.components.combat:SetAttackPeriod(2) -- default 1
	
	inst:AddComponent("follower")
	
	inst:AddComponent("knownlocations")
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(true)
	inst.components.warolinedrawing:SetIsFighter()

    inst:AddComponent("sleeper")
    inst.components.sleeper.watchlight = true
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.WAROLINEDRAWING_SANITYAURA_TINY
	
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
    MakeMediumFreezableCharacter(inst, "head")
    MakeHauntablePanic(inst)
	
	inst.components.propagator.flashpoint = 7 + math.random()*5 -- Default flashpoint: 5 + math.random()*5
	
	inst:SetBrain(brain)
	
	inst.hunting_task = inst:DoPeriodicTask(1, function(inst)
		FindSomethingToHunt(inst)
	end)
	
    return inst
end

return Prefab("smallbird_drawing", fn, assets, prefabs),
	MakePlacer("smallbird_drawing_placer", "smallbird_drawing_placer", "smallbird_drawing_placer", "smallbird_drawing_placer")