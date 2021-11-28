-- WarolineArtist handles linking drawings to Waroline and despawn/load

local function OnDespawn(inst)
	--print("WarolineArtist: Running OnDespawn")
	if inst.components.warolineartist and inst.components.warolineartist:CurrentlyHasDrawings() then
		-- "nil" will force all drawings despawn
		inst.components.warolineartist:DespawnDrawing(false, nil)
	end
end

local WarolineArtist = Class(function(self, inst)
    self.inst = inst
	
	self.sketch_limit = TUNING.WAROLINE_SKETCH_LIMIT
	
	-- links to entities
	self.waroline_links = {
		[1] = nil,
		[2] = nil,
		[3] = nil,
	}
	
	self.drawing_savestrings = {
		[1] = nil,
		[2] = nil,
		[3] = nil,
	}
	
	self.inst.OnDespawn = OnDespawn
end)

function WarolineArtist:CreateSpawnFX(fx_type, ent)
	local fx_prefab = fx_type == "migration" and "spawn_fx_medium" or "small_puff"
	local size = fx_type == "migration" and ent.components.warolinedrawing:GetMigrationFXSize() or ent.components.warolinedrawing:GetDespawnFXSize() 
	
	local fx = SpawnPrefab(fx_prefab)
	if fx ~= nil then
		if not ent.components.equippable or ent.components.equippable and not ent.components.equippable:IsEquipped() then
			fx.Transform:SetPosition(ent.Transform:GetWorldPosition())
			fx.Transform:SetScale(size, size, size)
		end
	end
end

function WarolineArtist:GetOldestDrawing()
	if self.waroline_links[1] ~= nil then
		return self.waroline_links[1]
	elseif self.waroline_links[2] ~= nil then
		return self.waroline_links[2]
	elseif self.waroline_links[3] ~= nil then
		return self.waroline_links[3]
	end
end

function WarolineArtist:AddNewDrawing(drawing)
	if self.waroline_links[1] == nil then
		self.waroline_links[1] = drawing
	elseif self.waroline_links[2] == nil then
		self.waroline_links[2] = drawing
	elseif self.waroline_links[3] == nil then
		self.waroline_links[3] = drawing
	end
end

local function sort_drawings(waroline_links)
	local _drawings = {
		[1] = nil,
		[2] = nil,
		[3] = nil
	}
	
	for k,v in pairs(waroline_links) do
		if v ~= nil then
			if _drawings[1] == nil then
				--print("assigning drawing " .. v.prefab .. " to id 1")
				_drawings[1] = v
			elseif _drawings[2] == nil then
				--print("assigning drawing " .. v.prefab .. " to id 2")
				_drawings[2] = v
			else
				--print("assigning drawing " .. v.prefab .. " to id 3")
				_drawings[3] = v
			end
		end
	end
	
	return _drawings
end

function WarolineArtist:RemoveDrawingDirty(drawing)
	--print("running removedrawingdirty")
	if self.waroline_links[1] == drawing then
		self.waroline_links[1] = nil
	elseif self.waroline_links[2] == drawing then
		self.waroline_links[2] = nil
	elseif self.waroline_links[3] == drawing then
		self.waroline_links[3] = nil
	end
	
	self.waroline_links = sort_drawings(self.waroline_links)
end

function WarolineArtist:HasDrawing(prefab)
	local hasdrawing = false
	for k,v in pairs(self.waroline_links) do
		if v ~= nil and v.prefab ~= nil and v.prefab == prefab then
			hasdrawing = true
			break
		end
	end
	return hasdrawing
end

function WarolineArtist:HasDrawingEntity(ent)
	local hasdrawing = false
	for k,v in pairs(self.waroline_links) do
		if v ~= nil and v == ent then
			hasdrawing = true
			break
		end
	end
	return hasdrawing
end

function WarolineArtist:CurrentlyHasDrawings()
	local count = 0
	for k,v in pairs(self.waroline_links) do
		if v ~= nil and v.prefab ~= nil then
			count = count + 1
		end
	end
	return count > 0 and true or false
end

