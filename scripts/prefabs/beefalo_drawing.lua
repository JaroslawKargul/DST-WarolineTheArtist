local assets =
{
    Asset("ANIM", "anim/beefalo_drawing_1.zip"),
	Asset("ANIM", "anim/beefalo_drawing_1_sym.zip"),
	Asset("ANIM", "anim/beefalo_drawing_2.zip"),
	Asset("ANIM", "anim/beefalo_drawing_2_sym.zip"),
	
	Asset("ANIM", "anim/beefalo_placer.zip"),
}

local brain = require("brains/beefalodrawingbrain")

local sounds = 
{
    walk = "dontstarve/beefalo/walk",
    grunt = "dontstarve/beefalo/grunt",
    yell = "dontstarve/beefalo/yell",
    swish = "dontstarve/beefalo/tail_swish",
    curious = "dontstarve/beefalo/curious",
    angry = "dontstarve/beefalo/angry",
    sleep = "dontstarve/beefalo/sleep",
}

local WAKE_TO_FOLLOW_DISTANCE = 3
local SLEEP_NEAR_LEADER_DISTANCE = 2

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) and not TheWorld:HasTag("cave") and TheWorld.state.isnight and not TheWorld.state.isfullmoon and not inst.components.rideable:IsBeingRidden()
end

local function removecarrat(inst, carrat)
    inst:RemoveTag("HasCarrat")
    carrat._color = inst._carratcolor
    carrat._setcolorfn(carrat, carrat._color)
end

local function setcarratart(inst)
    if inst._carratcolor then
        inst.AnimState:OverrideSymbol("carrat_tail", "yotc_carrat_colour_swaps", inst._carratcolor.."_carrat_tail")
        inst.AnimState:OverrideSymbol("carrat_ear", "yotc_carrat_colour_swaps", inst._carratcolor.."_carrat_ear")
        inst.AnimState:OverrideSymbol("carrot_parts", "yotc_carrat_colour_swaps", inst._carratcolor.."_carrot_parts")
    end
end

local function addcarrat(inst, carrat)
    inst:AddTag("HasCarrat")
    inst._carratcolor = carrat._color
    setcarratart(inst)
end

local function createcarrat(inst)
    local carrat = SpawnPrefab("carrat")
    if inst._carratcolor then
        carrat._setcolorfn(carrat, inst._carratcolor)
    end
    carrat.setbeefalocarratrat(carrat)
    return carrat
end

local function testforcarratexit(inst)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, 12)
    local carrat = createcarrat(inst)
     
    local foundfood = nil
    for i,ent in ipairs(ents) do
        if carrat.components.eater:CanEat(ent) and ent.components.bait and not ent:HasTag("planted") and
            not (ent.components.inventoryitem and ent.components.inventoryitem:IsHeld()) and
            ent:IsOnPassablePoint() and
            ent:GetCurrentPlatform() == inst:GetCurrentPlatform() then
                foundfood = ent
                break
        end
    end
    if foundfood then
        removecarrat(inst,carrat)           
        carrat.Transform:SetPosition(x,y,z)        
    else
        carrat:Remove()
    end
end

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "beefalo", "wall", "INLIMBO" }

local function OnNewTarget(inst, data)
    if data ~= nil and data.target ~= nil and inst.components.follower ~= nil and data.target == inst.components.follower.leader then
        inst.components.follower:SetLeader(nil)
    end
end

local function CanShareTarget(dude)
    return dude:HasTag("beefalo")
        and not dude:IsInLimbo()
        and not (dude.components.health:IsDead() or dude:HasTag("player"))
end

local function OnAttacked(inst, data)
    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end
    inst._ridersleep = nil
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnDeath(inst, data)
    inst.persists = false
    inst:AddTag("NOCLICK")
    if inst.components.rideable:IsBeingRidden() then
        --SG won't handle "death" event while we're being ridden
        --SG is forced into death state AFTER dismounting (OnRiderChanged)
        inst.components.rideable:Buck(true)
    end

    if inst:HasTag("HasCarrat") and IsSpecialEventActive(SPECIAL_EVENTS.YOTC) then
        local x,y,z = inst.Transform:GetWorldPosition()
        local carrat = createcarrat(inst)
        
        if inst._carratcolor then
            carrat._setcolorfn(carrat, inst._carratcolor)
        end        
        carrat.Transform:SetPosition(x,y,z)        
    end
