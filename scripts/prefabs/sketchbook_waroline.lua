local function MakeSketchbookSkin(skinname)

local assets =
{
	Asset("ANIM", "anim/sketchbook_waroline" .. skinname ..".zip"),
	Asset("ANIM", "anim/swap_sketchbook_waroline" .. skinname ..".zip"),

    Asset( "IMAGE", "images/inventoryimages/sketchbook_waroline" .. skinname ..".tex" ),
    Asset( "ATLAS", "images/inventoryimages/sketchbook_waroline" .. skinname ..".xml" ),
}

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_sketchbook_waroline" .. skinname, "swap_sketchbook_waroline")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	
	if owner and owner:HasTag("waroline") then
		owner:AddTag("sketchbook_user")
		owner:PushEvent("unlockrecipe")
	end
end

local function onunequip(inst, owner)
	if owner and owner:HasTag("sketchbook_user") then
		owner:RemoveTag("sketchbook_user")
		owner:PushEvent("unlockrecipe")
	end
	
	owner.AnimState:ClearOverrideSymbol("swap_object")
	owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("map_sketchbook_waroline" .. skinname .. ".tex")

    inst.AnimState:SetBank("sketchbook_waroline")
    inst.AnimState:SetBuild("sketchbook_waroline" .. skinname)
    inst.AnimState:PlayAnimation("idle")
	
	-- For clientside checks
	inst.WarolineSkinName = skinname

    inst:AddTag("sketchbook_waroline")
	--inst:AddTag("weapon")
	inst:AddTag("nopunch")
	
    MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sketchbook_waroline" .. skinname
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sketchbook_waroline" .. skinname .. ".xml"

	--inst:AddComponent("weapon")
	--inst.components.weapon:SetDamage(TUNING.SKETCHBOOK_WAROLINE.DAMAGE)

    inst:AddComponent("inspectable")

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
	MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunch(inst)
	
	inst:ListenForEvent("deletenewspawn", inst.Remove)

    return inst
end

return Prefab("common/inventory/sketchbook_waroline" .. skinname, fn, assets)
end

local skins = {}
local skin1 = MakeSketchbookSkin("")
local skin2 = MakeSketchbookSkin("_survivor")
local skin3 = MakeSketchbookSkin("_winter")
table.insert(skins, skin1)
table.insert(skins, skin2)
table.insert(skins, skin3)
 
return unpack(skins)