local MakePlayerCharacter = require "prefabs/player_common"
local PlayerHud = require("screens/playerhud")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = { "sketchbook_waroline" }

local start_inv = { "sketchbook_waroline" }

local PLACER_SCALE = 1.13

local function OnEnableHelper(inst, enabled)
	-- enable this helper only for ThePlayer
	if inst ~= ThePlayer then
		return
	end
	
    if enabled then
        if inst.helper == nil then
            inst.helper = CreateEntity()

            --[[Non-networked entity]]
            inst.helper.entity:SetCanSleep(false)
            inst.helper.persists = false

            inst.helper.entity:AddTransform()
            inst.helper.entity:AddAnimState()

            inst.helper:AddTag("CLASSIFIED")
            inst.helper:AddTag("NOCLICK")
            inst.helper:AddTag("placer")

            inst.helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

            inst.helper.AnimState:SetBank("firefighter_placement")
            inst.helper.AnimState:SetBuild("firefighter_placement")
            inst.helper.AnimState:PlayAnimation("idle")
            inst.helper.AnimState:SetLightOverride(1)
            inst.helper.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
            inst.helper.AnimState:SetLayer(LAYER_BACKGROUND)
            inst.helper.AnimState:SetSortOrder(1)
            inst.helper.AnimState:SetAddColour(0, .2, .5, 0)

            inst.helper.entity:SetParent(inst.entity)
        end
    else
        if inst.helper ~= nil then
			inst.helper:Remove()
			inst.helper = nil
		end
    end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "waroline.tex" )
	inst:AddTag("waroline")
	inst:AddTag("allergic_artist")
	
	--Dedicated server does not need deployhelper
    if not TheNet:IsDedicated() then
		inst:AddComponent("deployhelper")
		inst.components.deployhelper.onenablehelper = OnEnableHelper
		for prefab,craftingdata in pairs(TUNING.SKETCHBOOK_WAROLINE.PREFABS) do
			if prefab ~= nil then
				inst.components.deployhelper:AddRecipeFilter(prefab)
			end
		end
    end
	
end

local function TrySketchBookAnim(inst)
	local is_idle = inst.sg and inst.sg.currentstate.name == "idle"
	local holds_sketchbook = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS):HasTag("sketchbook_waroline")
	local not_riding = not inst.components.rider or inst.components.rider and not inst.components.rider:IsRiding()
	if is_idle and holds_sketchbook and not_riding then
		inst.sg:GoToState("sketchbook_idle")
	end
end

local master_postinit = function(inst)
	inst.soundsname = "waroline"
	
	inst.customidleanim = "waroline_idle"
	
	inst.components.health:SetMaxHealth(TUNING.WAROLINE_HEALTH)
	inst.components.hunger:SetMax(TUNING.WAROLINE_HUNGER)
	inst.components.sanity:SetMax(TUNING.WAROLINE_SANITY)
	
    inst.components.combat.damagemultiplier = 1
	
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst:AddComponent("warolineartist")
	
	inst:AddComponent("allergicartist")
	inst.components.allergicartist:AddAllergen("corn", 0.5, -2, -1)
	inst.components.allergicartist:AddAllergen("corn_cooked", 0.5, -2, -1)
	inst.components.allergicartist:AddAllergen("corn_seeds", 0.5, -1, -1)
	inst.components.allergicartist:AddAllergen("carnivalfood_corntea", 0.5, -5, -3)
	inst.components.allergicartist:AddAllergen("powcake", 0.5, -10, -6)
	
	-- Loves fish
	inst.components.foodaffinity:AddPrefabAffinity("fishsticks", TUNING.AFFINITY_15_CALORIES_HUGE)
	
	-- Spawn Waroline with proper item skins
	inst.OnNewSpawn = function(inst)
		inst:DoTaskInTime(0.6, function(inst)
		inst.components.inventory.ignoresound = true
		
		local function DeleteSketchbook(inst)
			local sketchbook = inst.components.inventory:FindItem(function(item) return item.prefab=="sketchbook_waroline" end)
			sketchbook:PushEvent("deletenewspawn")
		end
		
		local clothing = inst.components.skinner:GetClothing()
		if inst.components.skinner and inst.components.skinner.skin_name == "waroline_survivor" then
			DeleteSketchbook(inst)
			inst.components.inventory:GiveItem(SpawnPrefab("sketchbook_waroline_survivor"))
		elseif inst.components.skinner and inst.components.skinner.skin_name == "waroline_winter" then
			DeleteSketchbook(inst)
			inst.components.inventory:GiveItem(SpawnPrefab("sketchbook_waroline_winter"))
		end
		inst.components.inventory.ignoresound = false
		end)
	end
	
	-- This task will keep "Sketchbook" Tab updated both on the server and on the client
	inst.keep_drawingtab_updated_task = inst:DoPeriodicTask(.6, function(inst)
		if not inst:HasTag("playerghost") and inst:HasTag("sketchbook_user") and inst.components.builder then
			inst.components.builder:ReloadDrawingUnlocks()
		end
	end)
	
	local function NoHoles(pt)
		return not TheWorld.Map:IsPointNearHole(pt)
	end

	local SPAWN_DIST = 2
	local ATTEMPTS = 22
	local function GetSpawnPoint(pt)
		local offset = FindWalkableOffset(pt, math.random() * 2 * PI, SPAWN_DIST, ATTEMPTS, true, true, NoHoles)
		if offset ~= nil then
			offset.x = offset.x + pt.x
			offset.z = offset.z + pt.z
			return offset
		else
			return pt
		end
	end
	
	inst:DoTaskInTime(1, function(inst)
		--print("Waroline: 1 second delay finished, launching function...")
		local drawing = nil
		if TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid] then
			--print("Waroline: Found sketches in depository, trying to spawn...")
			
			if TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid].LEGACYDATA ~= nil then
			
				local prefab = TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid].prefab
				local fuel = TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid].fuel
				local uses = TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid].uses
				local hat = TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid].hat
				local inv = TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid].inv
				
				inst.components.warolineartist:SpawnDrawingFromData(prefab, fuel, uses, hat, inv, true)
			
			else
			
				for k,v in pairs(TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid]) do
					inst:DoTaskInTime(math.random(), function(inst)
						local prefab = v.prefab
						local fuel = v.fuel
						local uses = v.uses
						local hat = v.hat
						local inv = v.inv
						
						--print("Waroline: Prefab to spawn: " .. prefab)
						
						inst.components.warolineartist:SpawnDrawingFromData(prefab, fuel, uses, hat, inv)
					end)
				end
				
			end
			
			TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[inst.userid] = nil
		end
	end)
	
	inst:ListenForEvent("newstate", TrySketchBookAnim)
	inst:ListenForEvent("death", function(inst)
		if inst.components.warolineartist and inst.components.warolineartist:CurrentlyHasDrawings() then
			local all_drawings = inst.components.warolineartist:GetDrawings(nil)
			for i,drawing in ipairs(all_drawings) do
				if drawing then
					inst.components.warolineartist:DiscardDrawing(drawing)
				end
			end
		end
	end)
end

return MakePlayerCharacter("waroline", prefabs, assets, common_postinit, master_postinit, start_inv)