end

local function DoRiderSleep(inst, sleepiness, sleeptime)
    inst._ridersleeptask = nil
    inst.components.sleeper:AddSleepiness(sleepiness, sleeptime)
end

local function rider_moisture(newrider, data)
	if data and data.new and data.new > 35 and newrider.components.rider and newrider.components.rider:IsRiding() and newrider.components.rider:GetMount():HasTag("waroline_drawing") then
		local mount = newrider.components.rider:GetMount()
		local artist = mount.components.warolinedrawing:GetArtist()
		if artist then
			artist.components.warolineartist:DiscardDrawing(mount)
			if artist.components.talker then
				artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_WET"))
			end
		end
	end
end

local function rider_burning(newrider)
	if newrider.components.rider and newrider.components.rider:IsRiding() and newrider.components.rider:GetMount():HasTag("waroline_drawing") then
		local mount = newrider.components.rider:GetMount()
		local artist = mount.components.warolinedrawing:GetArtist()
		if artist then
			artist.components.warolineartist:DiscardDrawing(mount)
			
			artist:DoTaskInTime(1, function(artist)
				if artist.components.talker and not artist:HasTag("playerghost") then
					artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_BURN"))
				end
			end)
		end
	end
end

local function OnRiderChanged(inst, data)
    if inst._bucktask ~= nil then
        inst._bucktask:Cancel()
        inst._bucktask = nil
    end

    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end
	
	-- update brain depending on where the player took us during riding
	inst:DoTaskInTime(1, function(inst)
		if inst.components.rideable and not inst.components.rideable:IsBeingRidden() then
			local x, y, z = inst.Transform:GetWorldPosition()
			local is_boat = TheWorld.Map:GetPlatformAtPoint(x, z)
			
			local brain_name = (string.gsub(inst.prefab, "_", "")) .. "brain"
			
			local brain_land = require("brains/" .. brain_name)
			local brain_boat = require("brains/" .. brain_name .. "_boat")
			
			if is_boat and inst.brain then
				--print("Beefalo_Drawing: Updating brain... New brain: " .. brain_name .. "_boat")
				inst:SetBrain(brain_boat)
			elseif not is_boat and inst.brain then
				--print("Beefalo_Drawing: Updating brain... New brain: " .. brain_name)
				inst:SetBrain(brain_land)
			end
		end
	end)

	if data.newrider ~= nil then
		local newrider = data.newrider
		
		if inst.components.burnable and inst.components.burnable:IsSmoldering() then
			inst.components.burnable:StopSmoldering()
		end
		
		if inst.components.burnable and inst.components.burnable:IsBurning() then
			local artist = inst.components.warolinedrawing:GetArtist()
			if artist then
				artist.components.warolineartist:DiscardDrawing(inst)
				if artist.components.talker then
					artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_BURN"))
				end
			end
		end
		
		if newrider.components.moisture and newrider.components.moisture.moisture > 35 and inst.components.warolinedrawing:GetArtist() then
			local artist = inst.components.warolinedrawing:GetArtist()
			if artist.components.warolineartist then
				artist.components.warolineartist:DiscardDrawing(inst)
				if artist.components.talker then
					artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_WET"))
				end
			end
		end
		
		if newrider.components.moisture then
			newrider:ListenForEvent("moisturedelta", rider_moisture)
		end
		
		if newrider.components.health then
			--newrider:ListenForEvent("startfiredamage", rider_burning)
			newrider:ListenForEvent("firedamage", rider_burning)
		end
		
		newrider.AnimState:AddOverrideBuild("beefalo_drawing_1")
		newrider.AnimState:OverrideSymbol("beefalo_mouthmouth", "beefalo_drawing_1_sym", "beefalo_mouthmouth_riding")
		
		newrider.waroline_drawing_task = {}
		newrider.waroline_drawing_task.currentbuild = "beefalo_drawing_1"
		newrider.waroline_drawing_task.task = newrider:DoPeriodicTask(.3, function(newrider)
			if newrider.waroline_drawing_task.currentbuild == "beefalo_drawing_1" then
				newrider.AnimState:ClearOverrideBuild("beefalo_drawing_1")
				newrider.AnimState:AddOverrideBuild("beefalo_drawing_2")
				newrider.AnimState:OverrideSymbol("beefalo_mouthmouth", "beefalo_drawing_2_sym", "beefalo_mouthmouth_riding")
				newrider.waroline_drawing_task.currentbuild = "beefalo_drawing_2"
			elseif newrider.waroline_drawing_task.currentbuild == "beefalo_drawing_2" then
				newrider.AnimState:ClearOverrideBuild("beefalo_drawing_2")
				newrider.AnimState:AddOverrideBuild("beefalo_drawing_1")
				newrider.AnimState:OverrideSymbol("beefalo_mouthmouth", "beefalo_drawing_1_sym", "beefalo_mouthmouth_riding")
				newrider.waroline_drawing_task.currentbuild = "beefalo_drawing_1"
			end
		end)
		
		local function CancelBeefaloDrawingTask(newrider)
			newrider.AnimState:ClearOverrideBuild("beefalo_drawing_1")
			if newrider.waroline_drawing_task and newrider.waroline_drawing_task.task then
				newrider.waroline_drawing_task.task:Cancel()
				newrider.waroline_drawing_task.task = nil
				newrider.waroline_drawing_task = nil
			end
		end
		
		--newrider:ListenForEvent("dismount", CancelBeefaloDrawingTask)
		newrider:ListenForEvent("dismounted", CancelBeefaloDrawingTask)
	end

    if data.newrider ~= nil then
        if inst.components.sleeper ~= nil then
            inst.components.sleeper:WakeUp()
        end
        inst.components.knownlocations:RememberLocation("loiteranchor", inst:GetPosition())
    elseif inst.components.health:IsDead() then
        if inst.sg.currentstate.name ~= "death" then
            inst.sg:GoToState("death")
        end
    elseif inst.components.sleeper ~= nil then
        inst.components.sleeper:StartTesting()
        if inst._ridersleep ~= nil then
            local sleeptime = inst._ridersleep.sleeptime + inst._ridersleep.time - GetTime()
            if sleeptime > 2 then
                inst._ridersleeptask = inst:DoTaskInTime(0, DoRiderSleep, inst._ridersleep.sleepiness, sleeptime)
            end
            inst._ridersleep = nil
        end
    end
