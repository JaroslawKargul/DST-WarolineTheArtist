local assets =
{
    Asset("ANIM", "anim/monkey_drawing_1.zip"),
	Asset("ANIM", "anim/monkey_drawing_2.zip"),
	
	Asset("ANIM", "anim/monkey_drawing_placer.zip"),
}

local brain = require "brains/monkeydrawingbrain"

local SLEEP_DIST_FROMHOME = 1
local SLEEP_DIST_FROMTHREAT = 20
local MAX_CHASEAWAY_DIST = 80
local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 40


local WAKE_TO_FOLLOW_DISTANCE = 3
local SLEEP_NEAR_LEADER_DISTANCE = 2

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) and not TheWorld:HasTag("cave") and TheWorld.state.isnight and not TheWorld.state.isfullmoon
end

local function ShouldAcceptItem(inst, item)
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        return true
    else
		return false
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
	--I wear hats
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("taunt")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function IsBanana(item)
    return item.prefab == "cave_banana" or item.prefab == "cave_banana_cooked"
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()   
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(2, .2)

    inst.Transform:SetSixFaced()

    MakeCharacterPhysics(inst, 100, .25) -- mass, size

    inst.AnimState:SetBank("kiki")
    inst.AnimState:SetBuild("monkey_drawing_1")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst:AddTag("cavedweller")
    inst:AddTag("monkey")
    inst:AddTag("animal")
	inst:AddTag("scarytoprey")
	
	inst:AddTag("companion")
	
	--trader (from trader component) added to pristine state for optimization
	inst:AddTag("trader")
	
	inst:AddComponent("warolinedrawingclient")
	inst.components.warolinedrawingclient:SetUp("monkey_drawing")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.soundtype = ""
	
	MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
    MakeMediumFreezableCharacter(inst)
	
	inst.components.propagator.flashpoint = 9 + math.random()*5 -- Default flashpoint: 5 + math.random()*5
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(true)
	inst.components.warolinedrawing:SetSpawnFXSize(0.7, 1.1) -- migration, despawn
	inst.components.warolinedrawing:SetIsFighter()

    inst:AddComponent("bloomer")

    inst:AddComponent("inventory")
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	inst.components.trader.deleteitemonaccept = false
	inst.components.trader:Enable()

    inst:AddComponent("inspectable")

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = false }
    inst.components.locomotor.walkspeed = TUNING.MONKEY_MOVE_SPEED

    inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.DRAWING_ATTACK_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.MONKEY_ATTACK_PERIOD)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1)

    inst:AddComponent("sleeper")
	inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.WAROLINEDRAWING_SANITYAURA_TINY

	inst:AddComponent("follower")

    inst:SetBrain(brain)
    inst:SetStateGraph("SGmonkeydrawing")

    inst:AddComponent("knownlocations")
	
	inst.HasAmmo = function(inst) return false end

    MakeHauntablePanic(inst)

    inst.weaponitems = {}

    return inst
end

return Prefab("monkey_drawing", fn, assets, prefabs),
	MakePlacer("monkey_drawing_placer", "monkey_drawing_placer", "monkey_drawing_placer", "monkey_drawing_placer")
