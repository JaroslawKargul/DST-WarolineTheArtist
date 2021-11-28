local assets =
{
    Asset("ANIM", "anim/pickaxe_drawing.zip"),
    Asset("ANIM", "anim/swap_pickaxe_drawing_1.zip"),
    Asset("ANIM", "anim/swap_pickaxe_drawing_2.zip"),
	
	Asset( "IMAGE", "images/inventoryimages/inv_pickaxe_drawing.tex" ),
    Asset( "ATLAS", "images/inventoryimages/inv_pickaxe_drawing.xml" ),
}

local function RemoveFX(inst)
    if inst.smolderfx ~= nil then
        inst.smolderfx:Remove()
        inst.smolderfx = nil
    end
	if inst.handburnfx ~= nil then
        inst.handburnfx:Remove()
        inst.handburnfx = nil
    end
end

local function SmolderInHand(inst, data)
	-- Smoldering
	local owner = data.owner
	RemoveFX(inst)
	inst.smolderfx = SpawnPrefab("smoke_plant")
	inst.smolderfx.Transform:SetScale(.6, .6, .6)
	inst.smolderfx.entity:AddFollower()
	inst.smolderfx.entity:SetParent(owner.entity)
	inst.smolderfx.Follower:FollowSymbol(owner.GUID, "swap_object", 15, -95, 0)
	inst.smolderfx:ListenForEvent("onremove", RemoveFX, inst)
end

local function CatchFireInHand(inst, data)
	-- Burning
	local owner = data.owner
	RemoveFX(inst)
	inst.handburnfx = SpawnPrefab("torchfire")
	inst.handburnfx.Transform:SetScale(2, 2, 2)
	if not inst.handburnfx.Follower then
		inst.handburnfx.entity:AddFollower()
	end
	inst.handburnfx.entity:SetParent(owner.entity)
	inst.handburnfx.Follower:FollowSymbol(owner.GUID, "swap_object", 15, -95, 0)
	inst.handburnfx:ListenForEvent("onremove", RemoveFX, inst)
end

local function onequip(inst, owner)
	if owner then
		owner.AnimState:OverrideSymbol("swap_object", "swap_pickaxe_drawing_1", "swap_pickaxe")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
		
		inst:ListenForEvent("shouldhandsmolder", SmolderInHand)
		inst:ListenForEvent("shouldhandburn", CatchFireInHand)
		
		if not owner.DrawingEquipTask then
			owner.DrawingEquipTask = {}
			owner.DrawingEquipTask.builds = { "swap_pickaxe_drawing_1", "swap_pickaxe_drawing_2" }
			owner.DrawingEquipTask.currentbuild = "swap_pickaxe_drawing_1"
		end
		
		owner.DrawingEquipTask.task = owner:DoPeriodicTask(.3, function(owner)
			local newbuild = "swap_pickaxe_drawing_1"
		
			for k,v in pairs(owner.DrawingEquipTask.builds) do
				if v and v ~= owner.DrawingEquipTask.currentbuild then
					newbuild = v
				end
			end
			owner.AnimState:OverrideSymbol("swap_object", newbuild, "swap_pickaxe")
			owner.DrawingEquipTask.currentbuild = newbuild
		end)
		
		inst.check_burning_stuff_nearby_task = inst:DoPeriodicTask(1, function(inst)
			if not inst.smolderfx and not inst.handburnfx then
				if not TheWorld.state.israining and inst.components.equippable:IsEquipped() then
					local x, y, z = inst.Transform:GetWorldPosition()
					local ents = TheSim:FindEntities(x, y, z, 2)
					local nearbyheat = 0
					for i, v in ipairs(ents) do
						if v.components.burnable ~= nil and v.components.burnable:IsBurning() and v.components.propagator and v.components.propagator.spreading and not v:HasTag("storytellingprop") then
							nearbyheat = 1
							break
						end
					end
					
					if nearbyheat > 0 then
						inst:PushEvent("shouldhandsmolder", {owner = inst.components.inventoryitem.owner})
					end
				end
			elseif not inst.handburnfx then
				if inst.smolderfx_counter == nil then
					inst.smolderfx_counter = 6
				elseif inst.smolderfx_counter <= 0 then
					if inst.components.equippable:IsEquipped() then
						inst:PushEvent("shouldhandburn", {owner = inst.components.inventoryitem.owner})
						local owner = inst.components.inventoryitem.owner
						owner:DoTaskInTime(1, function(owner)
							if owner and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) and owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS).handburnfx then
								if owner.components.talker then
									owner.components.talker:Say("Ouch!")
								end
								
								local handslot_item = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
								owner.components.inventory:DropItem(handslot_item, false, true)
								handslot_item.components.burnable:Ignite()
							end
						end)
					end
				else
					inst.smolderfx_counter = inst.smolderfx_counter - 1
				end
			end
			
		end)
	end
end

local function onunequip(inst, owner)
	if owner.DrawingEquipTask then
		if owner.DrawingEquipTask.task then
			owner.DrawingEquipTask.task:Cancel()
			owner.DrawingEquipTask.task = nil
		end
		owner.DrawingEquipTask = nil
	end
	
	inst:RemoveEventCallback("shouldhandsmolder", SmolderInHand)
	inst:RemoveEventCallback("shouldhandburn", CatchFireInHand)
	
	if inst.smolderfx or inst.handburnfx then
		owner.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	end
	
	RemoveFX(inst)
	
	if inst.check_burning_stuff_nearby_task then
		inst.check_burning_stuff_nearby_task:Cancel()
		inst.check_burning_stuff_nearby_task = nil
	end
	
	inst.smolderfx_counter = nil

    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function ShouldDisappear(inst)
	local pos_x, pos_y, pos_z = inst.Transform:GetWorldPosition()

	return  not TheWorld.Map:IsPassableAtPoint(pos_x, 0, pos_z) and
            not TheWorld.Map:IsVisualGroundAtPoint(pos_x, 0, pos_z)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("map_pickaxe_drawing.tex")

    inst.AnimState:SetBank("pickaxe_drawing")
    inst.AnimState:SetBuild("pickaxe_drawing")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("sharp")
    inst:AddTag("tool")
    inst:AddTag("weapon")
	inst:AddTag("_named")
	
	inst:AddTag("irreplaceable") -- prevent silly stuff, like bundling wrap or stealing and disconnecting

    MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE)
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.PICKAXE_DRAWING_USES)
    inst.components.finiteuses:SetUses(TUNING.PICKAXE_DRAWING_USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove) 
    inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 1)
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.PICKAXE_DRAWING_DAMAGE)
	
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "inv_pickaxe_drawing"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/inv_pickaxe_drawing.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	MakeSmallBurnable(inst, 2)
	MakeSmallPropagator(inst)
	
	inst:AddComponent("warolinedrawing")
	inst.components.warolinedrawing:SetIsCritter(false)

    MakeHauntableLaunch(inst)
	
	inst.ShouldDisappear = ShouldDisappear

    return inst
end

return Prefab("pickaxe_drawing", fn, assets),
    MakePlacer("pickaxe_drawing_placer", "pickaxe_drawing", "pickaxe_drawing", "placer")