function WarolineArtist:GetNumDrawings()
	local count = 0
	for k,v in pairs(self.waroline_links) do
		if v ~= nil and v.prefab ~= nil then
			count = count + 1
		end
	end
	return count
end

function WarolineArtist:GetDrawings(prefab)
	if not prefab then
		local drawings = nil
		for k,v in pairs(self.waroline_links) do
			if v ~= nil then
				if drawings == nil then
					drawings = {}
				end
				table.insert(drawings, v)
			end
		end
		return drawings
	else
		local drawings = nil
		for k,v in pairs(self.waroline_links) do
			if v ~= nil and v.prefab ~= nil and v.prefab == prefab then
				if drawings == nil then
					drawings = {}
				end
				table.insert(drawings, v)
			end
		end
		return drawings
	end
end

function WarolineArtist:DiscardDrawing(drawing)
	--print("WarolineArtist: Running DiscardDrawing")
	local despawn_success = self:DespawnDrawing(true, drawing)
end

local function GenerateDrawingSaveString(ent)
	if ent ~= nil then
		local prefab = ent.prefab
		
		local currentfuel = nil
		if ent.components.fueled then
			currentfuel = ent.components.fueled.currentfuel
		end
		
		local currentuses = nil
		if ent.components.finiteuses then
			currentuses = ent.components.finiteuses:GetUses()
		end
		
		local hat = nil
		if ent.components.inventory and ent.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) ~= nil then
			--print("entity has a hat")
			local _hat = ent.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
			local hat_prefab = _hat.prefab
			
			local hat_fueled = nil
			if _hat.components.fueled then
				hat_fueled = _hat.components.fueled.currentfuel
			end
			
			local hat_finiteuses = nil
			if _hat.components.finiteuses then
				hat_finiteuses = _hat.components.finiteuses:GetUses()
			end
			
			local hat_armor = nil
			if _hat.components.armor then
				hat_armor = _hat.components.armor.condition
			end
			
			local hat_perishtime = nil
			if _hat.components.perishable then
				hat_perishtime = _hat.components.perishable:GetPercent()
			end
			
			local hat_skinname = nil
			if _hat:GetSkinName() ~= nil then
				hat_skinname = _hat:GetSkinName()
			end
			
			hat = hat_prefab
			
			if hat_fueled ~= nil then
				hat = hat .. ";" .. hat_fueled
			else
				hat = hat .. ";!"
			end
			
			if hat_finiteuses ~= nil then
				hat = hat .. ";" .. hat_finiteuses
			else
				hat = hat .. ";!"
			end
			
			if hat_armor ~= nil then
				hat = hat .. ";" .. hat_armor
			else
				hat = hat .. ";!"
			end
			
			if hat_perishtime ~= nil then
				hat = hat .. ";" .. hat_perishtime
			else
				hat = hat .. ";!"
			end
			
			if hat_skinname ~= nil then
				hat = hat .. ";" .. hat_skinname
			else
				hat = hat .. ";!"
			end
		end
		
		local first_invslot_item = nil
		if ent.components.inventory ~= nil then
			local item = ent.components.inventory:FindItem(function(item) return item ~= nil end)
			if item then
				local item_prefab = item.prefab
				
				local item_stackable = nil
				if item.components.stackable then
					item_stackable = item.components.stackable.stacksize
				end
				
				local item_perishable = nil
				if item.components.perishable then
					item_perishable = item.components.perishable:GetPercent()
				end
				
				first_invslot_item = item_prefab
				
				if item_stackable then
					first_invslot_item = first_invslot_item .. ";" .. item_stackable
				else
					first_invslot_item = first_invslot_item .. ";!"
				end
				
				if item_perishable then
					first_invslot_item = first_invslot_item .. ";" .. item_perishable
				else
					first_invslot_item = first_invslot_item .. ";!"
				end
			end
		end
		
		-- Concatenate save string
		local savestr = "!"
		savestr = prefab
		
		if currentfuel then
			savestr = savestr .. ";" .. currentfuel
		else
			savestr = savestr .. ";" .. "!"
		end
		
		if currentuses then
			savestr = savestr .. ";" .. currentuses
		else
			savestr = savestr .. ";" .. "!"
		end
		
		if hat then
			savestr = savestr .. ";" .. hat
		else
			savestr = savestr .. ";" .. "!;!;!;!;!;!"
		end
		
		if first_invslot_item then
			savestr = savestr .. ";" .. first_invslot_item
		else
			savestr = savestr .. ";" .. "!;!;!"
		end
		
		-- prefab;fueled_val;finiteuses_val;hat_prefab;hat_fueled_val;hat_finiteuses_val;hat_armor_val;hat_perishtime_val;hat_skinname_val;invitem_prefab;invitem_stackable_val;invitem_perishable_val
		
		--[[
			[1]prefab
			[2]fueled_val
			[3]finiteuses_val
			[4]hat_prefab
			[5]hat_fueled_val
			[6]hat_finiteuses_val
			[7]hat_armor_val
			[8]hat_perishtime_val
			[9]hat_skinname_val
			[10]invitem_prefab
			[11]invitem_stackable_val
			[12]invitem_perishable_val
		]]---
		
		--print("WAROLINEDRAWING: GENERATING SAVESTRING: " .. savestr)
		
		return savestr
	end
