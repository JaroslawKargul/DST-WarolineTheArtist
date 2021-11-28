local WarolineDrawingClient = Class(function(self, inst)
    self.inst = inst
	
	if not self.inst:HasTag("waroline_drawing") then
		self.inst:AddTag("waroline_drawing")
	end
	
	if not self.inst:HasTag("notraptrigger") then
		self.inst:AddTag("notraptrigger")
	end
end)

function WarolineDrawingClient:SetUp(name)
	local inst = self.inst
	
    self.prefabname = name
	
	-- Builds while on ground
	self.builds = {
		(string.lower(self.prefabname)) .. "_1",
		(string.lower(self.prefabname)) .. "_2",
	}
	
	self.builds_current = (string.lower(self.prefabname)) .. "_1"
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("map_" .. name .. ".tex")
	
	if not self.inst:HasTag("named") then
		self.inst:AddTag("_named")
	end
	
	self.warolinedrawing_task = inst:DoPeriodicTask(.3, function(inst)
		local newbuild = inst.components.warolinedrawingclient.builds_current
		for k,v in pairs(inst.components.warolinedrawingclient.builds) do
			if v and v ~= inst.components.warolinedrawingclient.builds_current then
				newbuild = v
			end
		end
		inst.AnimState:SetBuild(newbuild)
		
		inst.components.warolinedrawingclient.builds_current = newbuild
	end)
	
	if inst:HasTag("monkey") or inst:HasTag("pig") or inst:HasTag("spider") then
		inst:ListenForEvent("equip", function(inst) if not inst:HasTag("has_hat") then inst:AddTag("has_hat") end end)
		inst:ListenForEvent("unequip", function(inst) if inst:HasTag("has_hat") then inst:RemoveTag("has_hat") end end)
	end
end

return WarolineDrawingClient
