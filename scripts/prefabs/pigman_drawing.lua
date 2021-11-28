local assets =
{
    Asset("ANIM", "anim/pigman_drawing_1.zip"),
    Asset("ANIM", "anim/pigman_drawing_2.zip"),
	
	Asset("ANIM", "anim/pigman_drawing_placer.zip"),
}

local WAKE_TO_FOLLOW_DISTANCE = 3
local SLEEP_NEAR_LEADER_DISTANCE = 2

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) and not TheWorld:HasTag("cave") and TheWorld.state.isnight and not TheWorld.state.isfullmoon
end

local function ontalk(inst, script)
    inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
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
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local MAX_TARGET_SHARES = 3
local SHARE_TARGET_DIST = 5
local SUGGESTTARGET_MUST_TAGS = { "_combat", "_health", "pig" }
local SUGGESTTARGET_CANT_TAGS = { "werepig", "guard", "INLIMBO" }

local function IsPig(dude)
    return dude:HasTag("pig")
end

local function IsWerePig(dude)
    return dude:HasTag("werepig")
end

local function IsNonWerePig(dude)
    return dude:HasTag("pig") and not dude:HasTag("werepig")
end

local function IsGuardPig(dude)
    return dude:HasTag("guard") and dude:HasTag("pig")
end

local normalbrain = require "brains/pigmandrawingbrain"

local function GetStatus(inst)
    return (inst:HasTag("werepig") and "WEREPIG")
        or (inst:HasTag("guard") and "GUARD")
        or (inst.components.follower.leader ~= nil and "FOLLOWER")
        or nil
end

local function displaynamefn(inst)
    return inst.name
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddLightWatcher()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .25) -- mass, size

    inst.DynamicShadow:SetSize(1.5, .2) --width, height
    inst.Transform:SetFourFaced()

    inst:AddTag("character")
    inst:AddTag("pig")
    inst:AddTag("scarytoprey")
	
	inst:AddTag("companion")
	
    inst.AnimState:SetBank("pigman")
	inst.AnimState:SetBuild("pigman_drawing_1")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("hat")
	
	inst:AddComponent("warolinedrawingclient")
	inst.components.warolinedrawingclient:SetUp("pigman_drawing")

    --Sneak these into pristine state for optimization
    inst:AddTag("_named")
	
	--trader (from trader component) added to pristine state for optimization
	inst:AddTag("trader")

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 35
	inst.components.talker.font = TALKINGFONT
	--inst.components.talker.colour = Vector3(133/255, 140/255, 167/255)
	inst.components.talker.offset = Vector3(0, -400, 0)
	inst.components.talker:MakeChatter()
	inst.components.talker:IgnoreAll()
	
	inst:DoTaskInTime(0.9, function(inst)
		if inst.components.talker then
			inst.components.talker:StopIgnoringAll()
		end
	end)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --Remove these tags so that they can be added properly when replicating components below
    inst:RemoveTag("_named")

    inst.components.talker.ontalk = ontalk

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED --5
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED --3
	--inst.components.locomotor:SetAllowPlatformHopping(true)

	inst:SetBrain(normalbrain)
    inst:SetStateGraph("SGpigdrawing")

    --inst:AddComponent("embarker")
    inst:AddComponent("drownable")

    inst:AddComponent("bloomer")
	
    ------------------------------------------
    inst:AddComponent("health")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"
	inst.components.health:SetMaxHealth(1)
    inst.components.combat:SetTarget(nil)
	inst.components.combat:SetDefaultDamage(TUNING.DRAWING_ATTACK_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PIG_ATTACK_PERIOD)
	
	MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
	
	inst.components.propagator.flashpoint = 10 + math.random()*5 -- Default flashpoint: 5 + math.random()*5

    ------------------------------------------
    MakeHauntablePanic(inst)

    ------------------------------------------
	
    inst:AddComponent("follower")
	
	inst:AddComponent("knownlocations")
	
    ------------------------------------------

    inst:AddComponent("inventory")

    ------------------------------------------

	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	inst.components.trader.deleteitemonaccept = false
	inst.components.trader:Enable()
    
    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.WAROLINEDRAWING_SANITYAURA_TINY

    ------------------------------------------

    inst:AddComponent("sleeper")
	inst.components.sleeper:SetResistance(2)
	inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    ------------------------------------------
    MakeMediumFreezableCharacter(inst, "pig_torso")
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(true)
	inst.components.warolinedrawing:SetSpawnFXSize(0.8, 1.2) -- migration, despawn
	inst.components.warolinedrawing:SetIsFighter()

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus
    ------------------------------------------

    return inst
end

return Prefab("pigman_drawing", fn, assets),
    MakePlacer("pigman_drawing_placer", "pigman_drawing_placer", "pigman_drawing_placer", "pigman_drawing_placer")