end

function WarolineArtist:ClearSaveData()
	self.drawing_savestrings = {
		[1] = nil,
		[2] = nil,
		[3] = nil,
	}
end

function WarolineArtist:AddSaveDataForDrawing(ent)
	--print("WA:AddSaveDataForDrawing: Adding SaveData for drawing '" .. ent.prefab .. "'...")
	local savestrings_have_ent = false
	
	for k,v in pairs(self.drawing_savestrings) do
		if v ~= nil and v == ent then
			--print("WA:AddSaveDataForDrawing: SaveStrings already contain this drawing!")
			v = GenerateDrawingSaveString(ent)
			savestrings_have_ent = true
			break
		end
	end
	
	if not savestrings_have_ent then
		if self.drawing_savestrings[1] == nil then
			--print("WA:AddSaveDataForDrawing: Savestring nr 1: " .. ent.prefab)
			self.drawing_savestrings[1] = GenerateDrawingSaveString(ent)
		elseif self.drawing_savestrings[2] == nil then
			--print("WA:AddSaveDataForDrawing: Savestring nr 2: " .. ent.prefab)
			self.drawing_savestrings[2] = GenerateDrawingSaveString(ent)
		elseif self.drawing_savestrings[3] == nil then
			--print("WA:AddSaveDataForDrawing: Savestring nr 3: " .. ent.prefab)
			self.drawing_savestrings[3] = GenerateDrawingSaveString(ent)
		end
	end
end

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