end

local function OnSaddleChanged(inst, data)
    if data.saddle ~= nil then
        inst:AddTag("companion")
    else
        inst:RemoveTag("companion")
    end
end

local function _OnRefuseRider(inst)
    if inst.components.sleeper:IsAsleep() and not inst.components.health:IsDead() then
        -- this needs to happen after the stategraph
        inst.components.sleeper:WakeUp()
    end
end

local function OnRefuseRider(inst, data)
    inst:DoTaskInTime(0, _OnRefuseRider)
end

local function OnRiderSleep(inst, data)
    inst._ridersleep = inst.components.rideable:IsBeingRidden() and {
        time = GetTime(),
        sleepiness = data.sleepiness,
        sleeptime = data.sleeptime,
    } or nil
end

local function onwenthome(inst,data)
    if data.doer and data.doer.prefab == "carrat" then
        addcarrat(inst,data.doer)
        inst:PushEvent("carratboarded")
    end
end

local function OnSave(inst, data)
    data.hascarrat = inst:HasTag("HasCarrat")
    data.carratcolor = inst._carratcolor
end

local function OnLoad(inst, data)
    if IsSpecialEventActive(SPECIAL_EVENTS.YOTC) then
		if data ~= nil and data.hascarrat then
			inst:AddTag("HasCarrat")
		end
		if data ~= nil and data.carratcolor then
			inst._carratcolor = data.carratcolor
		end
	end
