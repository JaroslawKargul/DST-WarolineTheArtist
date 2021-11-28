local assets =
{
    Asset("ANIM", "anim/rabbit_drawing_1.zip"),
	Asset("ANIM", "anim/rabbit_drawing_2.zip"),
	
	Asset("ANIM", "anim/rabbit_drawing_asparagus_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_carrot_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_corn_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_dragonfruit_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_durian_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_eggplant_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_garlic_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_onion_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_pepper_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_pomegranate_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_potato_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_pumpkin_sym.zip"),
	Asset("ANIM", "anim/rabbit_drawing_tomato_sym.zip"),
	
	Asset("ANIM", "anim/rabbit_drawing_placer.zip"),
}

local WAKE_TO_FOLLOW_DISTANCE = 2
local SLEEP_NEAR_LEADER_DISTANCE = 1

local function ShouldWakeUp(inst)
    return not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) and
		(inst.components.follower.leader ~= nil and inst.components.follower.leader.sg ~= nil and inst.components.follower.leader.sg:HasStateTag("idle")) and
		inst.bufferedaction == nil
end

local function RemoveRottenCarrot(carrot, percent)
	if not percent or percent and percent == 0 then
		if carrot.components.inventoryitem and carrot.components.inventoryitem.owner and carrot.components.inventoryitem.owner.prefab == "rabbit_drawing" then
			local owner = carrot.components.inventoryitem.owner
			
			if owner.components.inventory then
				owner.components.inventory:DropEverything()
			end
			
			if owner:HasTag("has_carrot") then
				owner:RemoveTag("has_carrot")
			end
			
			if owner:HasTag("carrot_searching") then
				owner:RemoveTag("carrot_searching")
			end
			
			owner.AnimState:ClearOverrideSymbol("mouth")
			owner.carrot_to_pick_up = nil
		end
	end
end

local function GetCarryableInvVeggiePrefab(inst)
	local inv_contents = inst.replica.inventory ~= nil and inst.replica.inventory:GetItems() or 
		inst.components.inventory ~= nil and inst.components.inventory:ReferenceAllItems()
	
	local veggie_prefab = ""
	for i,v in ipairs(inv_contents) do
		if v ~= nil and v.prefab ~= nil and table.contains(TUNING.RABBIT_DRAWING_SUPPORTED_VEGGIES, v.prefab) then
			veggie_prefab = v.prefab
			break
		end
	end
	
	return veggie_prefab ~= "" and veggie_prefab or nil
end

local function HaveCarrot(inst, veggie)
	if not inst:HasTag("has_carrot") then
		inst:AddTag("has_carrot")
	end
	
	local veggie_prefab = veggie ~= nil and veggie.prefab or GetCarryableInvVeggiePrefab(inst)
	
	inst.carrot_to_pick_up = nil
	
	if veggie_prefab then
		inst.AnimState:OverrideSymbol("mouth", "rabbit_drawing_" .. veggie_prefab .. "_sym", "mouth1")
	else
		inst.AnimState:ClearOverrideSymbol("mouth")
	end
	
	if veggie then
		veggie:ListenForEvent("perished", RemoveRottenCarrot)
		veggie:ListenForEvent("perishchange", RemoveRottenCarrot)
	end
end

local function RemoveCarrot(inst, veggie)
	if inst:HasTag("has_carrot") then
		inst:RemoveTag("has_carrot")
	end
	
	if inst:HasTag("carrot_searching") then
		inst:RemoveTag("carrot_searching")
	end
	
	inst.AnimState:ClearOverrideSymbol("mouth")
	inst.carrot_to_pick_up = nil
end

local rabbitsounds =
{
    scream = "dontstarve/rabbit/scream",
    hurt = "dontstarve/rabbit/scream_short",
}

local brain = require("brains/rabbitdrawingbrain")

local function describe(inst, viewer)
	local desc = inst:HasTag("has_carrot") and GetDescription(viewer, inst, "HAS_CARROT") or GetDescription(viewer, inst, "GENERIC")
	return desc
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.entity:AddLightWatcher()

    MakeCharacterPhysics(inst, 100, .25)

    inst.DynamicShadow:SetSize(1, .2)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("rabbit")
    inst.AnimState:SetBuild("rabbit_drawing_1")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddComponent("warolinedrawingclient")
	inst.components.warolinedrawingclient:SetUp("rabbit_drawing")

    inst:AddTag("animal")
    inst:AddTag("prey")
    inst:AddTag("rabbit")
    inst:AddTag("smallcreature")
    inst:AddTag("cattoy")
    inst:AddTag("catfood")
	
	inst:AddTag("companion")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.RABBIT_RUN_SPEED
	
    inst:SetStateGraph("SGrabbitdrawing")

    inst:SetBrain(brain)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.WAROLINEDRAWING_SANITYAURA_SMALL_TINY

    inst:AddComponent("knownlocations")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1)
    
	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "chest"
	
	inst:AddComponent("follower")
	inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderonattacked = true
	
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	MakeTinyFreezableCharacter(inst, "chest")
	
	inst.components.propagator.flashpoint = 7 + math.random()*5 -- Default flashpoint: 5 + math.random()*5
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(true)

    inst:AddComponent("inspectable")
	inst.components.inspectable.getspecialdescription = describe
	
    inst:AddComponent("sleeper")
	inst.components.sleeper.testperiod = GetRandomWithVariance(3, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
	inst:AddComponent("inventory")
	
	inst:DoTaskInTime(0, function(inst)
		if GetCarryableInvVeggiePrefab(inst) then
			HaveCarrot(inst)
		end
	end)

	inst.HaveCarrot = HaveCarrot
	inst.RemoveCarrot = RemoveCarrot
	inst.GetCarryableInvVeggiePrefab = GetCarryableInvVeggiePrefab

    inst.sounds = rabbitsounds

    MakeHauntablePanic(inst)

    return inst
end

return Prefab("rabbit_drawing", fn, assets, prefabs),
	MakePlacer("rabbit_drawing_placer", "rabbit_drawing_placer", "rabbit_drawing_placer", "placer")