function WarolineArtist:LinkDrawing(drawing)
	if not drawing or drawing and not drawing:IsValid() or self:HasDrawingEntity(drawing) then
		return
	end
	
	--print("WarolineArtist: Linking drawing " .. drawing.prefab .. " to artist " .. self.inst:GetDisplayName())
	
	-- Firstly, remove old drawing if there is one (and we are at our limit)
	if self:CurrentlyHasDrawings() and self:GetNumDrawings() >= self.sketch_limit then
		local old_drawing = self:GetOldestDrawing()
		self:DiscardDrawing(old_drawing)
	end
	
	-- Now assign new drawing
	self:CreateSpawnFX("migration", drawing)
	
	self:AddNewDrawing(drawing)
	
	if drawing.components.named then
		local original_name = STRINGS.NAMES[string.upper(drawing.prefab)]
		local displayname = (self.inst:GetDisplayName()) .. "'s"
		local name = string.gsub(original_name, "Sketch", displayname)
		drawing.components.named:SetName(name)
	end
	
	-- Bind "fighters" to listen for artist's attacks and being attacked
	if drawing.components.combat and drawing.components.warolinedrawing and drawing.components.warolinedrawing:IsFighter() then
		local function OnNewArtistTarget(drawing, data)
			if data and data.target then
				drawing.components.combat:SetTarget(data.target)
			end
		end
		drawing:ListenForEvent("doattack", OnNewArtistTarget, self.inst)
		
		local function OnArtistAttacked(drawing, data)
			if data and data.attacker then
				drawing.components.combat:SetTarget(data.attacker)
			end
		end
		drawing:ListenForEvent("attacked", OnArtistAttacked, self.inst)
		
		-- Look out for dangerous creatures near the artist and yourself
		drawing:DoPeriodicTask(1, function(drawing)
			if drawing.components.warolinedrawing and drawing.components.warolinedrawing:GetArtist() ~= nil and drawing.components.combat and not drawing.components.combat.target then
				local artist = drawing.components.warolinedrawing:GetArtist()
				
				local x, y, z = artist.Transform:GetWorldPosition()
				local EXCLUDE_TAGS = { "INLIMBO", "notarget", "noattack", "invisible", "playerghost" }
				local MUST_TAGS = { "hostile", "_combat" }
				local range = 5
				local ents = TheSim:FindEntities(x, y, z, range, MUST_TAGS, EXCLUDE_TAGS)
				
				if #ents > 0 then
					for i, v in ipairs(ents) do
						if v and v.components.combat and v.components.combat.target ~= nil and 
							(v.components.combat.target:HasTag("player") or v.components.combat.target == drawing or
							v.components.combat.target.components.follower ~= nil and
							v.components.combat.target.components.follower.leader ~= nil and v.components.combat.target.components.follower.leader:HasTag("player")) then
								drawing.components.combat:SetTarget(v)
								break
						end
					end
				end
			else
				-- Drop targets after reaching certain distance from the artist
				if drawing.components.warolinedrawing and drawing.components.warolinedrawing:GetArtist() ~= nil and drawing.components.combat and drawing.components.combat.target then
					local target = drawing.components.combat.target
					local artist = drawing.components.warolinedrawing:GetArtist()
					
					if math.sqrt(target:GetDistanceSqToInst(artist)) > 20 then
						drawing.components.combat:DropTarget(false)
					end
				end
			end
		end)
	end
	
	-- Drawing creatures should teleport near player if player embarks aboard a boat
	if drawing.components.warolinedrawing and drawing.components.warolinedrawing:IsCritter() then
		local inst = self.inst
		inst:ListenForEvent("done_embark_movement", function(artist)
			local _drawings = artist.components.warolineartist and artist.components.warolineartist:GetDrawings(nil)
			if _drawings then
				for i,drawing in ipairs(_drawings) do
					if drawing and drawing.components.warolinedrawing and drawing.components.warolinedrawing:IsCritter() then
						local pt = artist:GetPosition()
						local spawn_pt = GetSpawnPoint(pt)
						if spawn_pt then
							if drawing.entity and drawing.entity:IsVisible() and not drawing:HasTag("INLIMBO") then
								artist.components.warolineartist:CreateSpawnFX("migration", drawing)
							end
							drawing.Physics:Teleport(spawn_pt:Get())
							
							drawing:DoTaskInTime(0.1, function(drawing)
								if drawing.entity and drawing.entity:IsVisible() and not drawing:HasTag("INLIMBO") then
									artist.components.warolineartist:CreateSpawnFX("migration", drawing)
								end
							end)
							
							-- Swap brains - RunAway is broken on boats, so make followers not have this node
							-- Boat brains also have slightly shorter player follow ranges
							local x, y, z = drawing.Transform:GetWorldPosition()
							local is_boat = TheWorld.Map:GetPlatformAtPoint(x, z)
							
							local brain_name = (string.gsub(drawing.prefab, "_", "")) .. "brain"
							
							local brain_land = require("brains/" .. brain_name)
							local brain_boat = require("brains/" .. brain_name .. "_boat")
							
							if is_boat and drawing.brain then
								--print("WarolineArtist: Swapping brain of " .. drawing.prefab .. " to brain: " .. brain_name .. "_boat")
								drawing:SetBrain(brain_boat)
							elseif not is_boat and drawing.brain then
								--print("WarolineArtist: Swapping brain of " .. drawing.prefab .. " to brain: " .. brain_name)
								drawing:SetBrain(brain_land)
							end
						end
					end
				end
			end
		end)
	end
	
	if not drawing.components.warolinedrawing then
		drawing:AddComponent("warolinedrawing")
	end
	drawing.components.warolinedrawing:AssignArtist(self.inst)
