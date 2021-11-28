-- This function handles removal of drawings outside of the internal despawn logic between WarolineArtist and WarolineDrawing
local function OnRemovedDrawing(inst, data)
	if inst.removed_by_artist then
		return
	end
	
	if inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) then
		local hat = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
		inst.components.inventory:DropItem(hat)
	end
	
	if data and data.cause and data.cause == "fire" and inst.components.warolinedrawing:GetArtist() ~= nil and inst.components.warolinedrawing:GetArtist().components.talker then
		local artist = inst.components.warolinedrawing.artist
		artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_BURN"))
		
		local ashes = SpawnPrefab("ash")
		if ashes ~= nil then
			ashes.Transform:SetPosition(inst.Transform:GetWorldPosition())
		end
	end
	
	if inst.components.warolinedrawing and inst.components.warolinedrawing:GetArtist() ~= nil and (inst.components.warolinedrawing:GetArtist()).components.warolineartist then
		local artist = (inst.components.warolinedrawing:GetArtist()).components.warolineartist
		if artist:HasDrawingEntity(inst) then
			--print("WarolineDrawing: Running OnRemovedDrawing")
			artist:DiscardDrawing(inst)
		end
	end
end

local WarolineDrawing = Class(function(self, inst)
    self.inst = inst
	
	self.artist = nil
	self.artist_userid = nil
	self.iscritter = false
	
	self.migration_fx_size = 0.6
	self.despawn_fx_size = 0.9
	
	self.is_fighter = false
	
	if not self.inst:HasTag("waroline_drawing") then
		self.inst:AddTag("waroline_drawing")
	end
	
	self.inst:ListenForEvent("onremove", OnRemovedDrawing)
	self.inst:ListenForEvent("death", OnRemovedDrawing)
	self.inst:ListenForEvent("attacked", OnRemovedDrawing)
	self.inst:ListenForEvent("onburnt", function(inst)
		if inst.components.warolinedrawing.artist and inst.components.warolinedrawing.artist.components.talker then
			local artist = inst.components.warolinedrawing.artist
			artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_BURN"))
		end
	end)
	
	-- basically an inherent 1 second invicibility on new spawn
	self.protectedmode = true
	self.inst:DoTaskInTime(1, function(inst)
		inst.components.warolinedrawing.protectedmode = false
	end)
end)

