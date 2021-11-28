-- Original code by DarkXero, he did a great job. --
-- I have updated and edited this one so much it doesn't really resemble the original anymore. ---

-- Update (28.05.2020) - Added TechTree code to support updated builder
-- Update (01.11.2020) - Fixed KnowsRecipe on serverside
-- Update (11.11.2020) - Fixed KnowsRecipe on clientside

local require = GLOBAL.require
local resolvefilepath = GLOBAL.resolvefilepath
require "widgets/widgetutil" -- loads a couple of functions into global environment, e.g. CanPrototypeRecipe
local CanPrototypeRecipe = GLOBAL.CanPrototypeRecipe
local ShouldHintRecipe = GLOBAL.ShouldHintRecipe

local TECH = GLOBAL.TECH
local TUNING = GLOBAL.TUNING
local GetValidRecipe = GLOBAL.GetValidRecipe
local deepcopy = GLOBAL.deepcopy
local next = GLOBAL.next
local TechTree = require("techtree")

local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT
local CHARACTER_INGREDIENT_SEG = GLOBAL.CHARACTER_INGREDIENT_SEG
local AllRecipes = GLOBAL.AllRecipes
local SpawnPrefab = GLOBAL.SpawnPrefab

local ACTIONS = GLOBAL.ACTIONS
local BufferedAction = GLOBAL.BufferedAction

local TheInput = GLOBAL.TheInput
local TheFrontEnd = GLOBAL.TheFrontEnd
local SendRPCToServer = GLOBAL.SendRPCToServer
local RPC = GLOBAL.RPC
local IsRecipeValid = GLOBAL.IsRecipeValid

local GetGameModeProperty = GLOBAL.GetGameModeProperty
local Vector3 = GLOBAL.Vector3
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS

local RoundBiasedUp = GLOBAL.RoundBiasedUp