end

function WarolineArtist:DespawnDrawing(force, drawing)
	if not self:CurrentlyHasDrawings() then
		return false
	end
	
	if drawing and not self:HasDrawingEntity(drawing) then
		return false
	end
	
	if drawing and drawing.components.warolinedrawing and drawing.components.warolinedrawing.protectedmode then
		return false
	end
	
	-- Despawn the chosen drawing or, if we don't have a despawn target declared, go through all drawings
	local arts = {}
	if drawing ~= nil then
		table.insert(arts, drawing)
	else
		arts = self:GetDrawings(nil)
	end
	
	-- Clear stored savedata before performing this action
	self:ClearSaveData()
	
	for i,art in ipairs(arts) do
		-- Despawn a drawing that is not in our inventory/backpack unless forced
		if art ~= nil then
			--print("WarolineArtist: Running DespawnDrawing")
			--print("Despawn function iterates through drawings... Currently: '" .. art.prefab .."'")
			
			if art:HasTag("irreplaceable") then
				art:RemoveTag("irreplaceable")
			end
			
			if art and art:IsValid() then
				-- do this to prevent buffer overflow, because drawing will try to remove itself from artist on entity removal
				self:RemoveDrawingDirty(art)
				
				-- SAVEDATA
				self:AddSaveDataForDrawing(art)
				
				if not art.components.rideable then
					if not force then
						self:CreateSpawnFX("migration", art)
					else
						-- since we have a monkey on our list now - drop entire inventory when force-despawned
						if art.components.inventory and (art.components.inventory:NumItems() > 0 or art.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)) then
							art.components.inventory:DropEverything()
						end
						
						-- in case we're fueled - check if fuel did not reach 0 first - if it did, skip despawn FX
						if art.components.fueled and art.components.fueled.currentfuel and art.components.fueled.currentfuel <= 0 then
							--return true
						else
							self:CreateSpawnFX("despawn", art)
						end
					end
					
					art.removed_by_artist = true -- this gets checked in WarolineDrawing component
					art:Remove()
					if art then
						art:DoTaskInTime(0, art.Remove)
					end
				end
				
				-- Ridden animals need to be handled differently from regular items
				if art.components.rideable then
					if art.components.rideable:IsBeingRidden() then
						
						art.components.rideable:Buck(true)
						art.components.rideable.canride = false
						
						if art.brain then
							art.brain = nil
						end
						
						art:DoTaskInTime(0.85, function(art)
							if not force then
								self:CreateSpawnFX("migration", art)
							else
								self:CreateSpawnFX("despawn", art)
							end
							art.removed_by_artist = true
							art:Remove()
						end)
						
					else
						self:CreateSpawnFX("despawn", art)
						art.removed_by_artist = true
						art:Remove()
						if art then
							art:DoTaskInTime(0, art.Remove)
						end
					end
				end
			end
			
			-- Some drawings may be buffered in the crafting menu - uncraft them
			if self.inst.components.builder then
				local builder = self.inst.components.builder
				for prefab,craftingdata in pairs(TUNING.SKETCHBOOK_WAROLINE.PREFABS) do
					if builder:IsBuildBuffered(prefab) then
						for k,v in pairs(builder.buffered_builds) do
							if k and k == prefab then
								builder.buffered_builds[prefab] = nil
							end
						end
					end
				end
			end
			
		end
	end
	
	return true
end

function WarolineArtist:OnSave()
	-- This will run only when we have drawings - i.e. we did not despawn, but the game was saved
	if self:CurrentlyHasDrawings() then
		self:ClearSaveData()
	
		for k,v in pairs(self.waroline_links) do
			if v ~= nil then
				self:AddSaveDataForDrawing(v)
			end
		end
	end
	
	return self.drawing_savestrings
end

