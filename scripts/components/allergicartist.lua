
local function doallergendelta(inst, data)
	if data and data.food and data.food.prefab and data.food.components.edible then
		local food = data.food.prefab
		local allergens = inst.components.allergicartist.allergens
		local allergen_found = nil
		
		if food and allergens[food] then
			-- increase the stack only if food value is higher than 0
			local _hungervalue = (inst.components.allergicartist:GetFoodValues(data.food)).hunger
			local hungervalue = math.floor(_hungervalue)
			if hungervalue > 0 then
				inst.components.allergicartist:DoAllergyStackDelta(1)
				--print("AllergicArtist: Current food: '" .. food .. "' its allergy stack mult is: " .. inst.components.allergicartist:GetAllergyStack())
			end
			allergen_found = true
		end
		
		if not allergen_found then
			-- eaten food was not an allergen -> decrease stack of each allergen by 1 (unless it's at 1 already)
			inst.components.allergicartist:DoAllergyStackDelta(-1)
			--print("AllergicArtist: Current food: '" .. food .. "' is not an allergen! Decreasing allergy stack to: " .. inst.components.allergicartist:GetAllergyStack())
		end
	end
end

local AllergicArtist = Class(function(self, inst)
    self.inst = inst
	
	self.allergens = {}
	self.allergy_stack = 0
	
	if not self.inst:HasTag("allergic_artist") then
		self.inst:AddTag("allergic_artist")
	end
	
	self.inst:ListenForEvent("oneat", doallergendelta)
end)

-- Allergy food will apply a hunger mult each time it's eaten.
-- The mult stacks, but the stack will decrease by 1 every time non-allergy food is eaten. 
function AllergicArtist:AddAllergen(prefab, hunger_mult, sanity_damage, health_damage)
    if prefab then
		self.allergens[prefab] = {
			hunger_mult = hunger_mult or 1,
			sanity_damage = sanity_damage or 0,
			health_damage = health_damage or 0,
		}
	end
end

function AllergicArtist:DoAllergyStackDelta(delta)
	if delta < 0 and self.allergy_stack <= 0 then
		self.allergy_stack = 0
	else
		self.allergy_stack = self.allergy_stack + delta
	end
end

function AllergicArtist:GetAllergyStack()
	return self.allergy_stack
end

function AllergicArtist:GetFoodValues(food)
	local allergen = nil
	
	for k,v in pairs(self.allergens) do
		if food.prefab and k and k == food.prefab then
			allergen = v
			break
		end
	end
	
    if food.components.edible and allergen then
		local _hunger = food.components.edible.hungervalue * (allergen.hunger_mult / self:GetAllergyStack())
		local _sanity = allergen.sanity_damage
		local _health = allergen.health_damage
		
		return { hunger = _hunger, sanity = _sanity, health = _health }
		
	elseif food.components.edible and not allergen then
		return { hunger = food.components.edible.hungervalue, sanity = food.components.edible.sanityvalue, health = food.components.edible.healthvalue }
	end
end

function AllergicArtist:IsAllergicTo(food)
	local allergen = nil
	
    for k,v in pairs(self.allergens) do
		if food.prefab and k and k == food.prefab then
			allergen = v
			break
		end
	end
	
	return allergen and true or false
end

function AllergicArtist:OnSave()
	return { allergy_stack = self.allergy_stack }
end

function AllergicArtist:OnLoad(data)
	if data.allergy_stack ~= nil then
		self.allergy_stack = data.allergy_stack
    end
end

return AllergicArtist
