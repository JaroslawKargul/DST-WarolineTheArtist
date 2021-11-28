local assets =
{
    Asset("ANIM", "anim/spider_drawing_1.zip"),
    Asset("ANIM", "anim/spider_drawing_2.zip"),
	
	Asset("ANIM", "anim/spider_drawing_placer.zip"),
}

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

local brain = require "brains/spiderdrawingbrain"

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLightWatcher()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .25) -- mass, size

    inst.DynamicShadow:SetSize(1.5, .2)
    inst.Transform:SetFourFaced()

    inst:AddTag("cavedweller")
    inst:AddTag("monster")
    inst:AddTag("scarytoprey")
    inst:AddTag("smallcreature")
    inst:AddTag("spider")
	
	-- For ranged attacks
	inst:AddTag("spider_warrior")
	
	inst:AddTag("companion")

    inst.AnimState:SetBank("spider")
    inst.AnimState:SetBuild("spider_drawing_1")
    inst.AnimState:PlayAnimation("idle")

	inst:AddComponent("warolinedrawingclient")
	inst.components.warolinedrawingclient:SetUp("spider_drawing")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- locomotor must be constructed before the stategraph!
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
	inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED

    inst:SetStateGraph("SGspiderdrawing")

    ---------------------        
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
    MakeMediumFreezableCharacter(inst, "body")
	
	inst.components.propagator.flashpoint = 7 + math.random()*5 -- Default flashpoint: 5 + math.random()*5
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(true)
	inst.components.warolinedrawing:SetIsFighter()
    ---------------------       

    inst:AddComponent("health")
	inst.components.health:SetMaxHealth(1)
	
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
	inst.components.combat:SetDefaultDamage(TUNING.DRAWING_ATTACK_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SPIDER_ATTACK_PERIOD)

    inst:AddComponent("follower")

    ------------------

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
	inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    ------------------

    inst:AddComponent("knownlocations")

    ------------------

    inst:AddComponent("inspectable")

    ------------------

    inst:AddComponent("sanityaura")
	inst.components.sanityaura.aura = -TUNING.WAROLINEDRAWING_SANITYAURA_SMALL_TINY

	------------------
	
	inst:AddComponent("inventory")
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	inst.components.trader.deleteitemonaccept = false
	inst.components.trader:Enable()
	
    MakeHauntablePanic(inst)

    inst:SetBrain(brain)

    return inst
end

return Prefab("spider_drawing", fn, assets),
	MakePlacer("spider_drawing_placer", "spider_drawing_placer", "spider_drawing_placer", "spider_drawing_placer")