function WarolineArtist:SpawnDrawingFromData(prefab, fuel, uses, hat, inv, is_legacy)
	--print("WarolineArtist: Launching SpawnDrawingFromData...")
	if prefab then
		local pt = self.inst:GetPosition()
		local spawn_pt = GetSpawnPoint(pt)
		if spawn_pt ~= nil then
			--print("WarolineArtist: Spawning drawing from saved data: " .. prefab .. " for player: " .. self.inst.userid)
			
			local drawing = SpawnPrefab(prefab)
			
			-- SpawnPrefab failed? retry...
			if drawing == nil then
				drawing = SpawnPrefab(prefab)
			end
			
			if drawing ~= nil then
				drawing.Physics:Teleport(spawn_pt:Get())
				self:LinkDrawing(drawing)
				
				if fuel and drawing.components.fueled then
					drawing.components.fueled.currentfuel = fuel
					drawing:PushEvent("percentusedchange", {percent = drawing.components.fueled:GetPercent()})
				end
				
				if uses and drawing.components.finiteuses then
					drawing.components.finiteuses:SetUses(uses)
				end
				
				-- Item spawning creates duplicates if we don't immediately give them to our target...
				if is_legacy and hat and drawing.components.inventory then
					local item = SpawnSaveRecord(hat)
					drawing.components.inventory:Equip(item)
					
				elseif hat and drawing.components.inventory then
				
					if hat.skinname ~= nil then
						drawing.components.inventory:Equip(SpawnPrefab(hat.prefab, hat.skinname, nil, self.inst.userid))
					else
						drawing.components.inventory:Equip(SpawnPrefab(hat.prefab))
					end
					
					local _hat = drawing.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
					
					if _hat then
						if hat.fuel and _hat.components.fueled then
							_hat.components.fueled.currentfuel = hat.fuel
							_hat:PushEvent("percentusedchange", {percent = _hat.components.fueled:GetPercent()})
						end
						if hat.uses and _hat.components.finiteuses then
							_hat.components.finiteuses:SetUses(hat.uses)
						end
						if hat.armor and _hat.components.armor then
							_hat.components.armor:SetCondition(hat.armor)
						end
						if hat.perishtime and _hat.components.perishable then
							_hat.components.perishable:SetPercent(hat.perishtime)
						end
					end
				end
				
				if is_legacy and inv and drawing.components.inventory then
				
					for k, v in pairs(inv) do
						--print("WarolineArtist: Spawning item: " .. v.prefab)
						local item = SpawnSaveRecord(v)
						drawing.components.inventory:GiveItem(item)
					end
					
				elseif inv and drawing.components.inventory then
					--print("WarolineArtist: Restoring drawing inventory...")
					drawing.components.inventory:GiveItem(SpawnPrefab(inv.prefab))
					
					local _inv = drawing.components.inventory:FindItem(function(item) return item ~= nil end)
					if _inv then
						if inv.stacksize and _inv.components.stackable then
							_inv.components.stackable:SetStackSize(inv.stacksize)
						end
						if inv.perishtime and _inv.components.perishable then
							_inv.components.perishable:SetPercent(inv.perishtime)
						end
					end
				end
				
				self:CreateSpawnFX("migration", drawing)
			else
				-- SpawnPrefab failed AGAIN? Oh well, in that case restore hunger cost to the player.
				-- If they have full hunger - too bad.
				if TUNING.SKETCHBOOK_WAROLINE.PREFABS[prefab] and self.inst and self.inst.components.hunger then
					local delta = TUNING.SKETCHBOOK_WAROLINE.PREFABS[prefab].ingredientvalue
					self.inst.components.hunger:DoDelta(delta)
				end
			end
		else
			--print("WarolineArtist: Failed to get spawn point for our drawing!")
			if TUNING.SKETCHBOOK_WAROLINE.PREFABS[prefab] and self.inst and self.inst.components.hunger then
				local delta = TUNING.SKETCHBOOK_WAROLINE.PREFABS[prefab].ingredientvalue
				self.inst.components.hunger:DoDelta(delta)
			end
		end
	end
end