end

local function GetDebugString(inst)
    return string.format("tendency %s nextbuck %.2f", inst.tendency, GetTaskRemaining(inst._bucktask))
end

local function beefalo()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .25)

    inst.DynamicShadow:SetSize(6, .5)
    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("beefalo")
    inst.AnimState:SetBuild("beefalo_drawing_1")
    inst.AnimState:AddOverrideBuild("poop_cloud")
    inst.AnimState:AddOverrideBuild("beefalo_carrat_idles")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("HEAT")
	
	inst:AddComponent("warolinedrawingclient")
	inst.components.warolinedrawingclient:SetUp("beefalo_drawing")

    inst:AddTag("beefalo")
    inst:AddTag("animal")
    inst:AddTag("largecreature")
	
	inst:AddTag("companion")
	
	-- from domesticatable component
	inst:AddTag("domesticatable")

    --saddleable (from rideable component) added to pristine state for optimization
    inst:AddTag("saddleable")

    inst.sounds = sounds

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	--inst.AnimState:AddOverrideBuild("beefalo_drawing_1")

    inst:AddComponent("bloomer")

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
    inst.components.combat:SetDefaultDamage(TUNING.DRAWING_MOUNT_DAMAGE)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1)
    inst.components.health.nofadeout = true
    inst:ListenForEvent("death", OnDeath) -- need to handle this due to being mountable

    inst:AddComponent("inspectable")

    inst:AddComponent("knownlocations")

    inst:AddComponent("leader")
    inst:AddComponent("follower")
    inst.components.follower.canaccepttarget = false

    inst:AddComponent("rideable")
    inst.components.rideable.canride = true
	inst.components.rideable.saddleable = false
    inst:ListenForEvent("saddlechanged", OnSaddleChanged)
    inst:ListenForEvent("refusedrider", OnRefuseRider)
	
	inst:AddComponent("domesticatable") -- required for riding
	inst.components.domesticatable.domestication_triggerfn = function(inst) return false end
	
	inst:AddComponent("hunger") -- required for domesticatable
	inst.components.hunger.burning = false
	inst.components.hunger.hungerrate = 0
    inst.components.hunger.hurtrate = 0

    --MakeLargeBurnableCharacter(inst, "beefalo_body")
	MakeLargeBurnable(inst)
    MakeSmallPropagator(inst)
    MakeLargeFreezableCharacter(inst, "beefalo_body")
	
	inst.components.propagator.flashpoint = 15 + math.random()*5 -- Default flashpoint: 5 + math.random()*5
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(true)
	inst.components.warolinedrawing:SetSpawnFXSize(1.6, 2) -- migration, despawn

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.BEEFALO_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.BEEFALO_RUN_SPEED.DEFAULT

	inst:AddComponent("lootdropper") -- required for saddles

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
	inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
    inst.setcarratart = setcarratart

    inst.tendency = TENDENCY.DEFAULT
    inst._bucktask = nil

    inst:ListenForEvent("riderchanged", OnRiderChanged)
    inst:ListenForEvent("ridersleep", OnRiderSleep)
	
    inst:AddComponent("uniqueid")
    inst:AddComponent("beefalometrics")
    inst:AddComponent("drownable")

    MakeHauntablePanic(inst)

    inst.testforcarratexit = testforcarratexit

    inst:SetBrain(brain)
    inst:SetStateGraph("SGbeefalodrawing")

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	
	-- Compatibility with the new update. Woo.
	inst.GetIsInMood = function(inst)
		return false
	end
	
	inst.ShouldBeg = function(inst)
		return false
	end

	inst.UpdateDomestication = function(inst)
		-- do nothing lol
	end
	
    return inst
end

return Prefab("beefalo_drawing", beefalo, assets),
	MakePlacer("beefalo_drawing_placer", "beefalo_placer", "beefalo_placer", "beefalo_placer")