function WarolineDrawing:SetIsCritter(val)
	local inst = self.inst
	self.iscritter = val
	
	if inst:HasTag("_named") then
		inst:RemoveTag("_named")
	end
	
	if not inst.components.named then
		inst:AddComponent("named")
	end
	
	if self.iscritter == true then
		if inst.components.health then
			inst.components.health:SetMaxHealth(1)
			inst.components.health.canheal = false
			
			-- No cave debris damage
			inst.components.health.redirect = function (inst, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
				return afflicter ~= nil and afflicter:HasTag("quakedebris")
			end
			
		end
		
		inst:DoTaskInTime(1, function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()
			local is_boat = TheWorld.Map:GetPlatformAtPoint(x, z)
			
			local brain_name = (string.gsub(inst.prefab, "_", "")) .. "brain"
			
			local brain_land = require("brains/" .. brain_name)
			local brain_boat = require("brains/" .. brain_name .. "_boat")
			
			if is_boat and inst.brain then
				--print("WarolineDrawing: Updating brain... New brain: " .. brain_name .. "_boat")
				inst:SetBrain(brain_boat)
			elseif not is_boat and inst.brain then
				--print("WarolineDrawing: Updating brain... New brain: " .. brain_name)
				inst:SetBrain(brain_land)
			end
		end)
		
		local function ShouldSink(inst)
			if not inst:IsInLimbo() then
				local px, _, pz = inst.Transform:GetWorldPosition()
				return not TheWorld.Map:IsPassableAtPoint(px, 0, pz, false)
			end
		end
		
		-- Delay applying eventlistener to 3 seconds after spawn
		inst:DoTaskInTime(3, function(inst)
			inst:ListenForEvent("newstate", function(inst)
				local artist = inst.components.warolinedrawing and inst.components.warolinedrawing:GetArtist()
				if ShouldSink(inst) then
					if artist and artist.components.warolineartist then
						artist.components.warolineartist:DiscardDrawing(inst)
						if artist.components.talker then
							artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_WET"))
						end
					else
						local fx = SpawnPrefab("small_puff")
						if fx ~= nil then
							local size = inst.components.warolinedrawing:GetDespawnFXSize() 
							fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
							fx.Transform:SetScale(size, size, size)
						end
						inst:Remove()
					end
				end
			end)
		end)
	end
	
	if inst.components.burnable then
		inst.components.burnable.flammability = 1
		inst.components.burnable.extinguishimmediately = false
	end
	
	if inst.components.propagator then
		inst.components.propagator.acceptsheat = true
	end
	
	if inst.components.moisture == nil and not inst.components.inventoryitem then
		inst:AddComponent("moisture")
	end
	
	if not inst.components.inventoryitem then
		inst:ListenForEvent("moisturedelta", function(inst, data)
			if data and data.new then
				if data.new > 10 and inst.components.health then
					--print("Lowering health of " .. self.inst.prefab .. " by 0.1 because wetness value is " .. data.new)
					inst.components.health:DoDelta(-0.1)
					if inst.components.health:IsDead() and self.artist.components.talker then
						self.artist.components.talker:Say(GetString(self.artist, "ANNOUNCE_DRAWING_WET"))
					end
				elseif data.new > 20 and inst.components.health then
					--print("Lowering health of " .. self.inst.prefab .. " by 0.2 because wetness value is " .. data.new)
					inst.components.health:DoDelta(-0.2)
					if inst.components.health:IsDead() and self.artist.components.talker then
						self.artist.components.talker:Say(GetString(self.artist, "ANNOUNCE_DRAWING_WET"))
					end
				else
					if self.artist and self.inst.components.moisture and self.inst.components.moisture:IsWet() then
						self.artist.components.warolineartist:DiscardDrawing(self.inst)
						if self.artist.components.talker then
							self.artist.components.talker:Say(GetString(self.artist, "ANNOUNCE_DRAWING_WET"))
						end
					end
				end
			end
		end)
	else
		inst:ListenForEvent("inventoryitemmoisturedelta", function(inst)
			if inst.components.inventoryitem:IsWet() then
				if inst.ShouldDisappear ~= nil and inst.ShouldDisappear(inst) then
					if inst and inst:IsValid() and inst.components.inventoryitem:IsWet() and inst.components.warolinedrawing.artist then
						local artist = inst.components.warolinedrawing.artist
						artist.components.warolineartist:DespawnDrawing(true, inst)
						if artist.components.talker then
							artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_WET"))
						end
					end
				else
					inst:DoTaskInTime(2, function(inst)
						if inst and inst:IsValid() and inst.components.inventoryitem:IsWet() and inst.components.warolinedrawing.artist then
							local artist = inst.components.warolinedrawing.artist
							artist.components.warolineartist:DespawnDrawing(true, inst)
							if artist.components.talker then
								artist.components.talker:Say(GetString(artist, "ANNOUNCE_DRAWING_WET"))
							end
						end
					end)
				end
			end
		end)
	end
end

function WarolineDrawing:SetIsFighter()
	self.is_fighter = true
end

function WarolineDrawing:IsFighter()
	return self.is_fighter
end

function WarolineDrawing:SetSpawnFXSize(migration, despawn)
	if migration then
		self.migration_fx_size = migration
	end
	if despawn then
		self.despawn_fx_size = despawn
	end
end

function WarolineDrawing:GetDespawnFXSize()
	return self.despawn_fx_size
end

function WarolineDrawing:GetMigrationFXSize()
	return self.migration_fx_size
end

function WarolineDrawing:IsCritter()
    return self.iscritter
end

function WarolineDrawing:GetArtist()
    return self.artist
end

-- AssignArtist is to be called from the WarolineDrawing component
function WarolineDrawing:AssignArtist(artist)
    self.artist = artist
	self.artist_userid = artist.userid
	
	if self.inst.components.follower then
		self.inst.components.follower:SetLeader(artist)
	end
end

function WarolineDrawing:OnSave()
	-- snip!
	-- Save/Load is handled via warolineartist.lua
end

function WarolineDrawing:OnLoad(data)
	-- snip!
	-- Save/Load is handled via warolineartist.lua
end

return WarolineDrawing