-- WarolineArtist OnSave/OnLoad behaviour has changed drastically.
-- This function will allow us to support people who had their sketches saved before The Big Rewrite.
function WarolineArtist:OldOnLoad(data)
	if data.waroline_link_prefab ~= nil then
		local userid = self.inst.userid
		TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid] = {}
		TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid].LEGACYDATA = true
		TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid].prefab = data.waroline_link_prefab
		if data.waroline_link_uses then
			TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid].uses = data.waroline_link_uses
		end
		if data.waroline_link_fuel then
			TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid].fuel = data.waroline_link_fuel
		end
		if data.waroline_link_hat_saverecord then
			TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid].hat = data.waroline_link_hat_saverecord
		end
		if data.waroline_link_inv_saverecord and #(data.waroline_link_inv_saverecord) > 0 then
			TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid].inv = data.waroline_link_inv_saverecord
		end
    end
end

function WarolineArtist:OnLoad(data)
	--print("WarolineArtist: Running OnLoad...")
	if data ~= nil and data.waroline_link_prefab ~= nil then
		self:OldOnLoad(data)
		
	elseif data ~= nil then
		local there_are_saved_drawings = false
		for k,v in pairs(data) do
			if v ~= nil then
				there_are_saved_drawings = true
				break
			end
		end
	
		if there_are_saved_drawings then
			local userid = self.inst.userid
			TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid] = {}
			
			local drawing_id = 1
			
			for k,v in pairs(data) do
				if v ~= nil and drawing_id <= self.sketch_limit then
				
					local save_data = {}
					for s in string.gmatch(v, "[^;]+") do
						--print("Loaded string: " .. s)
						table.insert(save_data, s)
					end
					local save_data_parsed = {}
					
					local id = 1
					for x,data in ipairs(save_data) do
						save_data_parsed[id] = data
						id = id + 1
					end
					
					local prefab = save_data_parsed[1] ~= "!" and save_data_parsed[1] or nil
					local fuel = save_data_parsed[2] ~= "!" and tonumber(save_data_parsed[2]) or nil
					local finiteuses = save_data_parsed[3] ~= "!" and tonumber(save_data_parsed[3]) or nil
					
					local hat_prefab = save_data_parsed[4] ~= "!" and save_data_parsed[4] or nil
					local hat_fueled = save_data_parsed[5] ~= "!" and tonumber(save_data_parsed[5]) or nil
					local hat_finiteuses = save_data_parsed[6] ~= "!" and tonumber(save_data_parsed[6]) or nil
					local hat_armor = save_data_parsed[7] ~= "!" and tonumber(save_data_parsed[7]) or nil
					local hat_perishtime = save_data_parsed[8] ~= "!" and tonumber(save_data_parsed[8]) or nil
					local hat_skinname = save_data_parsed[9] ~= "!" and save_data_parsed[9] or nil
					
					local invitem_prefab = save_data_parsed[10] ~= "!" and save_data_parsed[10] or nil
					local invitem_stacksize = save_data_parsed[11] ~= "!" and tonumber(save_data_parsed[11]) or nil
					local invitem_perishtime = save_data_parsed[12] ~= "!" and tonumber(save_data_parsed[12]) or nil
					
					TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id] = {}
					TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].prefab = prefab
					
					if finiteuses then
						TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].uses = finiteuses
					end
					
					if fuel then
						TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].fuel = fuel
					end
					
					if hat_prefab then
						TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat = {}
						TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat.prefab = hat_prefab
						
						if hat_fueled then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat.fuel = hat_fueled
						end
						if hat_finiteuses then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat.uses = hat_finiteuses
						end
						if hat_armor then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat.armor = hat_armor
						end
						if hat_perishtime then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat.perishtime = hat_perishtime
						end
						if hat_skinname then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].hat.skinname = hat_skinname
						end
					end
					
					if invitem_prefab then
						TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].inv = {}
						TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].inv.prefab = invitem_prefab
						if invitem_stacksize then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].inv.stacksize = invitem_stacksize
						end
						if invitem_perishtime then
							TUNING.GLOBAL_SKETCH_ONLOAD_DEPOSITORY[userid][drawing_id].inv.perishtime = invitem_perishtime
						end
					end
					
					drawing_id = drawing_id + 1
				end
			end
		end
    end
end

return WarolineArtist
