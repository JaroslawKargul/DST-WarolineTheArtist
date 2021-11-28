local prefabs = {}

table.insert(prefabs, CreatePrefabSkin("waroline_none",
{
	base_prefab = "waroline",
	build_name_override = "waroline",
	type = "base",
	rarity = "Character",
	skip_item_gen = true,
	skip_giftable_gen = true,
	skin_tags = { "BASE", "WAROLINE", },
	skins = {
		normal_skin = "waroline",
		ghost_skin = "ghost_waroline_build",
	},
	assets = {
		Asset( "ANIM", "anim/waroline.zip" ),
		Asset( "ANIM", "anim/ghost_waroline_build.zip" ),
		Asset( "ANIM", "anim/waroline_survivor.zip" ),
		Asset( "ANIM", "anim/waroline_winter.zip" ),
	},

}))

table.insert(prefabs, CreatePrefabSkin("waroline_survivor",
{
	base_prefab = "waroline",
	build_name_override = "waroline_survivor",
	type = "base",
	rarity = "Elegant",
	skip_item_gen = true,
	skip_giftable_gen = true,
	skin_tags = { "BASE", "WAROLINE"},
	skins = {
		normal_skin = "waroline_survivor",
		ghost_skin = "ghost_waroline_build",
	},

	assets = {
		Asset( "ANIM", "anim/waroline.zip" ),
		Asset( "ANIM", "anim/ghost_waroline_build.zip" ),
		Asset( "ANIM", "anim/waroline_survivor.zip" ),
		Asset( "ANIM", "anim/waroline_winter.zip" ),
	},
}))

table.insert(prefabs, CreatePrefabSkin("waroline_winter",
{
	base_prefab = "waroline",
	build_name_override = "waroline_winter",
	type = "base",
	rarity = "Elegant",
	skip_item_gen = true,
	skip_giftable_gen = true,
	hide_arm_lower_cuff_with_arm_skins = true, -- hide 'arm_lower_cuff' if any 'body' skin is used
	hide_long_sleeves_with_arm_skins = true, -- hide 'arm_upper' and override 'arm_lower' with 'arm_lower_skin' if any 'body' skin is used
	has_arm_lower_skin_symbol = true, -- build contains 'arm_lower_skin' symbol
	
	skin_tags = { "BASE", "WAROLINE"},
	skins = {
		normal_skin = "waroline_winter",
		ghost_skin = "ghost_waroline_build",
	},

	assets = {
		Asset( "ANIM", "anim/waroline.zip" ),
		Asset( "ANIM", "anim/ghost_waroline_build.zip" ),
		Asset( "ANIM", "anim/waroline_survivor.zip" ),
		Asset( "ANIM", "anim/waroline_winter.zip" ),
	},
}))

return unpack(prefabs)
