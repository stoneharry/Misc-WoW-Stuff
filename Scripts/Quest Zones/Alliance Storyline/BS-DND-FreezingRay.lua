
function C_FreezingRay(item, event, player)
	FreezingRay(item, player)
end

function FreezingRay(item, player)
	if CooldownCheck(player, 5) == true then return end
	
	if player:IsInCombat() == false then
		player:SendAreaTriggerMessage("|cFFFF0000You need to be engaged in combat!")
		return
	end
	
	local PLAYER_TARGET = player:GetPrimaryCombatTarget()
	
	if PLAYER_TARGET ~= nil and PLAYER_TARGET:GetEntry() == 50027 and player:HasQuest(57000) == true then
		if math.random(75,100) <= 90 then
			player:CastSpellOnTarget(47700, PLAYER_TARGET)
			--PLAYER_TARGET:Despawn(3001, 45000)
			--PLAYER_TARGET:RegisterEvent("SelfKillElemental", 3000, 1)
			player:AdvanceQuestObjective(57000, 0)
		else
			SetDBCSpellVar(64175, "c_is_flags", 0x1000)
			player:CastSpell(64175)
		end
	elseif PLAYER_TARGET ~= nil and PLAYER_TARGET:GetEntry() == 50005 and player:HasQuest(57001) then
			player:Kill(PLAYER_TARGET)
			local x = player:GetX()
			local y = player:GetY()
			local z = player:GetZ()
			local o = player:GetO()
			local MotherDrake = player:GetUnitBySqlId(390139)
			if MotherDrake ~= nil then
				MotherDrake:MoveTo(x, y, z, o)
				MotherDrake:SendChatMessage(14, 0, "Who dares disturb my whelplings? Incompetent wardens... I shall deal with you myself!")
			end
			player:SpawnCreature(57001, x, y, z, o, 1, 60000)
	else
		player:SendAreaTriggerMessage("|cFFFF0000Wrong target!")
	end

	CooldownTime[player:GetName()] = os.clock()
end
--[[
function SelfKillElemental(pUnit, event)
	print("Self kill of 50027 initiated.")
	pUnit:CastSpellOnTarget(13341, pUnit)
end]]

RegisterItemGossipEvent(57000, 1, "C_FreezingRay")

function C_CrystalOrb(item, event, player)
	CrystalOrb(item, player)
end

function CrystalOrb(item, player)
	if player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 14495) == nil then return end
	if player:GetDistanceYards(player:GetCreatureNearestCoords(player:GetX(), player:GetY(), player:GetZ(), 14495)) <= 12 and player:HasQuest(56999) then
		player:CastSpell(19823)
		player:RemoveItem(56999, 1)
		player:AddItem(56998, 1)
	else
		player:SendAreaTriggerMessage("|cFFFF0000You need to be in the lava pit at the top of Dreadmaul Rock!")
	end
end

RegisterItemGossipEvent(56999, 1, "C_CrystalOrb")

function XRRobot_CombatLeave(pUnit, event)
	pUnit:SendChatMessage(12, 0, "-BZZT- Initiating exiting functions.")
	pUnit:Despawn(5000, 0)
end

function MotherDrake_Combat(pUnit, event)
	pUnit:RegisterEvent("MD_FlameBreath", 12000, 0)
end

function MD_FlameBreath(pUnit, event)
	pUnit:FullCastSpell(51219)
end

function MotherDrake_CombatLeave(pUnit, event)
	pUnit:ReturnToSpawnPoint()
	pUnit:RemoveEvents()
end

RegisterUnitEvent(57003, 2, "MotherDrake_CombatLeave")
RegisterUnitEvent(57003, 1, "MotherDrake_Combat")
RegisterUnitEvent(57001, 2, "XRRobot_CombatLeave")