-- Hunger Crafting (better check if it's not already implemented - who knows when Klei decides to add it)
if not CHARACTER_INGREDIENT.HUNGER then
	local _IsCharacterIngredient = GLOBAL.IsCharacterIngredient
	GLOBAL.IsCharacterIngredient = function(ingredienttype)
		return ingredienttype == CHARACTER_INGREDIENT.HUNGER or _IsCharacterIngredient(ingredienttype)
	end

	CHARACTER_INGREDIENT.HUNGER = "half_hunger"

	-- Serverside
	AddComponentPostInit("builder", function(self)
		local _HasCharacterIngredient = self.HasCharacterIngredient
		self.HasCharacterIngredient = function(self, ingredient)
			if ingredient.type == CHARACTER_INGREDIENT.HUNGER then
				if self.inst.components.hunger ~= nil then
					--round up hunger to match UI display
					local current = math.ceil(self.inst.components.hunger.current)
					local AMOUNT = math.max(1, RoundBiasedUp(ingredient.amount * self.ingredientmod))
					return current >= AMOUNT, current
				end
			else
				return _HasCharacterIngredient(self, ingredient)
			end
		end
		
	end)

	-- Clientside
	local b_rep = require("components/builder_replica")
	local _HasCharacterIngredient = b_rep.HasCharacterIngredient
	b_rep.HasCharacterIngredient = function(self, ingredient)
		if self.inst.components.builder ~= nil then
			return self.inst.components.builder:HasCharacterIngredient(ingredient)
		else
			if ingredient.type == CHARACTER_INGREDIENT.HUNGER then
				local hunger = self.inst.replica.hunger
				if hunger ~= nil then
					local current = math.ceil(hunger:GetCurrent())
					local AMOUNT = math.max(1, RoundBiasedUp(ingredient.amount * self:IngredientMod()))
					return current >= AMOUNT, current
				end
			else
				return _HasCharacterIngredient(self, ingredient)
			end
		end
	end
	
	--TEST
	
	--local _BufferBuild = b_rep.BufferBuild
	--b_rep.BufferBuild = function(self, recipename)
	--	local recipe = GetValidRecipe(recipename)
	--	if recipe ~= nil and recipe.isdrawing then
	--		if self.inst.components.builder ~= nil then
	--			self.inst.components.builder:BufferBuild(recipename)
	--			self.inst:DoTaskInTime(1, function(inst)
	--				inst.components.builder.buffered_builds[recipename] = nil
	--			end)
	--		elseif self.classified ~= nil then
	--			self.classified:BufferBuild(recipename)
	--			self.inst:DoTaskInTime(1, function(inst)
	--				inst.replica.builder:SetIsBuildBuffered(recipename, false)
	--			end)
	--		end
	--	else
	--		 _BufferBuild(self, recipename)
	--	end
	--end
	
	-- UI Edits
	local CraftTabs = require "widgets/crafttabs"
	local function CraftTabsPostConstruct(self, owner, top_root)
		local last_hunger_seg = nil

		local function UpdateRecipesForHungerIngredients(owner, data)
			local hunger = owner.replica.hunger
			if hunger ~= nil then
				local current_seg = math.floor(math.ceil(data.newpercent * hunger:Max()) / CHARACTER_INGREDIENT_SEG)
				local penalty_seg = hunger:GetPercent()
				if current_seg ~= last_hunger_seg then
					last_hunger_seg = current_seg
					self:UpdateRecipes()
				end
			end
		end
		
		self.inst:ListenForEvent("hungerdelta", UpdateRecipesForHungerIngredients, self.owner)
		
	end
	AddClassPostConstruct("widgets/crafttabs", CraftTabsPostConstruct)
	
	STRINGS.NAMES.HALF_HUNGER = "Hunger"
end

-- RECIPETABS WIDGETS

-- This one is kind of bad, but I really don't know how to handle it differently
-- Drawing recipes can show up as buffered on non-Waroline characters (but it's not like anyone but Waroline can use the Sketchbook, so...)
-- It's done like this for the sake of compatibility
local CraftTabs = require "widgets/crafttabs"
local function CraftTabsPostConstruct(crafttabs)
	local _DoUpdateRecipes = crafttabs.DoUpdateRecipes
    crafttabs.DoUpdateRecipes = function(self)
		if self.owner:HasTag("waroline") then
			if self.needtoupdate then
				self.needtoupdate = false
				local tabs_to_highlight = {}
				local tabs_to_alt_highlight = {}
				local tabs_to_overlay = {}
				local valid_tabs = {}

				for k,v in pairs(self.tabbyfilter) do
					tabs_to_highlight[v] = 0
					tabs_to_alt_highlight[v] = 0
					tabs_to_overlay[v] = 0
					valid_tabs[v] = false
				end

				local builder = self.owner.replica.builder
				if builder ~= nil then
					local current_research_level = builder:GetTechTrees()

					for k, rec in pairs(AllRecipes) do

						if IsRecipeValid(rec.name) then
							local tab = self.tabbyfilter[rec.tab]
							if tab ~= nil then
								local has_researched = builder:KnowsRecipe(rec.name)
								local can_learn = builder:CanLearn(rec.name)
								local can_see = has_researched or (can_learn and CanPrototypeRecipe(rec.level, current_research_level))
								local can_build = can_learn and builder:CanBuild(rec.name)
								local buffered_build = builder:IsBuildBuffered(rec.name) and not rec.isdrawing -- Exclude drawings from showing as buffered
								local can_research = not has_researched and can_see and can_build

								valid_tabs[tab] = valid_tabs[tab] or can_see

								if has_researched then
									if buffered_build then
										tabs_to_alt_highlight[tab] = tabs_to_alt_highlight[tab] + 1
									elseif can_build then
										if rec.nounlock then
											--for crafting stations that unlock custom recipes
											--by temporarily teaching them, we still want them
											--to behave like nounlock crafting recipes.
											tabs_to_overlay[tab] = tabs_to_overlay[tab] + 1
										else
											tabs_to_highlight[tab] = tabs_to_highlight[tab] + 1
										end
									end
								elseif can_research then
									tabs_to_overlay[tab] = tabs_to_overlay[tab] + 1
								end
							end
						end
					end
				end

				local to_select = nil
				local current_open = nil

				for k, v in pairs(valid_tabs) do
					if v then
						self.tabs:ShowTab(k)
					else
						self.tabs:HideTab(k)
					end

					local num = tabs_to_highlight[k]
					local alt = tabs_to_alt_highlight[k] > 0
					if num > 0 or alt then
						local numchanged = self.tabs_to_highlight == nil or num ~= self.tabs_to_highlight[k]
						k:Highlight(num, not numchanged, alt)
					else
						k:UnHighlight()
					end

					if tabs_to_overlay[k] > 0 then
						k:Overlay()
					else
						k:HideOverlay()
					end
				end

				self.tabs_to_highlight = tabs_to_highlight

				local selected = self.tabs:GetCurrentIdx()
				local tab = selected ~= nil and self.tabs.tabs[selected] or nil
				if tab ~= nil and self.tabs.shown[tab] then
					if self.controllercraftingopen then
						self.controllercrafting:OpenRecipeTab(selected)
					elseif self.crafting.shown then
						self.crafting:UpdateRecipes()
					end
				elseif self.controllercraftingopen then
					self.owner.HUD:CloseControllerCrafting()
				elseif self.crafting.shown then
					self.crafting:Close()
					self.tabs:DeselectAll()
				end
			end
		else
			_DoUpdateRecipes(self)
		end
	end
end
AddClassPostConstruct("widgets/crafttabs", CraftTabsPostConstruct)

local CraftSlot = require "widgets/craftslot"
local function CraftSlotPostConstruct(craftslot)
	local _Refresh = craftslot.Refresh
    craftslot.Refresh = function(self, recipename)
		recipename = recipename or self.recipename
		local recipe = AllRecipes[recipename]
		if recipe and recipe.isdrawing then
			local canbuild = self.owner.replica.builder:CanBuild(recipename)
			local knows = self.owner.replica.builder:KnowsRecipe(recipename)
			local buffered = false
			
			local do_pulse = self.recipename == recipename and not self.canbuild and canbuild
			self.recipename = recipename
			self.recipe = recipe
			self.recipe_skins = {}
			
			if self.recipe then
				self.recipe_skins = GLOBAL.Profile:GetSkinsForPrefab(self.recipe.name)

				self.canbuild = canbuild
				self.tile:SetRecipe(self.recipe)
				self.tile:Show()

				--#srosen erroneously showing inverted sometimes
				local right_level = CanPrototypeRecipe(self.recipe.level, self.owner.replica.builder:GetTechTrees())

				if self.fgimage then
					if knows or recipe.nounlock then
						if self.isquagmireshop then
							if canbuild or buffered then
								self.bgimage:SetTexture(self.atlas, "craft_slot_locked_highlight.tex")
							else
								self.bgimage:SetTexture(self.atlas, "craft_slot.tex")
							end
							self.lightbulbimage:Hide()
							self.fgimage:Hide()
						else
							if buffered then
								self.bgimage:SetTexture(self.atlas, "craft_slot_place.tex")
							else
								self.bgimage:SetTexture(self.atlas, "craft_slot.tex")
							end
							if canbuild or buffered then
								self.fgimage:Hide()
							else
								self.fgimage:Show()
								self.fgimage:SetTexture(self.atlas, "craft_slot_missing_mats.tex")
							end
							self.lightbulbimage:Hide()
							self.fgimage:SetTint(1, 1, 1, 1)
						end
					else
						--print("Right_Level for: ", recipename, " ", right_level)
						local show_highlight = false
						
						show_highlight = canbuild and right_level
						
						local hud_atlas = resolvefilepath( "images/hud.xml" )
						
						if not right_level then
							self.fgimage:SetTexture(hud_atlas, "craft_slot_locked_nextlevel.tex")
							self.lightbulbimage:Hide()
							self.fgimage:Show()
							if buffered then 
								self.bgimage:SetTexture(self.atlas, "craft_slot_place.tex") 
							else
								self.bgimage:SetTexture(self.atlas, "craft_slot.tex") 
							end
							self.fgimage:SetTint(.7,.7,.7,1)
						elseif show_highlight then
							self.bgimage:SetTexture(hud_atlas, "craft_slot_locked_highlight.tex")
							self.lightbulbimage:Show()
							self.fgimage:Hide()
							self.fgimage:SetTint(1,1,1,1)
						else
							self.fgimage:SetTexture(hud_atlas, "craft_slot_missing_mats.tex")
							self.lightbulbimage:Hide()
							self.fgimage:Show()
							if buffered then 
								self.bgimage:SetTexture(self.atlas, "craft_slot_place.tex") 
							else
								self.bgimage:SetTexture(self.atlas, "craft_slot.tex") 
							end
							self.fgimage:SetTint(1,1,1,1)
						end
					end
				end

				self.tile:SetCanBuild((buffered or canbuild )and (knows or recipe.nounlock or right_level))

				if self.recipepopup then
					self.recipepopup:SetRecipe(self.recipe, self.owner)
					if self.focus and not self.open then
						self:Open()
					end
				end
			end
		else
			_Refresh(self, recipename)
		end
	end
end
AddClassPostConstruct("widgets/craftslot", CraftSlotPostConstruct)

-- RPC Handler
--local function ReloadDrawingUnlocks(_, inst)
--	if inst.components.builder and inst.prefab == "waroline" and inst:HasTag("sketchbook_user") then
--		inst.components.builder:ReloadDrawingUnlocks()
--	end
--end
--AddModRPCHandler("ReloadDrawingUnlocksRPC", "ReloadDrawingUnlocks", ReloadDrawingUnlocks)

--local function ForceCancelPlacementWaroline(_, inst)
--	inst.components.talker:Say("RPC success")
--	if inst.components.playercontroller and inst:HasTag("sketchbook_user") then
--		inst.components.playercontroller:ForceCancelPlacement()
--	end
--end
--AddClientModRPCHandler("ForceCancelPlacementWarolineRPC", "ForceCancelPlacementWaroline", ForceCancelPlacementWaroline)

local RecipePopUp = require "widgets/recipepopup"
local function RecipePopUpPostConstruct(recipepopup)
	local _Refresh = recipepopup.Refresh
    recipepopup.Refresh = function(self)
		if self.recipe and self.recipe.isdrawing then
			
			-- Send RPC request to the server so that it reloads current recipes for us
			-- SendModRPCToServer(GetModRPC("ReloadDrawingUnlocksRPC", "ReloadDrawingUnlocks"), self.owner)
			
			_Refresh(self)
			if self.button then
				self.button:SetText("Draw")
			end
		else
			return _Refresh(self)
		end
	end
end
AddClassPostConstruct("widgets/recipepopup", RecipePopUpPostConstruct)

-- GREEN AMULET-RELATED CRAFTING MENU CHANGES

local IngredientUI = require "widgets/ingredientui"
local function IngrUIPostConstruct(self, atlas, image, quantity, on_hand, has_enough, name, owner, recipe_type)
	
	if quantity ~= nil then
		if recipe_type ~= nil and recipe_type == CHARACTER_INGREDIENT.HUNGER and owner ~= nil and owner:HasTag("waroline") then
			local builder = owner ~= nil and owner.replica.builder or nil
			if builder ~= nil then
				local AMOUNT = math.max(1, RoundBiasedUp(quantity * builder:IngredientMod()))
				self.quant:SetString(string.format("-%d", AMOUNT))
			else
				self.quant:SetString(string.format("-%d", quantity))
			end
		end
	end
	
end
AddClassPostConstruct("widgets/ingredientui", IngrUIPostConstruct)

-- WAROLINE BUILDER CHANGES

local function BuilderPostInit( builder )
	
	builder.waroline_drawings = {}
	
	-- New builder function which allows us to forget recipes
	builder.RemoveRecipe = function(self, recname)
		if table.contains(self.recipes, recname) then
			--print("Removing recipe: " .. recname)
			
			-- Clear buffered build for this recipe if there is one
			if self:IsBuildBuffered(recname) then
				self.buffered_builds[recname] = nil
			end
			
			--if GLOBAL.TheWorld.ismastersim and self.inst.components.playercontroller then
			--	self.inst.components.playercontroller:ForceCancelPlacement()
			--else
			--	SendModRPCToClient(GetClientModRPC("ForceCancelPlacementWarolineRPC", "ForceCancelPlacementWaroline"), self.inst.userid, self.inst, self.inst)
			--end
			
			-- Clear bufferedaction so that crafting doesn't break completely on clients
			if self.inst.bufferedaction and self.inst.bufferedaction.action == ACTIONS.BUILD and self.inst.bufferedaction.recipe and self.inst.bufferedaction.recipe.name == recname then
				--self.inst.bufferedaction_warolinebackup = self.inst.bufferedaction
				
				self.inst.bufferedaction:Cancel()
				self.inst.bufferedaction = nil
			end
			
			-- Now, remove this recipe from the table of known recipes
			local new_recipetable = {}
			for k,v in pairs(self.recipes) do
				if v ~= recname then
					table.insert(new_recipetable, v)
				end
			end
			self.recipes = new_recipetable
			
			self.inst.replica.builder:RemoveRecipe(recname)
			self.inst.replica.builder:SetIsBuildBuffered(recname, false)
			
			--self.inst:PushEvent("refreshcrafting")
			self.inst:PushEvent("unlockrecipe")
		end
	end
	
	-- Get known drawings - regular "learning" is only temporary for drawings
	builder.GetKnownDrawings = function(self)
		return self.waroline_drawings
	end
	
	-- Add new drawing recipe name to known list
	builder.LearnNewDrawing = function(self, recname)
		if not table.contains(self.waroline_drawings, recname) then
			table.insert(self.waroline_drawings, recname)
		end
	end
	
	-- Do we know this drawing, and if we don't - are we close enough to the prototyper?
	builder.TestCanDrawInCurrentPos = function(self, recname)
		local known = self:GetKnownDrawings()
		for k,v in pairs(known) do
			if v and v == recname then
				return true
			end
		end
		
		local PROTOTYPER_TAGS = { "prototyper_drawing" }
		local pos = self.inst:GetPosition()
		local prototypers = TheSim:FindEntities(pos.x, pos.y, pos.z, (TUNING.WAROLINE_DRAWING_DISTANCE + 0.5), PROTOTYPER_TAGS, self.exclude_tags)
		
		if prototypers ~= nil and #prototypers > 0 then
			for i,v in ipairs(prototypers) do
				if v and v.prefab and TUNING.SKETCHBOOK_WAROLINE.SREPYTOTORP[v.prefab] == recname then
					return true
				end
			end
		end
		
		-- if we got here that means the recipe should not be known by the player
		-- remember to verify it's a drawing before we just remove it
		if TUNING.SKETCHBOOK_WAROLINE.PROTOTYPERS[recname] then
			self:RemoveRecipe(recname)
		end
		return false
	end
	
	-- Save/Load changes - carryover of learned drawings (regular learning is only temporary for drawings)
	local _OnSave = builder.OnSave
	builder.OnSave = function(self)
		--print("Running custom builder OnSave function...")
		local savedata = _OnSave(self)
		if self.waroline_drawings ~= nil then
			--print("Warolinedrawings data found. Saving...")
			savedata.waroline_drawings = self.waroline_drawings
		end
		return savedata
	end
	
	local _OnLoad = builder.OnLoad
	builder.OnLoad = function(self, data)
		--print("Running custom builder OnLoad function...")
		if data.waroline_drawings ~= nil then
			--print("Saved drawing data found. Loading...")
			self.waroline_drawings = data.waroline_drawings
		end
		_OnLoad(self, data)
	end
	
	-- Verify function for all unlockable drawings - to be triggered at will
	builder.ReloadDrawingUnlocks = function(self, useprototyperdata)
		--print("----")
		--print("Reloading drawing unlocks...")
		local known_drawings = self.waroline_drawings
		local recipe_drawings = {}
		
		--for k,v in pairs(known_drawings) do
		--	print("#1 Known drawings: " .. v)
		--end
		
		for k,v in pairs(self.recipes) do
			local rec = v.name == nil and v or v.name ~= nil and v.name
			if rec ~= nil and TUNING.SKETCHBOOK_WAROLINE.PROTOTYPERS[rec] then
				--print("#2 Known recipe drawings: " .. rec)
				if not table.contains(known_drawings, rec) then
					table.insert(recipe_drawings, rec)
				end
			end
		end
		
		local unknown_drawings = {}
		
		for k,v in pairs(recipe_drawings) do
			if v and not table.contains(known_drawings, v) then
				--print("#3 Unknown drawing: " .. v)
				table.insert(unknown_drawings, v)
			end
		end
		
		if #unknown_drawings > 0 then
			
			local prototypers = {}
			if not useprototyperdata then
				local PROTOTYPER_TAGS = { "prototyper_drawing" }
				local pos = self.inst:GetPosition()
				prototypers = TheSim:FindEntities(pos.x, pos.y, pos.z, (TUNING.WAROLINE_DRAWING_DISTANCE + 0.5), PROTOTYPER_TAGS, self.exclude_tags)
			else
				--print("Builder.ReloadDrawingUnlocks: Using external prototyper data for logic...")
				prototypers = useprototyperdata
			end
			
			for _,v in pairs(unknown_drawings) do
				-- Now check if we have any prototyper in the area which fits requirements of recipe that is about to be deleted
				-- Unlearn only recipes which do not have a matching prototyper
				local usable_prototyper = nil
				
				for i,prototyper in ipairs(prototypers) do
					if table.contains(TUNING.SKETCHBOOK_WAROLINE.PROTOTYPERS[v], prototyper.prefab) then
						--print("Found matching prototyper for recipe " .. v .. " -> with prefab: " .. prototyper.prefab)
						usable_prototyper = prototyper
					end
				end
				
				if not usable_prototyper then
					--print("#4 Removing unknown drawing: " .. v)
					self:RemoveRecipe(v)
				end
			end
		end
	end
	
	-- Reload drawing unlock triggers
	local _MakeRecipeAtPoint = builder.MakeRecipeAtPoint
	builder.MakeRecipeAtPoint = function(self, recipe, pt, rot, skin)
		self:ReloadDrawingUnlocks()
		_MakeRecipeAtPoint(self, recipe, pt, rot, skin)
	end
	
	-- End of new functions
	
	local _DoBuild = builder.DoBuild
	builder.DoBuild = function( self, recname, pt, rotation, skin )
		local recipe = GLOBAL.GetValidRecipe(recname)

		--print("Builder: Running DoBuild...")

		-- Do we know this drawing, and if we don't - are we close enough to the prototyper?
		local can_draw = false
		if recipe ~= nil and recipe.isdrawing and TUNING.SKETCHBOOK_WAROLINE.PROTOTYPERS[recname] then
			can_draw = self:TestCanDrawInCurrentPos(recname)
		elseif recipe ~= nil and recipe.isdrawing and not TUNING.SKETCHBOOK_WAROLINE.PROTOTYPERS[recname] then -- drawings unlocked by default
			can_draw = true
		end
		
		local isfreebuildmode = self.freebuildmode or false
		
		--self.inst.components.talker:Say("DoBuild")
		
		if recipe ~= nil and recipe.isdrawing and self.inst and self.inst.components.hunger then
			--print("Builder: Recipe is drawing...")
			for k,v in pairs(recipe.character_ingredients) do
				local AMOUNT = math.max(1, RoundBiasedUp(v.amount * self.ingredientmod))
				
				if v.type == CHARACTER_INGREDIENT.HUNGER then
					--print("Builder: Recipe ingredient is hunger...")
					if AMOUNT and AMOUNT <= self.inst.components.hunger.current and (can_draw or isfreebuildmode) then
						--print("Builder: Cost is less or equal to our current hunger...")
						
						self.inst:PushEvent("consumedrawingcost", { rec = recipe })
						
						self:LearnNewDrawing(recname)
						
						local prod = SpawnPrefab(recipe.product, recipe.chooseskin or skin, nil, self.inst.userid) or nil
						if prod ~= nil then
							--print("Builder: Product spawned!")
							
							-- I'm doing hunger delta AFTER spawning the drawing, because for some godforsaken reason
							-- SpawnPrefab likes to fail at times with no warning. And no, I have no idea why the hell it fails.
							-- It just does. So here's at least a tiny bit of leeway for the player.
							-- DO NOT consume hunger cost before we spawn an item. No harm done even if SpawnPrefab fucking fails.
							self.inst.components.hunger:DoDelta(-AMOUNT)
							self.inst:PushEvent("refreshcrafting")
							
							pt = pt or self.inst:GetPosition()
							prod.Transform:SetPosition(pt:Get())
							prod.Transform:SetRotation(rotation or 0)
							self.inst:PushEvent("buildstructure", { item = prod, recipe = recipe, skin = skin })
							prod:PushEvent("onbuilt", { builder = self.inst, pos = pt })
							
							if self.inst.components.warolineartist then
								--print("Builder: trying to bind sketch on craft to Waroline")
								self.inst.components.warolineartist:LinkDrawing(prod)
							end
							
							GLOBAL.ProfileStatsAdd("build_"..prod.prefab)
							GLOBAL.NotifyPlayerProgress("TotalItemsCrafted", 1, self.inst)

							if self.onBuild ~= nil then
								self.onBuild(self.inst, prod)
							end

							prod:OnBuilt(self.inst)

							return true
						end
					else
						if self:IsBuildBuffered(recname) then
							for k,v in pairs(self.buffered_builds) do
								if k and k == recname then
									self.buffered_builds[k] = nil
								end
							end
						end
						self.inst:PushEvent("refreshcrafting")
						if can_draw or isfreebuildmode then
							return false, "DRAWING_TOOHUNGRY"
						else
							return false, "DRAWING_TOOFARAWAY"
						end
					end
				end
			end
		end
		return _DoBuild( self, recname, pt, rotation, skin )
	end
end
AddComponentPostInit("builder", BuilderPostInit)

-- Reset recipes on deployment/placement cancellation, also trick playercontroller so that placer does not get cancelled on component update
AddComponentPostInit("playercontroller", function(self)
	
	-- Fix for players with Movement Prediction enabled
	local _RemoteMakeRecipeAtPoint = self.RemoteMakeRecipeAtPoint
	self.RemoteMakeRecipeAtPoint = function(self, recipe, pt, rot, skin)
		if self.placer_recipe ~= nil and self.placer_recipe.isdrawing then
			local platform, pos_x, pos_z = self:GetPlatformRelativePosition(pt.x, pt.z)
            SendRPCToServer(RPC.MakeRecipeAtPoint, recipe.rpc_id, pos_x, pos_z, rot, skin_index, platform, platform ~= nil)
		else
			_RemoteMakeRecipeAtPoint(self, recipe, pt, rot, skin)
		end
	end

	self.ForceCancelPlacement = function(self)
		if self.handler ~= nil then
            self:CancelPlacement(true)
            self:CancelDeployPlacement()
            self:CancelAOETargeting()

            if self.reticule ~= nil and self.reticule.reticule ~= nil then
                self.reticule.reticule:Hide()
            end

            if self.terraformer ~= nil then
                self.terraformer:Remove()
                self.terraformer = nil
            end

            self.LMBaction, self.RMBaction = nil, nil
            self.controller_target = nil
            self.controller_attack_target = nil
            self.controller_attack_target_ally_cd = nil
            if self.highlight_guy ~= nil and self.highlight_guy:IsValid() and self.highlight_guy.components.highlight ~= nil then
                self.highlight_guy.components.highlight:UnHighlight()
            end
            self.highlight_guy = nil

            if not ishudblocking and self.inst.HUD ~= nil and self.inst.HUD:IsVisible() and not self.inst.HUD:HasInputFocus() then
                self:DoCameraControl()
            end
        end
	end

	local _CancelPlacement = self.CancelPlacement
	self.CancelPlacement = function(self, cache)
		--print("CancelPlacement")
		local isfreebuildmode = self.inst.components.builder and self.inst.components.builder.freebuildmode or false
		
		if self.placer_recipe ~= nil and self.placer_recipe.isdrawing and not isfreebuildmode then
			local inst = self.inst
			local prefab = self.placer_recipe.name
			
			if inst.bufferedaction == nil then
				local PROTOTYPER_TAGS = { "prototyper_drawing" }
				local prototyper = GLOBAL.FindEntity(inst, (TUNING.WAROLINE_DRAWING_DISTANCE + 0.5), nil, PROTOTYPER_TAGS)
				
				if prototyper and inst.components.talker and prefab then
					if inst.components.builder and not inst.components.builder:KnowsRecipe(prefab) or
					inst.replica.builder and not inst.replica.builder:KnowsRecipe(prefab) then
					
						inst.components.talker:Say("Oops! Let me try that again...")
					end
					
				elseif not prototyper and inst.components.talker and prefab then
					if inst.components.builder and not inst.components.builder:KnowsRecipe(prefab) or
					inst.replica.builder and not inst.replica.builder:KnowsRecipe(prefab) then
						
						inst.components.talker:Say("I cannot see my art subject clearly from here...")
					end
				end
			
			end
				
			if inst.components.builder then
				for prefab,craftingdata in pairs(TUNING.SKETCHBOOK_WAROLINE.PREFABS) do
					inst.components.builder.buffered_builds[prefab] = nil
				end
				
			elseif inst.replica.builder then
				--self.inst.components.talker:Say("CancelPlacement")
				for prefab,craftingdata in pairs(TUNING.SKETCHBOOK_WAROLINE.PREFABS) do
					inst.replica.builder:SetIsBuildBuffered(prefab, false)
				end
			end
		end
		_CancelPlacement(self, cache)
	end
	
	local _StartBuildPlacementMode = self.StartBuildPlacementMode
	self.StartBuildPlacementMode = function(self, recipe, skin)
		--print("StartPlacement")
		return _StartBuildPlacementMode(self, recipe, skin)
	end
	
	local _OnUpdate = self.OnUpdate
	self.OnUpdate = function(self, dt)
		--print("OnUpdate")
		self.predictionsent = false
		
		if self.placer ~= nil and self.placer_recipe ~= nil and TUNING.SKETCHBOOK_WAROLINE.PREFABS[self.placer_recipe.name] then
			local _placer = self.placer
			self.placer = nil
			_OnUpdate(self, dt)
			self.placer = _placer
		else
			return _OnUpdate(self, dt)
		end
	end
	
	local _GetHoverTextOverride = self.GetHoverTextOverride
	self.GetHoverTextOverride = function(self)
		if self.placer_recipe ~= nil and self.placer_recipe.isdrawing then
			return "Draw "..(STRINGS.NAMES[string.upper(self.placer_recipe.name)])
		else
			return _GetHoverTextOverride(self)
		end
	end
end)

-- PROTOTYPERS IMPLEMENTATION

AddComponentPostInit("builder", function(self)
	
	local _KR = self.KnowsRecipe
	self.KnowsRecipe = function(self, recname)
		local recipe = GetValidRecipe(recname)
		if recipe == nil then
			return false
		end
		local has_tech = true
		if not self.freebuildmode then
			for i, v in ipairs(TechTree.AVAILABLE_TECH) do
				-- fix for CELESTIAL
				local val = self[string.lower(v).."_bonus"] ~= nil and self[string.lower(v).."_bonus"] or 0
				-- fix #2
				local rec_level = recipe.level[v] ~= nil and recipe.level[v] or 999
				
				--print("Recipe level: " .. rec_level)
				--print("Name of current v: " .. (string.lower(v)))
				--print("---")
				
				if rec_level > val then
					has_tech = false
					break
				end
			end
		end
		return (has_tech or table.contains(self.recipes, recname) or self.station_recipes[recname]) and
			(recipe.builder_tag == nil or self.inst:HasTag(recipe.builder_tag))
	end
	
	local _ETT = self.EvaluateTechTrees
	local _DRAWING_ETT = function(self, ents)
		local old_accessible_tech_trees = deepcopy(self.accessible_tech_trees or TECH.NONE)
		local old_station_recipes = self.station_recipes
		local old_prototyper = self.current_prototyper
		self.current_prototyper = nil
		self.station_recipes = {}

		local prototyper_active = false
		for i, v in ipairs(ents) do
			if v.components.prototyper ~= nil and (v.components.prototyper.restrictedtag == nil or self.inst:HasTag(v.components.prototyper.restrictedtag)) then
				if not prototyper_active then
					--activate the first machine in the list. This will be the one you're closest to.
					v.components.prototyper:TurnOn(self.inst)
					self.accessible_tech_trees = v.components.prototyper:GetTechTrees()
					
					if v.components.craftingstation ~= nil then
						local recs = v.components.craftingstation:GetRecipes(self.inst)
						for _, recname in ipairs(recs) do
							local recipe = GetValidRecipe(recname)
							if recipe ~= nil and recipe.nounlock then
								--only nounlock recipes can be unlocked via crafting station
								self.station_recipes[recname] = true
							end
						end
					end                    

					prototyper_active = true
					self.current_prototyper = v
				else
					--you've already activated a machine. Turn all the other machines off.
					v.components.prototyper:TurnOff(self.inst)
				end
			end
		end

		--add any character specific bonuses to your current tech levels.
		if not prototyper_active then
			for i, v in ipairs(TechTree.AVAILABLE_TECH) do
				self.accessible_tech_trees[v] = self[string.lower(v).."_bonus"] or 0
			end
		else
			for i, v in ipairs(TechTree.BONUS_TECH) do
				self.accessible_tech_trees[v] = self.accessible_tech_trees[v] + (self[string.lower(v).."_bonus"] or 0)
			end
		end

		if old_prototyper ~= nil and
			old_prototyper ~= self.current_prototyper and
			old_prototyper.components.prototyper ~= nil and
			old_prototyper.entity:IsValid() then
			old_prototyper.components.prototyper:TurnOff(self.inst)
		end

		local trees_changed = false

		for recname, _ in pairs(self.station_recipes) do
			if old_station_recipes[recname] then
				old_station_recipes[recname] = nil
			else
				self.inst.replica.builder:AddRecipe(recname)
				trees_changed = true
			end
		end

		if next(old_station_recipes) ~= nil then
			for recname, _ in pairs(old_station_recipes) do
				self.inst.replica.builder:RemoveRecipe(recname)
			end
			trees_changed = true
		end

		if not trees_changed then
			for k, v in pairs(old_accessible_tech_trees) do
				if v ~= self.accessible_tech_trees[k] then 
					trees_changed = true
					break
				end
			end
			if not trees_changed then
				for k, v in pairs(self.accessible_tech_trees) do
					if v ~= old_accessible_tech_trees[k] then 
						trees_changed = true
						break
					end
				end
			end
		end

		if trees_changed then
			self.inst:PushEvent("techtreechange", { level = self.accessible_tech_trees })
			self.inst.replica.builder:SetTechTrees(self.accessible_tech_trees)
		end
	end
	
	
	self.EvaluateTechTrees = function(self)
		_ETT(self)
		
		if self.inst:HasTag("sketchbook_user") then
			-- Prototypers are extremely resource-intensive - check if we don't have all sketch recipes enabled before continuing
			local continue_sketch_prototyper_search = false
			for k,v in pairs(TUNING.SKETCHBOOK_WAROLINE.PROTOTYPERS) do
				if k ~= nil and not self:KnowsRecipe(k) then
					--print("Recipe for the found prototyper is NOT known yet: " .. k)
					continue_sketch_prototyper_search = true
					break
				end
			end
			
			if not continue_sketch_prototyper_search then
				--print("This player already knows all in-game drawing recipes. Skipping drawing prototyper search...")
				return
			end
		
			local PROTOTYPER_TAGS = { "prototyper_drawing" }
			local pos = self.inst:GetPosition()
			local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, TUNING.WAROLINE_DRAWING_DISTANCE, PROTOTYPER_TAGS, self.exclude_tags)
			if ents ~= nil and #ents > 0 and self.inst then
				-- Again - to make things less resource-intensive -> check first and activate the first unknown prototyper
				local usable_prototypers = {}
				for i,v in ipairs(ents) do
					--print("Evaluating drawing prototypers: " .. (v.prefab))
					--print("Reverse prototypers table returned: " .. (TUNING.SKETCHBOOK_WAROLINE.SREPYTOTORP[v.prefab]))
					if v and v.prefab ~= nil and TUNING.SKETCHBOOK_WAROLINE.SREPYTOTORP[v.prefab] and not self:KnowsRecipe(TUNING.SKETCHBOOK_WAROLINE.SREPYTOTORP[v.prefab]) then
						table.insert(usable_prototypers, v)
						break
					end
				end
				--print("Number of usable drawing prototypers: " .. (#usable_prototypers))
				if #usable_prototypers > 0 then
					_DRAWING_ETT(self, usable_prototypers)
				end
			end
		end
		
	end
end)

local b_rep2 = require("components/builder_replica")
local R_KR = b_rep2.KnowsRecipe
b_rep2.KnowsRecipe = function(self, recipename)

	if self.inst.components.builder ~= nil then
        return self.inst.components.builder:KnowsRecipe(recipename)
    elseif self.classified ~= nil then
        local recipe = GetValidRecipe(recipename)
        if recipe ~= nil then
            local has_tech = true
			
            if not self.classified.isfreebuildmode:value() then
                for i, v in ipairs(TechTree.AVAILABLE_TECH) do
                    local bonus = (self.classified[string.lower(v).."bonus"]) ~= nil and (self.classified[string.lower(v).."bonus"]):value() or 0
                    local rec_level = recipe.level[v] ~= nil and recipe.level[v] or 999
					if rec_level > bonus then
                        has_tech = false
                        break
                    end
                end
            end
            return (has_tech or (self.classified.recipes[recipename] ~= nil and
                    self.classified.recipes[recipename]:value())) and
                    (recipe.builder_tag == nil or self.inst:HasTag(recipe.builder_tag))
        end
    end
    return false
	
end

function CreateNewDrawingPrototyper(name, postinit_data)
	local nameStrUpper = string.upper(name)
	local nameStrLower = string.lower(name)

	TECH.NONE[nameStrUpper] = 0

	TECH[nameStrUpper .. "_ONE"] = { [nameStrUpper] = 1 }
	TECH[nameStrUpper .. "_TWO"] = { [nameStrUpper] = 2 }

	for k,v in pairs(GLOBAL.TUNING.PROTOTYPER_TREES) do
		v[nameStrUpper] = 0
	end

	--We define what a [nameStrUpper] prototyping machine grants us access to:
	table.insert(TechTree.AVAILABLE_TECH, nameStrUpper)
	table.insert(TechTree.BONUS_TECH, nameStrUpper)

	GLOBAL.TUNING.PROTOTYPER_TREES[nameStrUpper] = TechTree.Create({
		[nameStrUpper] = 1,
	})
	
	AddComponentPostInit("builder", function(self)
		local _ETT = self.EvaluateTechTrees
		self.EvaluateTechTrees = function(self)
			_ETT(self)
			
			if self.current_prototyper == nil then
				self.accessible_tech_trees[nameStrUpper] = 0
				if self.inst[nameStrLower .. "level"] then
					self.inst[nameStrLower .. "level"]:set(0)
				end
			end
		end
	end)

	-- Clientside
	AddPlayerPostInit(function(inst)
		inst[nameStrLower .. "level"] = GLOBAL.net_tinybyte(inst.GUID, ("p." .. nameStrLower .. "level"), (nameStrLower .. "leveldirty")) -- 0..7
		inst[nameStrLower .. "level"]:set_local(0)
	end)

	local b_rep1 = require("components/builder_replica")
	local _SetTechTrees = b_rep1.SetTechTrees
	b_rep1.SetTechTrees = function(self, techlevels)
		_SetTechTrees(self, techlevels)
		if self.inst[nameStrLower .. "level"] then
			self.inst[nameStrLower .. "level"]:set(techlevels[nameStrUpper] or 0)
		end
	end
	
	-- Postinits
	local function MakePrototyper(inst)
		-- Server
		if GLOBAL.TheWorld.ismastersim and not inst.components.prototyper then
			inst:AddComponent("prototyper")
			if inst:HasTag("prototyper") then
				inst:RemoveTag("prototyper")
			end
			inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES[nameStrUpper]
		end
		-- Client
		inst:AddTag("prototyper_drawing")
		if inst:HasTag("prototyper") then
			inst:RemoveTag("prototyper")
		end
	end
	for k,v in pairs(postinit_data) do 
		if v ~= nil then
			AddPrefabPostInit(v, MakePrototyper)
		end
	end
end
