
-- By Stoneharry

local OBJECT_END = 0x0006
local GAMEOBJECT_BYTES_1 = OBJECT_END + 0x000B

local doorpartA = nil
local doorpartB = nil

function Guardian_Race_Events(pUnit, Event)
	if Event == 1 then
		pUnit:RegisterEvent("Crush_Enemy_GUardian", 3000, 0)
	elseif Event == 2 then
		pUnit:RemoveEvents()
	elseif Event == 4 then
		pUnit:RemoveEvents()
		-- Open Gate
		doorpartA = pUnit:GetGameObjectNearestCoords(-6495.83, -3346.4, -89.6, 180607)
		doorpartB = pUnit:GetGameObjectNearestCoords(-6497, -3332.8, 90, 181137)
		doorpartA:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		doorpartB:SetByte(GAMEOBJECT_BYTES_1,0,0) -- Open
		RegisterTimedEvent("Close_The_DORRRRRSSSSS", 200000, 1)
	end
end

function Close_The_DORRRRRSSSSS()
	if doorpartA then
		doorpartA:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
	end
	if doorpartB then
		doorpartB:SetByte(GAMEOBJECT_BYTES_1,0,1) -- Close
	end
end

function Crush_Enemy_GUardian(pUnit)
	local plr = pUnit:GetMainTank()
	if plr ~= nil then
		if math.random(1,2) == 1 then
			pUnit:FullCastSpellOnTarget(33661, plr) -- reduce armor
		else
			pUnit:FullCastSpellOnTarget(72688, plr) -- strike
		end
	end
end

RegisterUnitEvent(152631, 1, "Guardian_Race_Events")
RegisterUnitEvent(152631, 2, "Guardian_Race_Events")
RegisterUnitEvent(152631, 4, "Guardian_Race_Events")

-- Maggots

function Maggot_Spawn_Event(pUnit, Event)
	if Event ~= nil then
		if Event == 4 then
			if pUnit:HasAura(45212) then
				pUnit:RemoveAura(45212)
			end
			pUnit:RemoveEvents()
		else
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("Check_For_player_To_LEAPAT", 2500, 0)
		end
	else
		pUnit:RemoveEvents()
		pUnit:RemoveAura(45212)
		pUnit:RegisterEvent("Check_For_player_To_LEAPAT", 2500, 0)
	end
end

function Check_For_player_To_LEAPAT(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:AIDisableCombat(true) -- Requires custom patch to work
		if plr:GetDistanceYards(pUnit) < 12 then
			pUnit:RemoveEvents()
			pUnit:StopMovement(15000)
			pUnit:CastSpell(45212) -- visual
			pUnit:RegisterEvent("Spam_Damage_WhileActive", 1000, 0) 
			pUnit:RegisterEvent("Maggot_Spawn_Event", 15000, 1)
		elseif plr:GetDistanceYards(pUnit) < 60 then
			if plr:IsMounted() then
				plr:Dismount()
				plr:SendAreaTriggerMessage("|cFFFF0000A strange force is preventing you from mounting.")
			end
		end
	end
end

RegisterUnitEvent(16030, 18, "Maggot_Spawn_Event")
RegisterUnitEvent(16030, 4, "Maggot_Spawn_Event")

function Spam_Damage_WhileActive(pUnit)
	local plr = pUnit:GetClosestPlayer()
	if plr ~= nil then
		if plr:GetDistanceYards(pUnit) < 9 then
			if plr:IsAlive() then
				local damage = plr:GetMaxHealth()/6
				if damage > plr:GetHealth() or (damage-plr:GetHealth() == 0) then
					plr:CastSpell(11)
				else
					plr:SetHealth(plr:GetHealth()-damage)
					if math.random(1,2) == 1 then
						plr:CastSpell(42364) -- visual, vomit
					end
				end
			end
		end
	end
end

-- Chest

function Chest_LootTaken_Disk(object, event, pLooter, ItemId)
	object:SpawnCreature(16030, -6493, -3252, -113.5, 0, 15, 60000)
	object:SpawnCreature(16030, -6481, -3252, -113.45, 0, 15, 60000)
	object:SpawnCreature(16030, -6485, -3264, -112.4, 1.681350, 15, 60000)
end

RegisterGameObjectEvent(194789, 3, "Chest_LootTaken_Disk")
